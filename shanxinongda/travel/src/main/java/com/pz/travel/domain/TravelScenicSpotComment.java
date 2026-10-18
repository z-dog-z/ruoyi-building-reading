package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;

/**
 * 景点评论对象 travel_scenic_spot_comment
 */
@Data
public class TravelScenicSpotComment extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 景点id */
    private Long scenicSpotId;

    /** 评论人id */
    private Long commentUserId;

    /** 评论内容 */
    private String comment;

    /** 状态，1：正常 0：失效 */
    private Integer status;
}
