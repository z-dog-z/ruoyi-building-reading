package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;
import javax.persistence.Id;

/**
 * 二级分类对象
 */
@Data
public class TravelSubClassification extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**
     * 名称
     */
    @Excel(name = "名称")
    private String name;

    /**
     * 状态 1：正常 0：失效
     */
    @Excel(name = "状态 1：正常 0：失效")
    private Integer status;

    /**
     * 模块id
     */
    @Excel(name = "模块id")
    private Long moduleId;

    /**
     * 排序
     */
    @Excel(name="排序")
    private Integer orderBy;
}
