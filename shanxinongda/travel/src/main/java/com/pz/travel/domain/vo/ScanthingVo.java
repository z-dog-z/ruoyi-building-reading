package com.pz.travel.domain.vo;

import com.pz.travel.domain.TravelModuleDetail;
import lombok.Data;

import java.util.List;

/**
 * 建筑物识别响应对象
 */
@Data
public class ScanthingVo {

    /**
     * 识别结果，1:准确识别出建筑物 2:未识别出
     */
    private Integer resultCode;

    /**
     * 准确识别出的建筑物
     */
    private TravelModuleDetail travelScenicSpot;

    /**
     * 未识别出建筑物，推荐的建筑物
     */
    private List<TravelModuleDetail> recommendTravelScenicSpots;
}
