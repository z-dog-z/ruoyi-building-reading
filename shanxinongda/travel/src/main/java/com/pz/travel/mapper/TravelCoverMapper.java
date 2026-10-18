package com.pz.travel.mapper;

import com.pz.travel.domain.TravelCover;
import org.apache.ibatis.annotations.Param;

public interface TravelCoverMapper {
    /**
     * 获取封面图片
     * @param identity
     * @return
     */
    String getCoverPicture(@Param("identity") int identity);

    /**
     * 修改图片
     * @param travelCover
     * @return
     */
    int updateCoverPicture(TravelCover travelCover);
}
