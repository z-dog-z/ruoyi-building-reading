package com.pz.travel.domain.vo;

import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import lombok.Data;

@Data
public class LoginResponseVo extends WxMaJscode2SessionResult {
    /**
     * 用户token，每次登录都会生成唯一的token
     */
    private String token;

    /**
     * 是否第一次登录
     */
    private boolean firstLogin;

}
