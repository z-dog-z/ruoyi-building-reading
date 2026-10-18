package com.pz.travel.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.Date;

/**
 * @CLASSNAME TravelVideo
 * @Author ymliu
 * @Date 2022/1/19、11:18
 */

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class TravelVideo  extends  TravelBaseEntity{

    private static final long serialVersionUID = 1L;
    @Id
    @JsonSerialize(using = IdSerializer.class)

    private Long id;

    private String name;

    @JsonSerialize(using = IdSerializer.class)
    private Long modelId;


    @JsonSerialize(using = IdSerializer.class)
    private Long tourId;


    private String tittle;


    private String cover;


    private String video;

    private Integer count;

    private String content;

    @ApiModelProperty(name = "类型 0:微创 1:宣传视频2:手册 3：活动")
    private Integer type;

    private Integer inx;



    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date startDate;


    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;


    @Transient
    private  Integer  status;
}
