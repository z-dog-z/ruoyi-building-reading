package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;
import java.util.Date;

/**
 * 景点访问量
 */
@Data
public class TravelScenicViews extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**用户id*/
    private Long userId;

    /**景点id*/
    private Long scenicId;

    /**日期*/
    private Date dates;

    /**事件类型：1-建筑浏览 2-建筑识别 3-VR查看*/
    private Integer eventType;

    /**来源标识：首页、搜索、地图、分享等*/
    private String source;

    /**来源补充说明*/
    private String sourceDetail;

}
