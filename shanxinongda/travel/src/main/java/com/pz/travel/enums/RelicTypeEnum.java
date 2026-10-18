package com.pz.travel.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 文物类别枚举
 */
@Getter
@AllArgsConstructor
public enum RelicTypeEnum implements DictEnum {
    MODERN_HISTORICAL_SITES("近现代重要史迹及代表性建筑", "1"),
    ANCIENT_BUILDINGS("古建筑", "2"),
    ANCIENT_TOMBS("古墓葬", "3");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(RelicTypeEnum.class, label);
    }
}

