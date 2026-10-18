package com.pz.travel.mapper;

import com.pz.travel.domain.TravelSubClassification;

import java.util.List;

public interface TravelSubClassificationMapper {
    /**查询二级分类*/
    List<TravelSubClassification> selectTravelSubclassfication(TravelSubClassification travelSubClassification);

    /**插入二级分类*/
    int insertTravelSubClassification(TravelSubClassification travelSubClassification);

    /**修改二级分类*/
    int updateTravelSubClassfication(TravelSubClassification travelSubClassification);

    /**删除二级分类*/
    int deleteTravelSubClassficationById(Long id);

    List<String> getSubClassification(TravelSubClassification travelSubClassification);
}
