package com.pz.travel.domain;


import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class HistoryHuman {
     private static final long serialVersionUID = 1L;
    @Id
    @JsonSerialize(using = IdSerializer.class)

    private  Long id;

    /**
     * 姓名
     */
   private String name;
    /**
     * 生辰
     */

    private  String date;
    /**
     * 照片
     */

    private  String photo;

    /**
     * 简介
     */

    private  String content;
}
