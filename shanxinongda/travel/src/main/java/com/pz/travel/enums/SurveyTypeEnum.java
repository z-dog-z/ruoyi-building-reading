package com.pz.travel.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 调查类型枚举
 */
@Getter
@AllArgsConstructor
public enum SurveyTypeEnum implements DictEnum {
    NEW_DISCOVERY("新发现", "1"),
    NO_CHANGE("无变更", "2");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(SurveyTypeEnum.class, label);
    }
}

