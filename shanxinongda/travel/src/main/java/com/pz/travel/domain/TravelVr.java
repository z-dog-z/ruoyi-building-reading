package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;
import org.apache.xmlbeans.impl.jam.internal.elements.PackageImpl;

import javax.persistence.Id;
import javax.persistence.Transient;

/**
 * VR管理对象
 */
@Data
public class TravelVr extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 状态 1：启用 0：关闭 */
    @Excel(name = "状态 1：启用 0：关闭")
    private Integer status;

    /** 标识 */
    @Excel(name = "标识")
    private String identify;

    /**VR封面图*/
    @Excel(name = "VR封面图")
    private String vrCover;

    /** vrURL */
    @Transient
    private String travelVrUrl;


}
