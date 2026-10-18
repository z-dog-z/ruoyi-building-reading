package com.ruoyi.common.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.util.Objects;

/**
 * ID序列化器
 * 返回数据给前端时将long型ID转为String
 *
 * @author liuwe
 */
public class IdSerializer extends JsonSerializer<Long> {

    @Override
    public void serialize(Long id, JsonGenerator jsonGenerator, SerializerProvider serializerProvider) throws IOException {
        if (Objects.nonNull(id)) {
            jsonGenerator.writeString(String.valueOf(id));
        }
    }
}