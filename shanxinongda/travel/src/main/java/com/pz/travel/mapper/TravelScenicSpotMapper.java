package com.pz.travel.mapper;

import com.pz.travel.domain.TravelModuleDetail;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;
import java.util.List;

public interface TravelScenicSpotMapper extends Mapper<TravelModuleDetail> {

    List<TravelModuleDetail> getTravelScenicSpotsByRecognitionLibraryIds(String[] ids);

    List<TravelModuleDetail> travelScenicSpotsRandom(@Param("excludeIds") String[] excludeIds, @Param("count") Integer count);

    //通过二级分类查询
    List<TravelModuleDetail> selectTravelScenicSpotList(@Param("subClassificationId") Long subClassificationId,@Param("blockId") String blockId);
    //通过景点名称搜索景点列表
    List<TravelModuleDetail> travelScenicSpotName(@Param("name") String str);

    List<TravelModuleDetail> travelScenicSpotInformations(String[] ids);

    //通过id获取景点详情
    TravelModuleDetail travelScenicSpotInformation(Long id);


    List<TravelModuleDetail> selectMap();

    List<TravelModuleDetail> selectUserMap(@Param("userId") Long userId,@Param("type")Integer type);
    Long travelScenicSpotIdByVrType(String vrType);

    //通过景点ID获取预约表中起始时间

    //通过景点id获取VR表中对应identify字段
    String selectIdentify(Long id);

    //获取景点列表
    List<TravelModuleDetail> getActivityList(TravelModuleDetail travelModuleDetail);

    //获取VR列表
    List<TravelModuleDetail> getVrList(TravelModuleDetail travelModuleDetail);

    //景点浏览量
    TravelModuleDetail getPageviewsAndLikes(Long id);
    int updatePageViews(Long id);

    //景点点赞
    int updateLikes(Long scenicSpotId);
    //取消点赞
    int cancelLikes(Long scenicSpotId);

    TravelModuleDetail getTravelModuleDetailByRecognitionLibraryId(String recognitionLibraryId);

    Date getDataLastTime();
}
