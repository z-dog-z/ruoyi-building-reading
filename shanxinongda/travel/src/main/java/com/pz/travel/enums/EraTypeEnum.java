package com.pz.travel.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 统计年代枚举
 */
@Getter
@AllArgsConstructor
public enum EraTypeEnum implements DictEnum {
    MODERN("近现代", "1"),
    QING_DYNASTY("清代", "2"),
    SONG_LIAO_XIXIA_JIN_YUAN("宋辽西夏金元", "3"),
    MING_DYNASTY("明代", "4");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(EraTypeEnum.class, label);
    }
}

