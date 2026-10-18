package com.ruoyi.common.filter;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

@Slf4j
@Component
public class HttpAlertFilter implements Filter {

    /**
     * 报警通知@手机号
     */
    public static final String[] atMoibles = new String[]{"17602187835"};
    public static String dingtalkRobotUrl = "https://oapi.dingtalk.com/robot/send?access_token=c77f79f960113e6fbbd951ad81b5d5a6385b0ee554735bdafd77eeaf2e866349";

    @Autowired
    private RestTemplate restTemplate;
    @Value("${spring.profiles.active}")
    private String env;

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String uri = request.getRequestURI();

        long startTime = System.currentTimeMillis();
        chain.doFilter(servletRequest, response);
        long latency = System.currentTimeMillis() - startTime;
        if("prod".equalsIgnoreCase(env) && latency > 5000 && !uri.contains("/backend/recognitionLibrary/storage/") && !uri.contains("/backend/recognitionLibrary/delete")) {
            //发送报警
            try {

                StringBuilder sb = new StringBuilder();
                sb.append("业务报警");
                sb.append("\r\n");
                sb.append("时间:").append(DateUtils.getTime());
                sb.append("\r\n");
                sb.append("项目:").append("建筑可阅读");
                sb.append("\r\n");
                sb.append("环境:").append(env);
                sb.append("\r\n");
                sb.append("接口:").append(uri);
                sb.append("\r\n");
                sb.append("耗时:").append(latency).append("ms");

                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(MediaType.APPLICATION_JSON);

                JSONObject requestBody = new JSONObject();
                requestBody.put("msgtype", "text");
                JSONObject text = new JSONObject();
                text.put("content", sb.toString());
                requestBody.put("text", text);
                JSONObject at = new JSONObject();
                at.put("atMobiles", atMoibles);
                requestBody.put("at", at);

                HttpEntity<Map<String, String>> restRequest = new HttpEntity(requestBody, headers);
                new Thread(()->{
                    String responseBody = "";
                    try {
                        ResponseEntity<String> restResponse = restTemplate.postForEntity(dingtalkRobotUrl, restRequest, String.class);
                        responseBody = restResponse.getBody();
                    } finally {
                        log.info("调用钉钉接口，请求内容:{}, 响应内容:{}", JSON.toJSONString(requestBody), responseBody);
                    }
                }).start();
            }catch (Exception e) {
                log.error("", e);
            }
        }
    }
}
