package com.pz.travel.mapper;

import com.pz.travel.domain.WxData;
import com.pz.travel.domain.vo.TravelStatisticsBaseVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WxDataMapper {

    List<WxData> SelectScenicAll();

    List<WxData> SelectScenicYes();

    List<WxData> SelectView();

    TravelStatisticsBaseVo selectBaseStatistics();

    List<WxData> selectRecognitionRank(@Param("limit") Integer limit);

    List<WxData> selectVrRank(@Param("limit") Integer limit);

    List<WxData> selectHotRank(@Param("limit") Integer limit);

    List<WxData> selectScenicSourceStats(@Param("eventType") Integer eventType);

    List<WxData> selectViewSourceStats();
}
