package com.pz.travel.service;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.pz.travel.domain.*;
import com.pz.travel.domain.vo.TravelScenicSpotCommentVo;
import com.pz.travel.mapper.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class TravelScenicSpotService {
    @Value("${travel.vrUrl}")
    private String vrUrl;

    @Autowired
    private TravelScenicSpotMapper travelScenicSpotMapper;
    @Autowired
    private TravelScenicSpotCommentMapper travelScenicSpotCommentMapper;
    @Autowired
    private TravelSubClassificationMapper travelSubClassificationMapper;

    @Autowired
    private TravelVideoMapper travelVideoMapper;
    @Autowired
    private TravelModelVideoMapper travelModelVideoMapper;

    /**
     * 获取景点信息列表
     * @return
     */
    public List<TravelModuleDetail> travelScenicSpotList(Long subClassificationId,String  blockId){
        return travelScenicSpotMapper.selectTravelScenicSpotList(subClassificationId,blockId);
    }

    /**
     * 通过景点ID获取景点的详细介绍
     * @return
     */
    public TravelModuleDetail travelScenicInformation(Long id) {
        TravelModuleDetail travelModuleDetail=travelScenicSpotMapper.travelScenicSpotInformation(id);

        String identify=travelScenicSpotMapper.selectIdentify(id);
        travelModuleDetail.setVrUrl(vrUrl + "?type=" +identify);

        //判断当前时间是否在预约时间段内
        travelModuleDetail.setIsAppointment(false);
        travelModuleDetail.setTravelModelVideos(getTravelModelVideos(id));

        TravelVideo travelVideo = new TravelVideo();
        travelVideo.setTourId(id);
        travelModuleDetail.setTravelVideoList(travelVideoMapper.select(travelVideo));
        String IdsStr = travelModuleDetail.getRelateDetailId();
        if (StrUtil.isNotEmpty(IdsStr)) {
            List<String> ids = JSONUtil.toList(IdsStr, String.class);
            travelModuleDetail.setRelateDetailIds(ids);
            Example example = new Example(TravelModuleDetail.class);
            example.createCriteria().andIn("id", ids);
            List<TravelModuleDetail> travelModuleDetails = travelScenicSpotMapper.selectByExample(example);
            travelModuleDetail.setRelateDetailList(travelModuleDetails);
        }

        return travelModuleDetail;
    }

    private List<TravelModelVideo> getTravelModelVideos(Long modelId) {
        Example example = new Example(TravelModelVideo.class);
        example.createCriteria().andEqualTo("modelId", modelId);
        example.setOrderByClause("inx asc, id asc");
        return travelModelVideoMapper.selectByExample(example);
    }


    /**
     * 通过景点ID获取景点的详细介绍
     * @return
     */
    public TravelModuleDetail travelScenicInformationByVrType(String vrType) {
        Long id = travelScenicSpotMapper.travelScenicSpotIdByVrType(vrType);
        if(id == null){
            return null;
        }
        return this.travelScenicInformation(id);
    }

    /**
     * 根据景点id获取评论信息
     * @param scenicspotId
     * @return
     */
    public List<TravelScenicSpotCommentVo> selectTravelScenicSpotCommentList(Long scenicspotId) {
        return travelScenicSpotCommentMapper.selectScenicSpotCommentsByScenicspotId(scenicspotId);
    }

    /**
     * 首页关键字搜索获取景点名称列表
     * @param str
     * @return
     */
    public List<TravelModuleDetail> travelScenicSpotName(String str){
        return travelScenicSpotMapper.travelScenicSpotName(str);
    }

    /**
     * 获取活动列表
     * @param travelModuleDetail
     * @return
     */
    public List<TravelModuleDetail> getActivityList(TravelModuleDetail travelModuleDetail){
        return travelScenicSpotMapper.getActivityList(travelModuleDetail);
    }

    /**
     * 获取VR列表
     * @param travelModuleDetail
     * @return
     */
    public List<TravelModuleDetail> getVrList(TravelModuleDetail travelModuleDetail){
        return travelScenicSpotMapper.getVrList(travelModuleDetail);
    }

    //景点浏览量和点赞量
    public TravelModuleDetail getPageviewsAndLikes(Long id){
        return travelScenicSpotMapper.getPageviewsAndLikes(id);
    }

    public int updatePageViews(Long id){
        return travelScenicSpotMapper.updatePageViews(id);
    }

    //景点点赞
    public int updateLikes(Long scenicSpotId){
        return travelScenicSpotMapper.updateLikes(scenicSpotId);
    }
    //取消点赞
    public int cancelLikes(Long scenicSpotId){
        return travelScenicSpotMapper.cancelLikes(scenicSpotId);
    }

    /**
     * 小程序获取分类名
     * @param travelSubClassification
     * @return
     */
    public List<String> getSubClassification(TravelSubClassification travelSubClassification){
        return travelSubClassificationMapper.getSubClassification(travelSubClassification);
    }



    public List<TravelModuleDetail> selectMap(){
        return travelScenicSpotMapper.selectMap();
    }
}
