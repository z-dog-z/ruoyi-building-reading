package com.pz.travel.mapper;

import com.pz.travel.domain.TravelScenicSpotLikes;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

public interface TravelScenicSpotLikesMapper extends Mapper<TravelScenicSpotLikes> {

    int isLikes(@Param("scenicSpotId") Long scenicSpotId,@Param("userId") Long userId);

    int insertLikes(TravelScenicSpotLikes travelScenicSpotLikes);

    int deletelLikes(@Param("scenicSpotId") Long scenicSpotId,@Param("userId") Long userId);

}
