package com.pz.travel.framework.cloud;

import com.obs.services.ObsClient;
import com.obs.services.ObsConfiguration;
import com.obs.services.model.AuthTypeEnum;
import com.ruoyi.common.exception.OssException;
import lombok.extern.slf4j.Slf4j;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * 华为云存储
 */
@Slf4j
public class HuaweiCloudStorageService extends CloudStorageService {
    private static ObsClient obsClient;
    private static AuthTypeEnum authType = AuthTypeEnum.OBS;

    public HuaweiCloudStorageService(CloudStorageConfig config) {
        this.config = config;
        // 初始化
        init();
    }

    private void init() {
        ObsConfiguration obsConfiguration = new ObsConfiguration();
        obsConfiguration.setEndPoint(config.getHuaweiEndPoint());
        obsConfiguration.setAuthType(authType);
        obsClient = new ObsClient(config.getHuaweiAccessKeyId(), config.getHuaweiAccessKeySecret(), obsConfiguration);
    }

    @Override
    public String upload(byte[] data, String path) {
        return upload(new ByteArrayInputStream(data), path);
    }

    @Override
    public String upload(InputStream inputStream, String path) {
        try {
            obsClient.putObject(config.getHuaweiBucketName(), path, inputStream);
        } catch (Exception e) {
            log.error("上传文件失败", e);
            throw new OssException("上传文件失败，请检查配置信息");
        }
        return config.getHuaweiDomain() + "/" + path;
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getHuaweiPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getHuaweiPrefix(), suffix));
    }
}
