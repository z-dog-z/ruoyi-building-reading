package com.pz.travel.framework.cloud;

import com.alibaba.fastjson.JSON;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.system.service.ISysConfigService;


/**
 * 文件上传Factory
 */
public final class OSSFactory {
    private static ISysConfigService sysConfigService;
    static {
       OSSFactory.sysConfigService = SpringUtils.getBean(ISysConfigService.class);
    }

    public static CloudStorageService build() {
        String jsonconfig = sysConfigService.selectConfigByKey(CloudConstant.CLOUD_STORAGE_CONFIG_KEY);
        // 获取云存储配置信息
        CloudStorageConfig config = JSON.parseObject(jsonconfig, CloudStorageConfig.class);
        if (CloudConstant.CloudService.ALIYUN.getValue().equalsIgnoreCase(config.getType())) {
            return new AliyunCloudStorageService(config);
        }else if(CloudConstant.CloudService.HUAWEI.getValue().equalsIgnoreCase(config.getType())) {
            return new HuaweiCloudStorageService(config);
        }
        return null;
    }
}
