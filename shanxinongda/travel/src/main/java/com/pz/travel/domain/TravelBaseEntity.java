package com.pz.travel.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import lombok.Data;

import java.util.Date;

@Data
public class TravelBaseEntity {
    /** 创建者 */
    private String createBy;

    @Excel(name = "创建时间",dateFormat = "yyyy-MM-dd")
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

}
