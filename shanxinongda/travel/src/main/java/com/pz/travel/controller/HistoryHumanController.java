package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.HistoryHuman;
import com.pz.travel.service.HistoryHumanService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 历史任务
 */
@RestController
@RequestMapping("/travel/human")
public class HistoryHumanController  extends BaseController {


    @Autowired
    HistoryHumanService historyHumanService;


    /**
     * 查询
     * @param historyHuman
     * @return
     */
    @GetMapping("/list")
    public TableDataInfo<HistoryHuman> list(HistoryHuman historyHuman){
        startPage();
           List<HistoryHuman> historyHumanList = historyHumanService.list(historyHuman);
        return getDataTable(historyHumanList);
    }


    /**
     * 保存
     * @param historyHuman
     * @return
     */
    @PostMapping("/save")
    public CommonResult<HistoryHuman> save(@RequestBody HistoryHuman historyHuman){

        return  CommonResult.success().setResult(historyHumanService.save(historyHuman));
    }


    /**
     * 修改
     * @param historyHuman
     * @return
     */
    @Log(title = "修改", businessType = BusinessType.UPDATE)
    @PostMapping("/update")
    public CommonResult<HistoryHuman> update(@RequestBody HistoryHuman historyHuman){

        return  CommonResult.success().setResult(historyHumanService.update(historyHuman));
    }


    /**
     * 删除
     * @param historyHuman
     * @return
     */
    @Log(title = "删除", businessType = BusinessType.DELETE)
    @DeleteMapping("/delete")
    public CommonResult delete(@RequestBody List<Long> historyHuman){

        return  CommonResult.success().setResult(historyHumanService.delete(historyHuman));
    }

}
