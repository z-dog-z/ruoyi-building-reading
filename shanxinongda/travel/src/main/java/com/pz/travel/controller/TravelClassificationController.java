package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.TravelJoint;
import com.pz.travel.domain.TravelModuleDetail;
import com.pz.travel.service.TravelJointService;
import com.pz.travel.service.TravelSubClassificationService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;


/**
 * 二级分类
 */
@RestController
@RequestMapping("/classification")
public class TravelClassificationController extends BaseController {
    @Autowired
    private TravelJointService travelJointService;


    /**
     * 通过分类查询景点(小程序调用)
     * @param classficationId
     * @return
     */
    @GetMapping("/selectScenicByClassificatin")
    public TableDataInfo<TravelModuleDetail> selectScenicByClassificatin(Long classficationId){
        startPage();
        List<TravelModuleDetail> list=travelJointService.selectScenicByClassificatin(classficationId);
        return getDataTable(list);
    }

    /**
     * 景点选择分类
     * @param travelJointList
     * @return
     */
    @PostMapping("/insertTravelJoint")
    public CommonResult<Integer> insertTravelJoint(@RequestBody List<TravelJoint> travelJointList){
        return CommonResult.ok().setResult(travelJointService.insertTravelJoint(travelJointList));
    }





}
