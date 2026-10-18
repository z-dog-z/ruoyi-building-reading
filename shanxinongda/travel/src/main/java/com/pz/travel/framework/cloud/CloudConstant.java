package com.pz.travel.framework.cloud;

public class CloudConstant {
    /**
     * 云存储配置KEY
     */
    public final static String CLOUD_STORAGE_CONFIG_KEY = "sys.oss.cloudStorage";

    /**
       * 云服务商
       */
    public enum CloudService {
        /**
         * 七牛云
         */
        QINIU("1"),
        /**
         * 阿里云
         */
        ALIYUN("2"),
        /**
         * 腾讯云
         */
        QCLOUD("3"),
        /**
         * 华为云
         */
        HUAWEI("4");

        private String value;

        CloudService(String value)
        {
            this.value = value;
        }

        public String getValue()
        {
            return value;
        }
    }
}
