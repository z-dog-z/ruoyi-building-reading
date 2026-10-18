package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;

@Data
public class TravelCover extends TravelBaseEntity{
    private static final long serialVersionUID = 1L;
    /**主键id*/
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private int id;

    /**图片地址*/
    private String pictureUrl;

    /**标识 0：拍照识别图片，1：建筑可阅读照片*/
    private int identity;
}
