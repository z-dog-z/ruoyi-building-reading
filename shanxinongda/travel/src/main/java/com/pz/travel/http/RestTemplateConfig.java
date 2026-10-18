package com.pz.travel.http;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.log4j.Log4j2;
import org.apache.http.impl.client.CloseableHttpClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.DefaultResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * RestTemplate客户端连接池配置
 *
 */
@Configuration
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class RestTemplateConfig {

    @Resource
    private CloseableHttpClient httpClient;

    @Bean
    public RestTemplate restTemplate() {
        RestTemplate restTemplate = new RestTemplate(clientHttpRequestFactory());
        restTemplate.setErrorHandler(new CustomErrorHandler());

        restTemplate.getMessageConverters().set(1, new StringHttpMessageConverter(StandardCharsets.UTF_8));
        //restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
        //restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("GBK")));
        /*
        List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
        StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter(Charset.forName("utf-8"));
        messageConverters.add(stringHttpMessageConverter);
        messageConverters.add(jackson2HttpMessageConverter);
        restTemplate.setMessageConverters(messageConverters);
        */
        //restTemplate.getMessageConverters().add(0, mappingJacksonHttpMessageConverter());
        return restTemplate;
    }

    /*
    @Bean
    public MappingJackson2HttpMessageConverter mappingJacksonHttpMessageConverter() {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.set
        converter.setObjectMapper(objectMapper);
        return converter;
    }
     */

    @Log4j2
    public static class CustomErrorHandler extends DefaultResponseErrorHandler {
        @Override
        public void handleError(ClientHttpResponse response) throws IOException {
            log.error("restTemplate请求发生错误,{}  {}", response.getStatusText(), response.getBody());
            super.handleError(response);
        }
    }

    @Bean
    public HttpComponentsClientHttpRequestFactory clientHttpRequestFactory() {
        HttpComponentsClientHttpRequestFactory rf = new HttpComponentsClientHttpRequestFactory();
        rf.setHttpClient(httpClient);
        return rf;
    }

}