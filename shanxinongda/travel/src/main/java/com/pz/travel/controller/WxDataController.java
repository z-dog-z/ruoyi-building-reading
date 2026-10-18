package com.pz.travel.controller;

import cn.binarywang.wx.miniapp.api.WxMaAnalysisService;
import cn.binarywang.wx.miniapp.bean.analysis.WxMaUserPortrait;
import com.pz.travel.common.CommonResult;

import com.pz.travel.config.WxMaConfiguration;
import com.pz.travel.config.WxMaProperties;
import com.pz.travel.domain.WxData;
import com.pz.travel.domain.vo.TravelStatisticsBaseVo;
import com.pz.travel.mapper.WxDataMapper;

import com.ruoyi.common.core.controller.BaseController;
import me.chanjar.weixin.common.error.WxErrorException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/wxdata")
public class WxDataController extends BaseController {
    @Autowired
    WxMaProperties wxMaProperties;

    @Autowired
    WxDataMapper wxDataMapper;

    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM

    public WxDataController(WxMaProperties properties) {
        this.properties = properties;
    }

    /**
     * 用户画像
     *
     * @param date1
     * @param date2
     * @return
     */
    @GetMapping("/user")
    public CommonResult<WxMaUserPortrait> getUserPortrait(
            String date1, String date2) {

        try {


            final WxMaAnalysisService wxMaAnalysisService = WxMaConfiguration.getMaService(wxMaProperties.getConfigs().get(0).getAppid()).getAnalysisService();

            return CommonResult.otherSuccess(wxMaAnalysisService.getUserPortrait(time(date1), time(date2)));
        } catch (WxErrorException e) {
            return CommonResult.otherError(1, e.getError().toString());
        }


    }

    public Date time(String date) {
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
            Date date1 = simpleDateFormat.parse(date);
            return date1;
        } catch (ParseException e) {

        }
        return null;

    }

    /**
     * 景点访问量
     *
     * @param type
     * @return
     */
    @GetMapping("/scenic")
    public CommonResult<List<WxData>> gerScenic(int type) {
        if (type == 1) {
            return CommonResult.success().setResult(wxDataMapper.SelectScenicYes());
        } else {
            return CommonResult.success().setResult(wxDataMapper.SelectScenicAll());
        }
    }


    /**
     * 用户小时访问
     *
     * @param type
     * @return
     */
    @GetMapping("/view")
    public CommonResult<List<WxData>> SelectView(int type) {

        return CommonResult.success().setResult(wxDataMapper.SelectView());

    }

    /**
     * 基础数据统计
     *
     * @return
     */
    @GetMapping("/base")
    public CommonResult<TravelStatisticsBaseVo> selectBaseStatistics() {
        return CommonResult.success().setResult(wxDataMapper.selectBaseStatistics());
    }

    /**
     * 建筑识别排行
     *
     * @param limit 返回条数
     * @return
     */
    @GetMapping("/recognition")
    public CommonResult<List<WxData>> selectRecognitionRank(@RequestParam(defaultValue = "10") Integer limit) {
        return CommonResult.success().setResult(wxDataMapper.selectRecognitionRank(limit));
    }

    /**
     * 建筑 VR 查看排行
     *
     * @param limit 返回条数
     * @return
     */
    @GetMapping("/vrRank")
    public CommonResult<List<WxData>> selectVrRank(@RequestParam(defaultValue = "10") Integer limit) {
        return CommonResult.success().setResult(wxDataMapper.selectVrRank(limit));
    }

    /**
     * 热门建筑排行
     *
     * @param limit 返回条数
     * @return
     */
    @GetMapping("/hot")
    public CommonResult<List<WxData>> selectHotRank(@RequestParam(defaultValue = "10") Integer limit) {
        return CommonResult.success().setResult(wxDataMapper.selectHotRank(limit));
    }

    /**
     * 建筑行为来源统计
     *
     * @param eventType 1-建筑浏览 2-建筑识别 3-VR查看
     * @return
     */
    @GetMapping("/scenicSource")
    public CommonResult<List<WxData>> selectScenicSourceStats(@RequestParam(required = false) Integer eventType) {
        return CommonResult.success().setResult(wxDataMapper.selectScenicSourceStats(eventType));
    }

    /**
     * 小程序访问来源统计
     *
     * @return
     */
    @GetMapping("/viewSource")
    public CommonResult<List<WxData>> selectViewSourceStats() {
        return CommonResult.success().setResult(wxDataMapper.selectViewSourceStats());
    }

//
//    @Value("${wx.miniapp.configs.appid}")
//    String appid ;

    private final WxMaProperties properties;

}

