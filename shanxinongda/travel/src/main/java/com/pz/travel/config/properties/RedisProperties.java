package com.pz.travel.config.properties;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * redis配置属性
 */
@Component
@ConfigurationProperties(prefix = "spring.redis")
@Data
public class RedisProperties {
    private String host;
    private Integer port;
    private String password;
    private Integer database;

}
