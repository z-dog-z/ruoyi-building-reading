package com.pz.travel.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 文物级别枚举
 */
@Getter
@AllArgsConstructor
public enum ProtectionTypeEnum implements DictEnum {
    NOT_DESIGNATED("尚未核定公布为文物保护单位的不可移动文物", "1"),
    PROVINCIAL("省级文物保护单位", "2"),
    NATIONAL("全国重点文物保护单位", "3"),
    MUNICIPAL_COUNTY("市级和县级文物保护单位", "4"),
    UNIDENTIFIED("未认定", "5");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(ProtectionTypeEnum.class, label);
    }

    /**
     * 根据键值获取标签
     */
    public static String getLabelByKeyValue(String keyValue) {
        return DictEnum.getLabelByKeyValue(ProtectionTypeEnum.class, keyValue);
    }

    /**
     * 获取所有keyValue
     */
    public static List<String> getAllKeyValues() {
        return Arrays.stream(values())
                .map(ProtectionTypeEnum::getKeyValue)
                .collect(Collectors.toList());
    }

    /**
     * 获取所有标签
     * @return
     */
    public static List<String> getAllLabels() {
        return Arrays.stream(values())
                .map(ProtectionTypeEnum::getLabel)
                .collect(Collectors.toList());
    }
}
