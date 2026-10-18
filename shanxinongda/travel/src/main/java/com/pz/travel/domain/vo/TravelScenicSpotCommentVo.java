package com.pz.travel.domain.vo;

import com.pz.travel.domain.TravelScenicSpotComment;
import lombok.Data;

@Data
public class TravelScenicSpotCommentVo extends TravelScenicSpotComment {

    /**
     * 评论人昵称
     */
    private String commentUserName;
}
