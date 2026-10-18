package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;

import javax.persistence.Id;

/**
 * 景点点赞对象
 */
@Data
public class TravelScenicSpotLikes extends TravelBaseEntity{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 景点id */
    @Excel(name = "景点id")
    private Long scenicSpotId;

    /** 点赞人id */
    @Excel(name = "点赞人id")
    private Long userId;

    /** 点赞量 */
    @Excel(name = "点赞量")
    private Long likes;
}
