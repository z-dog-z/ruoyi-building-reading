package com.pz.travel.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.google.common.collect.Interner;
import com.google.common.collect.Interners;
import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.common.CommonResult;
import com.pz.travel.config.WxMaConfiguration;
import com.pz.travel.domain.vo.LoginResponseVo;
import com.ruoyi.common.core.domain.entity.BookUser;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.framework.security.PzBCryptPasswordEncoder;
import com.ruoyi.framework.web.service.SysLoginService;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.system.mapper.BookUserMapper;
import com.ruoyi.system.service.ISysUserService;
import me.chanjar.weixin.common.error.WxErrorException;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 微信小程序用户接口
 */
@RestController
@RequestMapping("/wx/user/{appid}")
public class WxMaUserController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private Interner<String> openIdPool = Interners.newWeakInterner();
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private BookUserMapper bookUserMapper;

    @Autowired
    private IdWorker idWorker;

    @Value("${travel.wx.mock-login.enabled:false}")
    private boolean mockLoginEnabled;

    @Value("${travel.wx.mock-login.open-id:local-dev-openid}")
    private String mockLoginOpenId;

    @Value("${travel.wx.mock-login.session-key:local-dev-session-key}")
    private String mockLoginSessionKey;

    /**
     * 登陆接口
     * @param appid appid
     * @param code 录时获取的code
     * @return
     */
    @GetMapping("/login")
    public CommonResult<LoginResponseVo> login(@PathVariable String appid, String code, HttpServletRequest request) {
        if (mockLoginEnabled) {
            logger.warn("微信小程序本地 mock 登录已启用，appid: {}", appid);
            return localMockLogin(request);
        }

        if (StringUtils.isBlank(code)) {
            return CommonResult.fail().setResult("empty jscode");
        }

        final WxMaService wxService = WxMaConfiguration.getMaService(appid);

        try {
            logger.info("wx start:{}", DateUtils.getTime());
            WxMaJscode2SessionResult session = wxService.getUserService().getSessionInfo(code);
            logger.info("wx end:{}", DateUtils.getTime());
            this.logger.info("sessionKey:{}", session.getSessionKey());
            this.logger.info("openId:{}", session.getOpenid());
            LoginResponseVo loginResponseVo = new LoginResponseVo();
            BeanUtils.copyProperties(session, loginResponseVo);
            //可以增加自己的逻辑，关联业务相关数据
            completeLogin(loginResponseVo, session.getOpenid(), session.getUnionid(), request);
            return CommonResult.ok().setResult(loginResponseVo);
        } catch (WxErrorException e) {
            this.logger.error(e.getMessage(), e);
            return CommonResult.fail().setResult(e.getMessage());
        }
    }

    private CommonResult<LoginResponseVo> localMockLogin(HttpServletRequest request) {
        LoginResponseVo loginResponseVo = new LoginResponseVo();
        loginResponseVo.setOpenid(mockLoginOpenId);
        loginResponseVo.setSessionKey(mockLoginSessionKey);
        completeLogin(loginResponseVo, mockLoginOpenId, null, request);
        return CommonResult.ok().setResult(loginResponseVo);
    }

    private void completeLogin(LoginResponseVo loginResponseVo, String openId, String unionId, HttpServletRequest request) {
        SysUser sysUser;
        synchronized (openIdPool.intern(openId)) {
            sysUser = sysUserService.selectUserByOpenId(openId);
            loginResponseVo.setFirstLogin(false);
            if (sysUser == null) {
                // 创建小程序用户
                sysUser = new SysUser();
                sysUser.setOpenId(openId);
                sysUser.setUnionId(unionId);
                sysUser.setSource(1);
                sysUser.setCreateBy("1");
                sysUser.setCreateTime(new Date());
                sysUserService.insertUser(sysUser);
                sysUser = sysUserService.selectUserByOpenId(openId);
                loginResponseVo.setFirstLogin(true);
            } else {
                SysUser userForUpdate = new SysUser();
                userForUpdate.setUserId(sysUser.getUserId());
                userForUpdate.setLoginIp(IpUtils.getIpAddr(request));
                userForUpdate.setLoginDate(new Date());
                sysUserService.updateUserProfile(userForUpdate);
            }
        }

        // 生成令牌
        PzBCryptPasswordEncoder.tl.set(openId);
        String token = loginService.login(openId);
        loginResponseVo.setToken(token);
    }




    /**
     * 更新用户unionId
     * @param appid appid
     * @param sessionKey 会话密钥
     * @param signature 数据签名
     * @param rawData 微信用户基本信息
     * @param encryptedData 消息密文
     * @param iv 加密算法的初始向量
     * @return
     */
    @PostMapping("/updateUnionId")
    public CommonResult<Boolean> updateUnionId(@PathVariable String appid, String sessionKey,
                                      String signature, String rawData, String encryptedData, String iv) {
        final WxMaService wxService = WxMaConfiguration.getMaService(appid);

        // 用户信息校验
        if (!wxService.getUserService().checkUserInfo(sessionKey, rawData, signature)) {
            return CommonResult.fail().setResult("user check failed");
        }

        // 解密用户信息
        WxMaUserInfo userInfo = wxService.getUserService().getUserInfo(sessionKey, encryptedData, iv);
        logger.info("用户信息：{}", userInfo);
        LoginUser loginUser = SecurityUtils.getLoginUser();

        SysUser userForUpdate = new SysUser();
        userForUpdate.setUserId(loginUser.getUser().getUserId());
        userForUpdate.setUnionId(userInfo.getUnionId());
        sysUserService.updateUserProfile(userForUpdate);

        loginUser.getUser().setUnionId(userInfo.getUnionId());
        tokenService.setLoginUser(loginUser);
        return CommonResult.ok().setResult(true);
    }

    /**
     * 获取用户绑定手机号信息
     * @param appid appid
     * @param sessionKey 会话密钥
     * @param encryptedData 消息密文
     * @param iv 加密算法的初始向量
     * @return
     */
    @PostMapping("/phone")
    public CommonResult<Boolean> phone(@PathVariable String appid, String sessionKey, String encryptedData, String iv, HttpServletRequest request) {
        final WxMaService wxService = WxMaConfiguration.getMaService(appid);
        LoginResponseVo loginResponseVo = new LoginResponseVo();

        // 解密
        WxMaPhoneNumberInfo phoneNoInfo = wxService.getUserService().getPhoneNoInfo(sessionKey, encryptedData, iv);
        if(StringUtils.isNotBlank(phoneNoInfo.getPhoneNumber())){
            LoginUser loginUser = SecurityUtils.getLoginUser();
            SysUser sysUser = new SysUser();
            sysUser.setUserId(loginUser.getUser().getUserId());
            sysUser.setPhonenumber(phoneNoInfo.getPhoneNumber());
            sysUserService.updateUserProfile(sysUser);
            loginUser.getUser().setPhonenumber(phoneNoInfo.getPhoneNumber());

            BookUser bookUser = bookUserMapper.selectUserByPhone(phoneNoInfo.getPhoneNumber());
            if(bookUser == null) {
                bookUser = new BookUser();
                bookUser.setId(idWorker.nextId());
                bookUser.setPhone(phoneNoInfo.getPhoneNumber());
                bookUser.setCreateBy("1");
                bookUser.setCreateTime(new Date());
                bookUserMapper.insertUser(bookUser);
            }
            loginUser.setBookUser(bookUser);
            tokenService.setLoginUser(loginUser);

            return CommonResult.ok().setResult(true);
        }else {
            return CommonResult.ok().setResult(false);
        }
    }

}
