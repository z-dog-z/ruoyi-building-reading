package com.pz.travel.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * 百度图片搜索配置属性
 */
@Component
@ConfigurationProperties(prefix = "baidu")
@Data
public class BaiduProperties {
    private String appId;
    private String apiKey;
    private String secretKey;
}
