package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.TravelRecognitionLibrary;
import com.pz.travel.domain.TravelSlideshow;
import com.pz.travel.service.TravelService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 旅游业务接口(后台管理页面使用)
 */
@RestController
@RequestMapping("/travel/backend")
public class TravelBackendController extends BaseController {
    @Autowired
    private TravelService travelService;

    /**
     * 添加或更新首页轮播图
     * @param travelSlideshow 轮播图实体
     * @return id主键
     */
    @PostMapping(value = "/slideshow/addOrUpdate")
    public CommonResult<String> slideshowAddOrUpdate(@RequestBody TravelSlideshow travelSlideshow) {
        travelService.addOrUpdateTravelSlideshow(travelSlideshow);
        return CommonResult.ok().setResult(travelSlideshow.getId().toString());
    }

    /**
     * 删除首页轮播图
     * @param id
     * @return
     */
    @DeleteMapping("/slideshow/deleteSlideshow/{id}")
    public CommonResult<Long> deleteSlideshow(@PathVariable Long id){
        return CommonResult.ok().setResult(travelService.deleteSlideshow(id));
    }
    /**
     * 获取轮播图列表
     * @param slideshow 轮播图实体，查询字段和实体类的属性一致，可以是单个和多个字段
     * @return 符合条件的轮播图数据
     */
    //@PreAuthorize("@ss.hasPermi('travel:slideshow:list')")
    @GetMapping("/slideshow/list")
    public TableDataInfo<TravelSlideshow> slideshowList(TravelSlideshow slideshow) {
        startPage();
        List<TravelSlideshow> list = travelService.selectTravelSlideshowList(slideshow);
        return getDataTable(list);
    }

    /**
     * 获取识别库图片列表
     * @param travelRecognitionLibrary
     * @return
     */
    @RequestMapping("/recognitionLibrary/list")
    public TableDataInfo<TravelRecognitionLibrary> recognitionLibraryList(TravelRecognitionLibrary travelRecognitionLibrary) {
        //startPage();
        List<TravelRecognitionLibrary> list = travelService.selectRecognitionLibraryList(travelRecognitionLibrary);
        return getDataTable(list);
    }

    /**
     * 识别库添加图片(官方库)
     * @param tag 标记，1:景点 2:文创
     * @param travelRecognitionLibrary
     * @return
     * @throws Exception
     */
    @RequestMapping("/recognitionLibrary/storage/{tag}")
    public CommonResult storageRecognitionLibrary(@PathVariable("tag") String tag, TravelRecognitionLibrary travelRecognitionLibrary) throws Exception {
        if("1".equalsIgnoreCase(tag) || "2".equalsIgnoreCase(tag)){
            travelRecognitionLibrary.setTag(Integer.valueOf(tag));
            travelRecognitionLibrary.setSource(2);
            String userId = SecurityUtils.getLoginUser().getUser().getUserId().toString();
            Boolean result = travelService.storageRecognitionLibrary(travelRecognitionLibrary, new String[] {tag, tag.concat("2")}, userId);
            return result ? CommonResult.ok():CommonResult.fail(500, "识别库添加失败！");
        }else {
            return CommonResult.fail(500, "只能在景点和文创栏目中新增图片！！！");
        }
    }

    /**
     * 删除识别库中图片
     * @param recognitionLibraryIds
     * @return
     */
    @PostMapping("/recognitionLibrary/delete")
    public CommonResult<Integer> deleteRecognitionLibrary(@RequestBody Long[] recognitionLibraryIds) {
        if(recognitionLibraryIds!=null&&recognitionLibraryIds.length>0){
            int result = travelService.deleteRecognitionLibrary(recognitionLibraryIds);
            return CommonResult.ok().setResult(result);
        }else {
            return CommonResult.ok().setResult("id为空");
        }
    }

}
