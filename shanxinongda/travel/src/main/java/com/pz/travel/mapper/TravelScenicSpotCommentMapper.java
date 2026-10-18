package com.pz.travel.mapper;

import com.pz.travel.domain.TravelScenicSpotComment;
import com.pz.travel.domain.vo.TravelScenicSpotCommentVo;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TravelScenicSpotCommentMapper extends Mapper<TravelScenicSpotComment> {

    List<TravelScenicSpotCommentVo> selectScenicSpotCommentsByScenicspotId(Long scenicspotId);
}
