package com.pz.travel.mapper;

import com.pz.travel.domain.TravelJoint;
import com.pz.travel.domain.TravelModuleDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TravelJointMapper {
    /**查询某景点的分类id*/
    List<TravelJoint> selectClassification(Long scenicId);

    int insertTravelJoint(List<TravelJoint> travelJointList);


    int delete(@Param("classification") Long classification,@Param("scenicId") Long scenicId);
    /**
     * 删除分类id
     */
    int deleteClassification(Long id);

    int deleteScenic(@Param("scenicId") Long scenicId);

    /**
     * 通过分类查询景点
     * @param classificationId
     * @return
     */
    List<TravelModuleDetail> selectScenicByClassificatin(@Param("classificationId") Long classificationId);
}
