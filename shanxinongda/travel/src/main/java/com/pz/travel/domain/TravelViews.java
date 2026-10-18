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
public class TravelViews extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**用户id*/
    private Long userId;

    /**时间*/
    private Date time;

    /**事件类型：1-首页访问*/
    private Integer eventType;

    /**来源标识：首页、搜索、分享等*/
    private String source;

    /**来源补充说明*/
    private String sourceDetail;

    /**当前页面*/
    private String pageName;

}
