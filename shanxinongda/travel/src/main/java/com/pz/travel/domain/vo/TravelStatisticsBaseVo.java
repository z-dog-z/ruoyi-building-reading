package com.pz.travel.domain.vo;

import lombok.Data;

@Data
public class TravelStatisticsBaseVo {

    /**
     * 建筑总数
     */
    private Integer buildingCount;

    /**
     * VR 建筑总数
     */
    private Integer vrBuildingCount;

    /**
     * 访问用户数
     */
    private Integer visitorCount;

    /**
     * 建筑浏览次数
     */
    private Integer scenicViewCount;

    /**
     * 建筑识别次数
     */
    private Integer recognitionCount;

    /**
     * VR 查看次数
     */
    private Integer vrViewCount;

    /**
     * 点赞总数
     */
    private Integer likeCount;
}
