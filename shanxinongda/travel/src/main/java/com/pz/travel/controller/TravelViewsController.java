package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.constant.TravelStatsConstant;
import com.pz.travel.domain.TravelScenicViews;
import com.pz.travel.domain.TravelViews;
import com.pz.travel.service.TravelScenicViewsService;
import com.pz.travel.service.TravelViewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 数据统计接口（访问量）
 */
@RestController
@RequestMapping("/views")
public class TravelViewsController  {
    @Autowired
    private TravelScenicViewsService travelScenicViewsService;
    @Autowired
    private TravelViewsService travelViewsService;
    //景点访问量

    /**
     * 增加景点访问量
     * @param travelScenicViews
     * @return
     */
    @PostMapping("/insertScenicViews")
    public CommonResult<Integer> insertScenicViews(TravelScenicViews travelScenicViews){
        return CommonResult.ok().setResult(travelScenicViewsService.insertScenicViews(travelScenicViews));
    }

    /**
     * 增加 VR 查看量
     * @param scenicId 景点id
     * @param source 来源
     * @param sourceDetail 来源补充说明
     * @return
     */
    @PostMapping("/insertVrViews")
    public CommonResult<Integer> insertVrViews(Long scenicId, String source, String sourceDetail){
        return CommonResult.ok().setResult(
                travelScenicViewsService.insertScenicEvent(scenicId, TravelStatsConstant.VR_VIEW_EVENT, source, sourceDetail)
        );
    }

    //小程序访问量

    /**
     * 增加访问量
     * @param travelViews
     * @return
     */
    @PostMapping("/insertViews")
    public CommonResult<Integer> insertViews(TravelViews travelViews){
        return CommonResult.ok().setResult(travelViewsService.insertViews(travelViews));
    }
}
