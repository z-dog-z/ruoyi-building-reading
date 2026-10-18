package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;

/**
 * 小程序首页轮播图对象
 */
@Data
public class TravelSlideshow extends TravelBaseEntity{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 轮播图url */
    private String pictureUrl;

    /** 状态，0：无效 1：正常 */
    private Integer status;

}
