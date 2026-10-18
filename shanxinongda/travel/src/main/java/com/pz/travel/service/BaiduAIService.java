package com.pz.travel.service;

import com.alibaba.fastjson.JSON;
import com.baidu.aip.imagesearch.AipImageSearch;
import com.google.common.util.concurrent.RateLimiter;
import com.pz.travel.config.properties.BaiduProperties;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.HashMap;

@Service
@Slf4j
public class BaiduAIService {
    final RateLimiter rateLimiter = RateLimiter.create(0.7);

    @Autowired
    private BaiduProperties baiduProperties;

    private AipImageSearch client;

    @PostConstruct
    public void init(){
        client = new AipImageSearch(baiduProperties.getAppId(), baiduProperties.getApiKey(), baiduProperties.getSecretKey());
        //设置网络连接参数
        client.setConnectionTimeoutInMillis(2000);
        client.setSocketTimeoutInMillis(30000);
    }

    /**
     * 相似图片入库
     * @throws Exception
     */
    public AddResult imageAdd(String[] tags, String name, String id, String url) throws Exception {
        if (StringUtils.isBlank(url)) {
            throw new com.ruoyi.common.exception.CustomException("图片地址为空，请先上传图片");
        }
        // 传入可选参数调用接口
        HashMap<String, String> options = new HashMap<>();
        if(tags!=null && tags.length > 0){
            options.put("tags", StringUtils.join(tags, ','));
        }
        com.alibaba.fastjson.JSONObject jsonObject = new com.alibaba.fastjson.JSONObject();
        jsonObject.put("name", name);
        jsonObject.put("id", id);
        jsonObject.put("url", url);
        rateLimiter.acquire();
        JSONObject res = client.similarAddUrl(url, JSON.toJSONString(jsonObject), options);
        log.info("相似图片入库，响应内容:{}", res.toString(2));
        if(!res.has("error_msg")) {
            AddResult result = new AddResult();
            result.contSign = res.getString("cont_sign");
            return result;
        }
        String errorMsg = res.getString("error_msg");
        log.error("相似图片入库失败id:{},name:{},url:{},{}", id, name, url, errorMsg);
        // item has existed：图片已在百度库（常见于删除有延迟后重新添加同一张图）。
        // 搜索取回旧记录的 cont_sign 和 brief.id，上层复用旧 id 写库即可，无需删百度记录
        if ("item has existed".equalsIgnoreCase(errorMsg.trim())) {
            AddResult exist = findExistByUrl(tags, url);
            if (exist != null) {
                log.info("图片已存在于百度库，复用 cont_sign:{}, brief.id:{}", exist.contSign, exist.briefId);
                return exist;
            }
            throw new com.ruoyi.common.exception.CustomException("该图片已在识别库中，请勿重复添加（或稍后几分钟再试）");
        }
        // 把百度的其他真实错误透传给前端，便于定位（如图片过大、格式不支持等）
        throw new com.ruoyi.common.exception.CustomException("识别库入库失败：" + errorMsg);
    }

    /**
     * 通过图片 URL 在百度库中搜索已存在的记录，取回 cont_sign 与 brief.id
     */
    private AddResult findExistByUrl(String[] tags, String url) {
        try {
            HashMap<String, String> options = new HashMap<>();
            if (tags != null && tags.length > 0) {
                options.put("tags", StringUtils.join(tags, ','));
                options.put("tag_logic", "0");
            }
            options.put("pn", "0");
            options.put("rn", "1");
            rateLimiter.acquire();
            JSONObject res = client.similarSearchUrl(url, options);
            if (res.optInt("result_num", 0) > 0) {
                JSONObject first = res.getJSONArray("result").getJSONObject(0);
                AddResult result = new AddResult();
                result.contSign = first.optString("cont_sign");
                String brief = first.optString("brief");
                if (StringUtils.isNotBlank(brief)) {
                    com.alibaba.fastjson.JSONObject briefJson = JSON.parseObject(brief);
                    result.briefId = briefJson.getLong("id");
                }
                return result;
            }
        } catch (Exception e) {
            log.error("搜索已存在图片记录失败:{}", url, e);
        }
        return null;
    }

    /**
     * 入库结果。正常新增时 briefId 为 null（上层用新雪花 ID）；
     * 图片已存在时 briefId 为百度库中旧记录的 ID，上层应复用该 ID 写库
     */
    public static class AddResult {
        public String contSign;
        public Long briefId;
        public boolean isReused() { return briefId != null; }
    }

    /**
     * 相似图片搜索
     */
    public JSONArray imageSearch(String[] tags, byte[] file){
        // 传入可选参数调用接口
        HashMap<String, String> options = new HashMap<>();
        if(tags!=null && tags.length > 0){
            options.put("tags", StringUtils.join(tags, ','));
            options.put("tag_logic", "0");
        }
        options.put("pn", "0");
        options.put("rn", "10");

        JSONObject res = client.similarSearch(file, options);
        log.info("相似图片搜索，响应内容:{}", res.toString(2));
        // 百度返回错误体（如 216630 recognize error / openapi 未开通）时不含 result_num，
        // 直接 getInt 会抛异常导致接口 500；这里改为返回 null，让上层走经纬度/推荐兜底
        if (!res.has("result_num")) {
            log.warn("相似图片搜索失败：{}", res.optString("error_msg"));
            return null;
        }
        if(res.getInt("result_num") > 0){
            return res.getJSONArray("result");
        }
        return null;
    }

    /**
     * 相似图片删除
     * @param contSign
     */
    public Boolean imageDelete(String contSign) {
        // 传入可选参数调用接口
        HashMap<String, String> options = new HashMap<>();
        // 删除相似图，传入参数为图片签名
        rateLimiter.acquire();
        JSONObject res = client.similarDeleteBySign(contSign, options);
        log.info("相似图片删除，contSign:{},响应内容:{}", contSign, res.toString(2));
        if(res.has("error_msg")) {
            String errorMsg = res.getString("error_msg");
            log.error("相似图片删除失败contSign:{},{}", contSign, errorMsg);
        }
        return !res.has("error_code");
    }
}
