package com.pz.travel.config;

import com.github.binarywang.wxpay.config.WxPayConfig;
import com.github.binarywang.wxpay.service.WxPayService;
import com.github.binarywang.wxpay.service.impl.WxPayServiceImpl;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Configuration
@ConditionalOnClass(WxPayService.class)
@EnableConfigurationProperties(WxPayProperties.class)
public class WxPayConfiguration {
    private final WxPayProperties properties;

    @ConditionalOnMissingBean
    @Bean
    public WxPayService wxService() {
        final List<WxPayProperties.WpConfig> configs = this.properties.getConfigs();
        if (configs == null) {
            throw new RuntimeException("大哥，拜托先看下项目首页的说明（readme文件），添加下相关配置，注意别配错了！");
        }

        WxPayService wxPayService = new WxPayServiceImpl();
        wxPayService.setMultiConfig(configs
                .stream().map(config -> {
                    WxPayConfig payConfig = new WxPayConfig();
                    payConfig.setAppId(StringUtils.trimToNull(config.getAppId()));
                    payConfig.setMchId(StringUtils.trimToNull(config.getMchId()));
                    payConfig.setMchKey(StringUtils.trimToNull(config.getMchKey()));
                    payConfig.setSubAppId(StringUtils.trimToNull(config.getSubAppId()));
                    payConfig.setSubMchId(StringUtils.trimToNull(config.getSubMchId()));
                    payConfig.setKeyPath(StringUtils.trimToNull(config.getKeyPath()));
                    // 可以指定是否使用沙箱环境
                    payConfig.setUseSandboxEnv(false);
                    return payConfig;
                }).collect(Collectors.toMap(WxPayConfig::getAppId, a -> a, (o, n) -> o))
        , configs.get(0).getMchId());
        return wxPayService;
    }
}
