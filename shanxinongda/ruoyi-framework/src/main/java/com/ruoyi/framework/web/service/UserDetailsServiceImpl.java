package com.ruoyi.framework.web.service;

import com.ruoyi.common.core.domain.entity.BookUser;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.enums.UserStatus;
import com.ruoyi.common.exception.BaseException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.mapper.BookUserMapper;
import com.ruoyi.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 用户验证处理
 *
 * @author ruoyi
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService
{
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private BookUserMapper bookUserMapper;

    @Autowired
    private SysPermissionService permissionService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        SysUser user = userService.selectUserByUserName(username);
        if(user == null){
            user = userService.selectUserByOpenId(username);
        }
        if(user == null){
            user = userService.selectUserByPhone(username);
        }
        BookUser bookUser = null;
        if(user != null && org.apache.commons.lang3.StringUtils.isNotBlank(user.getPhonenumber())) {
            bookUser = bookUserMapper.selectUserByPhone(user.getPhonenumber());
        }
        if(bookUser == null) {
            bookUser = bookUserMapper.selectUserByPhone(username);
        }


        if (StringUtils.isNull(user) && StringUtils.isNull(bookUser))
        {
            log.info("登录用户：{} 不存在.", username);
            throw new UsernameNotFoundException("登录用户：" + username + " 不存在");
        }else if(user != null){
            if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
            {
                log.info("登录用户：{} 已被删除.", username);
                throw new BaseException("对不起，您的账号：" + username + " 已被删除");
            }
            else if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
            {
                log.info("登录用户：{} 已被停用.", username);
                throw new BaseException("对不起，您的账号：" + username + " 已停用");
            }
        }

        return createLoginUser(user, bookUser);
    }

    public UserDetails createLoginUser(SysUser user, BookUser bookUser)
    {
        return new LoginUser(user, bookUser, permissionService.getMenuPermission(user));
    }
}
