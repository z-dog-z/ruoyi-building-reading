package com.ruoyi.common.filter;

import com.alibaba.fastjson.JSON;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;
import org.springframework.web.util.WebUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Slf4j
@Component
public class HttpTraceLogFilter implements Filter {

    private static final String NEED_TRACE_PATH_PREFIX = "/";
    private static final String IGNORE_CONTENT_TYPE = "multipart/form-data";
    private static final Set<String> IGNORE_PATHS = new HashSet<>();


    static {
    }

    public HttpTraceLogFilter() {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        LocalDateTime startDateTime = LocalDateTime.now();
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        if (!isRequestValid(request)) {
            chain.doFilter(request, response);
            return;
        }
        if (!(request instanceof ContentCachingRequestWrapper)) {
            request = new ContentCachingRequestWrapper(request);
        }
        if (!(response instanceof ContentCachingResponseWrapper)) {
            response = new ContentCachingResponseWrapper(response);
        }
        int status = HttpStatus.INTERNAL_SERVER_ERROR.value();
        long startTime = System.currentTimeMillis();
        try {
            chain.doFilter(request, response);
            status = response.getStatus();
        } finally {
            String path = request.getRequestURI();
            if (path.startsWith(NEED_TRACE_PATH_PREFIX) && !IGNORE_PATHS.contains(path)) {
                HttpTraceLog traceLog = new HttpTraceLog();
                traceLog.setPath(path);
                traceLog.setMethod(request.getMethod());
                long latency = System.currentTimeMillis() - startTime;
                traceLog.setTimeTaken(latency);
                traceLog.setStarttime(startDateTime.toString());
                traceLog.setTime(LocalDateTime.now().toString());
                traceLog.setParameterMap(JSON.toJSONString(request.getParameterMap()));
                traceLog.setStatus(status);
                if (!Objects.equals(IGNORE_CONTENT_TYPE, request.getContentType())) {
                    traceLog.setRequestBody(getRequestBody(request));
                }
                traceLog.setResponseBody(getResponseBody(response));
                if (traceLog.getRequestBody() != null && traceLog.getRequestBody().length() > 10000) {
                    traceLog.setRequestBody(null);
                }
                if (traceLog.getResponseBody() != null && traceLog.getResponseBody().length() > 10000) {
                    traceLog.setResponseBody(null);
                }
                log.info("Http trace log: {}", JSON.toJSONString(traceLog));
            }
            updateResponse(response);
        }
    }

    private boolean isRequestValid(HttpServletRequest request) {
        try {
            new URI(request.getRequestURL().toString());
            return true;
        } catch (URISyntaxException ex) {
            return false;
        }
    }

    private String getRequestBody(HttpServletRequest request) {
        String requestBody = "";
        ContentCachingRequestWrapper wrapper = WebUtils.getNativeRequest(request, ContentCachingRequestWrapper.class);
        if (wrapper != null) {
            try {
                requestBody = IOUtils.toString(wrapper.getContentAsByteArray(), "utf-8");
            } catch (IOException e) {
                // NOOP
            }
        }
        return requestBody;
    }

    private String getResponseBody(HttpServletResponse response) {
        String responseBody = "";
        ContentCachingResponseWrapper wrapper = WebUtils.getNativeResponse(response, ContentCachingResponseWrapper.class);
        if (wrapper != null) {
            try {
                responseBody = IOUtils.toString(wrapper.getContentAsByteArray(), "utf-8");
            } catch (IOException e) {
                // NOOP
            }
        }
        return responseBody;
    }

    private void updateResponse(HttpServletResponse response) throws IOException {
        ContentCachingResponseWrapper responseWrapper = WebUtils.getNativeResponse(response, ContentCachingResponseWrapper.class);
        Objects.requireNonNull(responseWrapper).copyBodyToResponse();
    }


    @Data
    private static class HttpTraceLog {
        private String path;
        private String parameterMap;
        private String method;
        private Long timeTaken;
        private String starttime;
        private String time;
        private Integer status;
        private String requestBody;
        private String responseBody;
    }
}

