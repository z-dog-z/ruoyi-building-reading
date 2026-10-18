package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;

/**
 * 景点表和二级分类表的联合
 */
@Data
public class TravelJoint extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**景点id*/
    private Long scenicId;

    /**分类id*/
    private String classificationId;

}
