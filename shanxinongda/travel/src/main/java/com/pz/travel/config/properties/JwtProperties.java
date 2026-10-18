package com.pz.travel.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "cris.jwt")
@Data
public class JwtProperties {

    /**
     * 用户端生成jwt令牌相关配置
     */
    private String secret;
    private long expireTime;
    private String header;

}
