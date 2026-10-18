package com.pz.travel.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 文物小类枚举
 */
@Getter
@AllArgsConstructor
public enum RelicSubTypeEnum implements DictEnum {
    CELEBRITY_RESIDENCE("名人故、旧居", "1"),
    TYPICAL_STYLE_BUILDING("典型风格建筑或者构筑物", "2"),
    CULTURAL_EDUCATIONAL_BUILDING("文化教育建筑及附属物", "3"),
    MEDICAL_HEALTH_BUILDING("医疗卫生建筑", "4"),
    TEMPLE_ANCESTRAL_HALL("坛庙祠堂", "5"),
    CELEBRITY_NOBLE_TOMB("名人或贵族墓", "6"),
    REVOLUTIONARY_MEMORIAL("重要革命历史事件及革命人物活动纪念地", "7"),
    RELIGIOUS_BUILDING("宗教建筑", "8"),
    TEMPLE_MONASTERY_PAGODA("寺观塔阁（及其他宗教建筑）", "9"),
    OTHER_MODERN_REPRESENTATIVE("其他近现代代表性建筑", "10"),
    TRADITIONAL_DWELLING("传统民居", "11"),
    MILITARY_BUILDING("军事建筑及设施", "12"),
    RESIDENTIAL_DWELLING("宅第民居", "13"),
    MARTYR_TOMB("烈士墓及纪念设施", "14"),
    INDUSTRIAL_BUILDING("工业建筑及附属装置装备（以及其他工业遗产）", "15"),
    TRANSPORTATION_FACILITY("交通道路设施", "16"),
    MEMORIAL_BUILDING("其他为纪念重大历史事件或者著名人物建立的建筑物、构筑物等", "17"),
    LARGE_SCALE_SCULPTURE("体量较大的各种材质（如石、铜、铁、泥等）雕塑", "18"),
    HISTORICAL_SITE("重大历史事件和重要机构旧址（及战争遗址、工业遗址等）", "19"),
    WATER_AGRICULTURE("水利、农业相关建筑、设施及附属物（以及其他水利与农业遗产）", "20");

    private final String label;
    private final String keyValue;

    /**
     * 根据标签获取键值
     */
    public static String getKeyValueByLabel(String label) {
        return DictEnum.getKeyValueByLabel(RelicSubTypeEnum.class, label);
    }
}

