package com.ruoyi.web.core.config;

import com.ruoyi.common.utils.IdWorker;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ProjectConfig {

    @Bean
    public IdWorker worker(){
        IdWorker worker = new IdWorker(1,2,1);
        return worker;
    }
}

