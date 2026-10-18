package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.TravelVideo;
import com.pz.travel.service.TravelVideoService;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @CLASSNAME TravelVideoController
 * @Author ymliu
 * @Date 2022/1/19、15:19
 */
@Api(tags ={"微课"})
@RequestMapping("/travelVideo")
@RestController
public class TravelVideoController  extends BaseController {

    @Autowired
    TravelVideoService travelVideoService;

    /**
     * 查询
     * @return
     */
    @GetMapping("/list")
    @ApiOperation(value = "查询列表")
    public TableDataInfo<TravelVideo> list(TravelVideo travelVideo){

        startPage();
        List<TravelVideo> travelVideos = travelVideoService.list(travelVideo);

        return getDataTable(travelVideos);
    }




    /**
     * 新增
     * @param travelVideo
     * @return
     */
    @PostMapping("/add")
    @ApiOperation(value = "新增")
    public CommonResult<TravelVideo> add(@RequestBody TravelVideo travelVideo){


        return CommonResult.success().setResult(travelVideoService.save(travelVideo));
    }

    /**
     * 修改
     * @param travelVideo
     * @return
     */
    @PostMapping("/update")
    @ApiOperation(value = "修改")
    public CommonResult<TravelVideo> update(@RequestBody TravelVideo travelVideo){
        return CommonResult.success().setResult(travelVideoService.update(travelVideo));
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @DeleteMapping("/delete")
    @ApiOperation(value = "删除")
    public CommonResult<TravelVideo> delete(Long  id){

        return CommonResult.success().setResult(travelVideoService.delete(id));
    }
    /**
     * 删除
     * @param id
     * @return
     */
    @GetMapping("/detail")
    public CommonResult<TravelVideo> detail(Long  id){

        return CommonResult.success().setResult(travelVideoService.detail(id));
    }
}
