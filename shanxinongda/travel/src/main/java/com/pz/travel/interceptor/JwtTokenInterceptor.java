package com.pz.travel.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pz.travel.config.properties.JwtProperties;
import com.pz.travel.constant.JwtClaimsConstant;
import com.pz.travel.context.BaseContext;
import com.pz.travel.utils.JwtUtil;
import com.ruoyi.common.exception.BaseException;
import io.jsonwebtoken.Claims;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

import static com.pz.travel.constant.RedisConstant.JWT_BLACK_LIST;

/**
 * jwt令牌校验的拦截器
 */
@Component
@Slf4j
public class JwtTokenInterceptor implements HandlerInterceptor {

    @Autowired
    private JwtProperties jwtProperties;

    // 注入ObjectMapper用于JSON序列化
    @Autowired
    private ObjectMapper objectMapper;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    /**
     * 校验jwt
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //判断当前拦截到的是Controller的方法还是其他资源
        if (!(handler instanceof HandlerMethod)) {
            //当前拦截到的不是动态方法，直接放行
            return true;
        }

        //1、从请求头中获取令牌
        String token = request.getHeader(jwtProperties.getHeader());

        //2、校验令牌
        try {
            if (stringRedisTemplate.hasKey(JWT_BLACK_LIST + token)) {
               throw new BaseException("token无效");
            }
            log.info("jwt校验:{}", token);
            Claims claims = JwtUtil.parseJWT(jwtProperties.getSecret(), token);
            Long userId = Long.valueOf(claims.get(JwtClaimsConstant.USER_ID).toString());
            log.info("当前用户的id：", userId);
            BaseContext.setCurrentId(userId);
            //3、通过，放行
            return true;
        } catch (Exception ex) {
            // 4、不通过，返回JSON格式的错误响应
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401状态码
            response.setContentType(MediaType.APPLICATION_JSON_VALUE); // 设置Content-Type为JSON
            response.setCharacterEncoding("UTF-8"); // 防止中文乱码

            // 构造响应体
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("code", 401);
            errorResponse.put("msg", "token无效或已过期");
            errorResponse.put("data", null);

            // 将Map序列化为JSON字符串并写入响应
            String jsonResponse = objectMapper.writeValueAsString(errorResponse);
            response.getWriter().write(jsonResponse);

            return false;
        }
    }
}
