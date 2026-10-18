package com.pz.travel.service;

import com.pz.travel.domain.TravelCover;
import com.pz.travel.mapper.TravelCoverMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelCoverService {
    @Autowired
    private TravelCoverMapper travelCoverMapper;

    /**
     *获取封面图片
     * @param identity
     * @return
     */
    public String getCoverPicture(int identity){
        return travelCoverMapper.getCoverPicture(identity);
    }

    /**
     * 修改封面图片
     * @param travelCover
     * @return
     */
    public int updateCoverPicture(TravelCover travelCover){
        return travelCoverMapper.updateCoverPicture(travelCover);
    }
}
