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
public enum StreetEnum implements DictEnum {

    QIANHEJING_JIEDAO("漕河泾街道", "1"),
    FENGLIN_JIEDAO("枫林街道", "2"),
    HONGMEI_JIEDAO("虹梅街道", "3"),
    HUNAN_JIEDAO("湖南街道", "4"),
    HUAJING_JIEDAO("华泾道", "5"),
    KANGJIAN_JIEDAO("康建街道", "6"),
    LINGYUN_JIEDAO("凌云街道", "7"),
    LONGHUA_JIEDAO("龙华街道", "8"),
    TIANPING_JIEDAO("天平街道", "9"),
    TIANLIN_JIEDAO("田林街道", "10"),
    XIETU_JIEDAO("斜土街道", "11"),
    XUJIAHUI_JIEDAO("徐家汇街道", "12"),
    CHANGQIAO_JIEDAO("长桥街道", "13");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(StreetEnum.class, label);
    }


    /**
     * 根据键值获取标签
     */
    public static String getLabelByKeyValue(String keyValue) {
        return DictEnum.getLabelByKeyValue(StreetEnum.class, keyValue);
    }

    /**
     * 获取所有keyValue
     */
    public static List<String> getAllKeyValues() {
        return Arrays.stream(values())
                .map(StreetEnum::getKeyValue)
                .collect(Collectors.toList());
    }

    /**
     * 获取所有标签
     * @return
     */
    public static List<String> getAllLabels() {
        return Arrays.stream(values())
                .map(StreetEnum::getLabel)
                .collect(Collectors.toList());
    }
}

