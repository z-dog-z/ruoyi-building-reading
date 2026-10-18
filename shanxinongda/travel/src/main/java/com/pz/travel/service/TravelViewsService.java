package com.pz.travel.service;

import com.pz.travel.constant.TravelStatsConstant;
import com.pz.travel.domain.TravelViews;
import com.pz.travel.mapper.TravelViewsMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IdWorker;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelViewsService {
    @Autowired
    private TravelViewsMapper travelViewsMapper;
    @Autowired
    private IdWorker idWorker;

    public int insertViews(TravelViews travelViews){
        travelViews.setId(idWorker.nextId());
        // 小程序端未登录时 userId 设 null
        try {
            travelViews.setUserId(SecurityUtils.getLoginUser().getUser().getUserId());
        } catch (Exception ignored) {
            travelViews.setUserId(null);
        }
        travelViews.setTime(DateUtils.getNowDate());
        if (travelViews.getEventType() == null) {
            travelViews.setEventType(TravelStatsConstant.SCENIC_VIEW_EVENT);
        }
        if (StringUtils.isBlank(travelViews.getSource())) {
            travelViews.setSource(TravelStatsConstant.UNKNOWN_SOURCE);
        }
        if (StringUtils.isBlank(travelViews.getPageName())) {
            travelViews.setPageName(TravelStatsConstant.MINI_APP_PAGE);
        }
        return travelViewsMapper.insertViews(travelViews);
    }
}
