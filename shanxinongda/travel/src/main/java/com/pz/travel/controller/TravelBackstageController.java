package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.*;
import com.pz.travel.service.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.exception.BaseException;
import com.ruoyi.common.exception.CustomException;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 后台管理接口
 */
@Slf4j
@RestController
@Api(tags ={"后台管理接口"})
@RequestMapping("/travel/backstage")
public class TravelBackstageController extends BaseController {
    @Autowired
    private TravelBackstageService travelBackstageService;
    @Autowired
    private TravelSubClassificationService travelSubClassificationService;
    @Autowired
    private TravelModuleService travelModuleService;
    @Autowired
    private TravelVrService travelVrService;
    @Autowired
    private TravelRecognitionLibraryService travelRecognitionLibraryService;
    @Autowired
    private TravelCoverService travelCoverService;
    @Autowired
    private TravelJointService travelJointService;

    //景点管理:查看、删除、修改

    /**
     * 通过景点名称和分类查询景点
     * @param subClafficationId 二级分类id
     * @param name 景点名称
     * @param spotScenicId 景点id
     * @param isVr 是否有vr
     * @param moduleId 模块id
     * @return
     */
    @GetMapping(value = "/search")
    @ApiOperation(value = "通过景点名称和分类查询景点")
    public TableDataInfo<TravelModuleDetail> getInfo
    (Long subClafficationId, String name, Long spotScenicId,Integer isVr,Long moduleId,String remarks) {
        startPage();
        List<TravelModuleDetail> list = travelBackstageService.selectTravelModuleDetailByName
                (subClafficationId, name, spotScenicId,isVr,moduleId,remarks);
        return getDataTable(list);
    }


    @GetMapping(value = "/List")
    @ApiOperation(value = "查询景点列表")
    public TableDataInfo<TravelModuleDetail> getInfo(TravelModuleDetail  travelModuleDetail) {
        startPage();
        List<TravelModuleDetail> list = travelBackstageService.select(travelModuleDetail);
        return getDataTable(list);
    }
    @GetMapping(value = "/associated")
    @ApiOperation(value = "关联或者解绑 解绑blockId为0 ")
    public CommonResult<TravelModuleDetail> associated(TravelModuleDetail  travelModuleDetail) {
        return CommonResult.ok().setResult(travelBackstageService.update(travelModuleDetail));
    }

    /**
     * 新增景点
     *
     * @param travelModuleDetail
     * @return
     */
    @Log(title = "新增景点", businessType = BusinessType.INSERT)
    @PostMapping(value = "/add")
    @ApiOperation(value = "新增景点")
    public CommonResult<TravelModuleDetail> add(@RequestBody TravelModuleDetail travelModuleDetail) {
        try{
            return   CommonResult.ok().setResult(travelBackstageService.insertTravelModuleDetail(travelModuleDetail));
        }
        catch (CustomException e){
            log.error("",e);
            return CommonResult.otherError(301,e.getMessage());
        }
        catch (Exception e){
            log.error("",e);
            return  CommonResult.otherError(301,"请检查数据内容");
        }

    }

    /**
     * 修改景点信息
     *
     * @param travelModuleDetail
     * @return
     */
    @Log(title = "修改景点", businessType = BusinessType.UPDATE)
    @PutMapping(value = "/update")
    @ApiOperation(value = "修改景点")
    public CommonResult<TravelModuleDetail> update(@RequestBody TravelModuleDetail travelModuleDetail) {
        try {
            return CommonResult.ok().setResult(travelBackstageService.updateTravelModuleDetail(travelModuleDetail));
        } catch (CustomException e){
            log.error("",e);
            return CommonResult.otherError(301,e.getMessage());
        }
        catch (Exception e) {
            log.error("",e);
            return CommonResult.otherError(301, "请检查数据内容");
        }
    }



    /**
     * 删除景点
     *
     * @param id
     * @return
     */
    @Log(title = "删除景点", businessType = BusinessType.DELETE)
    @DeleteMapping("/scenicspot/{id}")
    @ApiOperation(value = "删除景点")
    public CommonResult delete(@PathVariable Long id) {
        try {
            int result = travelBackstageService.deleteTravelModuleDetail(id);
            return CommonResult.ok().setResult(result);
        }catch (BaseException e){
            return CommonResult.fail(Integer.valueOf(e.getCode()),e.getMessage());
        }
    }


    //栏目：查询、新增和修改

    /**
     * 栏目展示
     *
     * @param travelModule
     * @return
     */
    @GetMapping("/selectTravelModule")
    public CommonResult<List<TravelModule>> selectTravelModule(TravelModule travelModule) {
        return CommonResult.ok().setResult(travelModuleService.selectTravelModule(travelModule));
    }


    /**
     * 新增栏目
     *
     * @param travelModule
     * @return
     */
    @Log(title = "新增栏目", businessType = BusinessType.INSERT)
    @PostMapping("/insertModule")
    public CommonResult<TravelModule> insert1(TravelModule travelModule) {
        if(travelModule.getName()!=null){
            return CommonResult.ok().setResult(travelModuleService.insertTravelModule(travelModule));
        }else{
            return CommonResult.ok().setResult("栏目名不能为空");
        }

    }

    /**
     * 删除栏目
     *
     * @param id
     * @return
     */
    @Log(title = "删除栏目", businessType = BusinessType.EXPORT)
    @DeleteMapping("/moudule/{id}")
    public CommonResult<TravelModule> remove1(@PathVariable Long id) {
        if (id != 847162 && id != 912419 && id != 923342) {
            return CommonResult.ok().setResult(travelModuleService.deleteTravelModule(id));
        }
        return CommonResult.ok().setResult("不可删除");
    }


    //景点分类：新增和删除

    /**
     * 二级分类展示
     *
     * @param travelSubClassification
     * @return
     */
    @GetMapping("/selectTravelSubClassification")
    public CommonResult<List<TravelSubClassification>> selectSubClassification(TravelSubClassification travelSubClassification) {
        return CommonResult.ok().setResult(travelSubClassificationService.selectTravelSubclassfication(travelSubClassification));
    }

    /**
     * 新增二级分类
     *
     * @param travelSubClassification
     * @return
     */
    @PostMapping("/insertTravelSubClassification")
    public CommonResult<TravelSubClassification> insert2(TravelSubClassification travelSubClassification) {
        if(travelSubClassification.getName()!=null){
            return CommonResult.ok().setResult(travelSubClassificationService.insertTravelSubClassfication(travelSubClassification));
        }else{
            return CommonResult.ok().setResult("分类名不可为空");
        }

    }

    /**
     * 修改二级分类
     * @param travelSubClassification
     * @return
     */

    @Log(title = "修改二级分类", businessType = BusinessType.UPDATE)
    @PutMapping("/updateTravelSubClassfication")
    public CommonResult<TravelSubClassification> updateTravelSubClassfication(TravelSubClassification travelSubClassification){
        return CommonResult.ok().setResult(travelSubClassificationService.updateTravelSubClassfication(travelSubClassification));
    }

    /**
     * 删除二级分类
     *
     * @param id
     * @return
     */
    @Log(title = "删除二级分类", businessType = BusinessType.DELETE)
    @DeleteMapping("/deleteTravelsubclassfication/{id}")
    public CommonResult<TravelBackendController> remove2(@PathVariable Long id) {
        travelJointService.deleteClassification(id);//删除关联表中数据
        return CommonResult.ok().setResult(travelSubClassificationService.deleteTravelSubClassification(id));
    }

    //VR管理：查询、新增、修改、删除

    /**
     * 返回状态码为1的VR列表
     * @return
     */
    @GetMapping("/vr/list1")
    public TableDataInfo<TravelVr> vrList1() {
        startPage();
        List<TravelVr> list = travelVrService.selectTravelVr();
        return getDataTable(list);
    }

    /**
     * 通过VR名称获取列表
     *
     * @return
     */
    @GetMapping("/vr/list")
    public TableDataInfo<TravelVr> vrList(String name) {
        startPage();
        List<TravelVr> list = travelVrService.selectTravelVrByName(name);
        return getDataTable(list);
    }

    /**
     * 新增VR
     * @param travelVr
     * @return
     */
    @Log(title = "新增VR", businessType = BusinessType.INSERT)
    @PostMapping("/vr")
    public CommonResult<TravelVr> insertVr(@RequestBody TravelVr travelVr) {
        return CommonResult.ok().setResult(travelVrService.insertVr(travelVr));
    }

    /**
     * 修改VR信息
     * @param travelVr
     * @return
     */
    @Log(title = "修改VR信息", businessType = BusinessType.UPDATE)
    @PutMapping("/modifyVr")
    public CommonResult<TravelVr> modifyVr(@RequestBody TravelVr travelVr) {
        return CommonResult.ok().setResult(travelVrService.modifyVr(travelVr));
    }

    /**
     * 修改VR的启用状态
     *
     * @param id
     * @return
     */
    @Log(title = "修改VR的启用状态", businessType = BusinessType.UPDATE)
    @PutMapping("/vr/{status}/{id}")
    public CommonResult<TravelVr> modify(@PathVariable int status, @PathVariable Long id) {
        return CommonResult.ok().setResult(travelVrService.modifyVrStatus(status, id));
    }

    /**
     * 删除VR
     * @param id
     * @return
     */
    @Log(title = "删除VR", businessType = BusinessType.DELETE)
    @DeleteMapping("/vr/{id}")
    public CommonResult<TravelVr> deleteVr(@PathVariable Long id) {
        return CommonResult.ok().setResult(travelVrService.deleteVr(id));
    }

    //封面图管理

    /**
     * 获取封面图
     * @param identity
     * @return
     */
    @GetMapping("/getCoverPicture/{identity}")
    public CommonResult<String> getCoverPicture(@PathVariable int identity){
        return  CommonResult.ok().setResult(travelCoverService.getCoverPicture(identity));
    }

    /**
     * 修改封面图
     * @param travelCover
     * @return
     */
    @PostMapping("/updateCoverPicture")
    public CommonResult<TravelCover> updateCoverPicture(TravelCover travelCover){
        return CommonResult.ok().setResult(travelCoverService.updateCoverPicture(travelCover));
    }

    //识别库管理
    /**
     * 通过名称搜索识别库
     *
     * @param filename
     * @return
     */
    @GetMapping("/library/list")
    public TableDataInfo<TravelRecognitionLibrary> recognitionLibraryList(@RequestParam String filename) {
        startPage();
        List<TravelRecognitionLibrary> list = travelRecognitionLibraryService.selectTravelRecognitionLibraryByName(filename);
        return getDataTable(list);
    }

    /**
     * 新增
     *
     * @param travelRecognitionLibrary
     * @return
     */
    @PostMapping("/insertRecognitionLibrary")
    public CommonResult<TravelRecognitionLibrary> insert3(TravelRecognitionLibrary travelRecognitionLibrary) {
        return CommonResult.ok().setResult(travelRecognitionLibraryService.insertTravelRecognitionLibrary(travelRecognitionLibrary));
    }

    /**
     * 批量删除
     *
     * @param ids
     * @return
     */
    @DeleteMapping("/{ids}")
    public CommonResult<TravelRecognitionLibrary> remove3(@PathVariable Long[] ids) {
        return CommonResult.ok().setResult(travelRecognitionLibraryService.deleteTravelRecognitionLibraryByIds(ids));
    }
}
