package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;

import javax.persistence.Id;

@Data
public class TravelModule extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 状态 1：正常 0：失效 */
    @Excel(name = "状态 1：正常 0：失效")
    private Integer status;

    /** 标记，1：系统预定义 0：动态添加 */
    @Excel(name = "标记，1：系统预定义 0：动态添加")
    private Integer flag;

}
