package com.pz.travel.config;

import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.InputStream;

@Slf4j
@Service
public class FreemarkerService {
    public Configuration configure;

    public FreemarkerService(){
//       configure=new Configuration(Configuration.VERSION_2_3_22);
        configure = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        configure.setDefaultEncoding("utf-8");
        //设置模板装置方法和路径，FreeMarker支持多种模板装载方法。可以从servlet，classpath,数据库装载。
        configure.setClassForTemplateLoading(this.getClass(), "/");
        //设置对象包装器
        //configure.setObjectWrapper(new DefaultObjectWrapper());
        //设置异常处理器
        configure.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
    }

    public Configuration getConfigure() {
        return configure;
    }

    /**
     * 获取图片base64
     * @param imgFile
     * @return
     */
    public String getImageStr(String imgFile){
        byte[] data = null;
        try(InputStream in = new FileInputStream(imgFile)) {
            data=new byte[in.available()];
            in.read(data);
        } catch (Exception e) {
            log.error("", e);
            return null;
        }
        return Base64.encodeBase64String(data);
    }
}
