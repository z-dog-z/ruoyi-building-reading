package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.BookUser;

public interface BookUserMapper {
    public BookUser selectUserByPhone(String phone);

    public Integer insertUser(BookUser bookUser);

    public Integer updateUser(BookUser bookUser);

}
