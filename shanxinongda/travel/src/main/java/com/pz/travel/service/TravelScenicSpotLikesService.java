package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelScenicSpotLikes;
import com.pz.travel.mapper.TravelScenicSpotLikesMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelScenicSpotLikesService {
    @Autowired
    private TravelScenicSpotLikesMapper travelScenicSpotLikesMapper;
    @Autowired
    private IdWorker idWorker;


    /**
     * 判断是否点过赞
     * @param scenicSpotId
     * @return
     */
    public int isLikes(Long scenicSpotId){
        if(SecurityUtils.getAuthentication() == null || SecurityUtils.getAuthentication().getPrincipal() instanceof String){
            return 0;
        }else {
            return travelScenicSpotLikesMapper.isLikes(scenicSpotId, SecurityUtils.getLoginUser().getUser().getUserId());
        }
    }

    /**
     * 用户点赞
     * @param travelScenicSpotLikes
     * @return
     */
    public int insertLikes(TravelScenicSpotLikes travelScenicSpotLikes){
        travelScenicSpotLikes.setId(idWorker.nextId());
        travelScenicSpotLikes.setUserId(SecurityUtils.getLoginUser().getUser().getUserId());
        travelScenicSpotLikes.setCreateTime(DateUtils.getNowDate());
        return travelScenicSpotLikesMapper.insertLikes(travelScenicSpotLikes);
    }

    /**
     * 取消点赞
     * @param scenicSpotId
     * @return
     */
    public int deletelLikes(Long scenicSpotId){
        return travelScenicSpotLikesMapper.deletelLikes(scenicSpotId, SecurityUtils.getLoginUser().getUser().getUserId());
    }



}
