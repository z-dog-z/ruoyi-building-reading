package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import javax.persistence.Id;

/**
 * 【请填写功能名称】对象 travel_model_video
 * 
 * @author ruoyi
 * @date 2021-04-27
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class TravelModelVideo
{
    private static final long serialVersionUID = 1L;

    @Id
    @JsonSerialize(using = IdSerializer.class)
    /** $column.columnComment */
    private Long id;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String name;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String url;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long modelId;

    private  String qrUrl;

    private  Integer inx;


    private String content;

    private  String theme;
    private String people;
}
