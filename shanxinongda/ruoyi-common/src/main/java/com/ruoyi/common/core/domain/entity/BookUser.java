package com.ruoyi.common.core.domain.entity;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.ruoyi.common.config.IdSerializer;
import com.ruoyi.common.core.domain.BaseEntity;

import javax.persistence.Id;

public class BookUser extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    private String phone;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }
}
