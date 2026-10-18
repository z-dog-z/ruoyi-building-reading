package com.pz.travel.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.Data;

import javax.persistence.Id;
import java.util.Date;

/**
 * 识别库对象
 */
@Data
public class TravelRecognitionLibrary extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /** 文件名称 */
    private String filename;

    /** 图片地址 */
    private String url;

    /**
     * 标记，1:景点 2:文创
     */
    private Integer tag;

    /** 关联景点id */
    private Long moduleDetailId;

    /** 来源，1：用户 2：官方 */
    private Integer source;

    /** 百度图片签名信息 */
    private String contSign;

    /** 是否入库，0：否 1：是 */
    private Integer isStorage;

    /** 入库时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date storageTime;

}
