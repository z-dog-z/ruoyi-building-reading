package com.pz.travel.enums;

/**
 * 字典枚举基类
 */
public interface DictEnum {
    /**
     * 获取字典标签
     */
    String getLabel();

    /**
     * 获取字典键值
     */
    String getKeyValue();

    /**
     * 根据标签获取键值
     */
    static <T extends Enum<T> & DictEnum> String getKeyValueByLabel(Class<T> enumClass, String label) {
        if (label == null || label.trim().isEmpty()) {
            return null;
        }
        for (T enumConstant : enumClass.getEnumConstants()) {
            if (enumConstant.getLabel().equals(label.trim())) {
                return enumConstant.getKeyValue();
            }
        }
        return null;
    }

    /**
     * 根据键值获取标签
     */
    static <T extends Enum<T> & DictEnum> String getLabelByKeyValue(Class<T> enumClass, String keyValue) {
        if (keyValue == null || keyValue.trim().isEmpty()) {
            return null;
        }
        for (T enumConstant : enumClass.getEnumConstants()) {
            if (enumConstant.getKeyValue().equals(keyValue.trim())) {
                return enumConstant.getLabel();
            }
        }
        return null;
    }
}

