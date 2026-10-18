package com.pz.travel.domain;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;

/**
 * @CLASSNAME BookActiv
 * @Author ymliu
 * @Date 2022/8/31、10:16
 */
@Data
public class BookActiv extends  TravelBaseEntity{


    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**
     * 封面图片
     */
    private String background;

    /**
     * 名称
     */
    private  String name;

    /**
     * 类别 1：内部  2： 外部
     */
    private  Integer type;

    /**
     * 链接地址
     */
    private String url;

    /**
     * 状态 1： 发布 o: 不发布
     */
    private Integer  status;





}
