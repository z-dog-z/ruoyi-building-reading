package com.pz.travel.framework.cloud;

import com.aliyun.oss.OSSClient;
import com.ruoyi.common.exception.OssException;
import lombok.extern.slf4j.Slf4j;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * 阿里云存储
 */
@Slf4j
public class AliyunCloudStorageService extends CloudStorageService {
    private OSSClient client;

    public AliyunCloudStorageService(CloudStorageConfig config) {
        this.config = config;
        // 初始化
        init();
    }

    private void init() {
        client = new OSSClient(config.getAliyunEndPoint(), config.getAliyunAccessKeyId(),
                config.getAliyunAccessKeySecret());
    }

    @Override
    public String upload(byte[] data, String path) {
        return upload(new ByteArrayInputStream(data), path);
    }

    @Override
    public String upload(InputStream inputStream, String path) {
        try {
            client.putObject(config.getAliyunBucketName(), path, inputStream);
        } catch (Exception e) {
            log.error("上传文件失败", e);
            throw new OssException("上传文件失败，请检查配置信息");
        }
        return config.getAliyunDomain() + "/" + path;
    }

    @Override
    public String uploadSuffix(byte[] data, String suffix) {
        return upload(data, getPath(config.getAliyunPrefix(), suffix));
    }

    @Override
    public String uploadSuffix(InputStream inputStream, String suffix) {
        return upload(inputStream, getPath(config.getAliyunPrefix(), suffix));
    }
}
