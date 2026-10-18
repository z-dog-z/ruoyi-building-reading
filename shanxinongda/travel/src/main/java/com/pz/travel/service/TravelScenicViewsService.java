package com.pz.travel.service;

import com.pz.travel.constant.TravelStatsConstant;
import com.pz.travel.domain.TravelScenicViews;
import com.pz.travel.mapper.TravelScenicViewsMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IdWorker;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelScenicViewsService {
    @Autowired
    private TravelScenicViewsMapper travelScenicViewsMapper;
    @Autowired
    private IdWorker idWorker;

    public int insertScenicViews(TravelScenicViews travelScenicViews){
        travelScenicViews.setId(idWorker.nextId());
        // 小程序端未登录时 userId 设 null，避免 SecurityUtils.getLoginUser() 抛异常
        try {
            travelScenicViews.setUserId(SecurityUtils.getLoginUser().getUser().getUserId());
        } catch (Exception ignored) {
            travelScenicViews.setUserId(null);
        }
        travelScenicViews.setDates(DateUtils.getNowDate());
        if (travelScenicViews.getEventType() == null) {
            travelScenicViews.setEventType(TravelStatsConstant.SCENIC_VIEW_EVENT);
        }
        if (StringUtils.isBlank(travelScenicViews.getSource())) {
            travelScenicViews.setSource(TravelStatsConstant.UNKNOWN_SOURCE);
        }
        return travelScenicViewsMapper.insertScenicViews(travelScenicViews);
    }

    public int insertScenicEvent(Long scenicId, Integer eventType, String source, String sourceDetail) {
        TravelScenicViews travelScenicViews = new TravelScenicViews();
        travelScenicViews.setScenicId(scenicId);
        travelScenicViews.setEventType(eventType);
        travelScenicViews.setSource(source);
        travelScenicViews.setSourceDetail(sourceDetail);
        return insertScenicViews(travelScenicViews);
    }

}
