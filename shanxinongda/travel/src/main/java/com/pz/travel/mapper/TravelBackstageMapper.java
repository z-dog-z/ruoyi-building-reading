package com.pz.travel.mapper;

import com.pz.travel.domain.TravelModuleDetail;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TravelBackstageMapper extends Mapper<TravelModuleDetail> {

    /** 通过分类和景点名搜索景点*/
    public List<TravelModuleDetail> selectTravelModuleDetailByName
    (@Param("subClassficationId") Long subClassficationId,
     @Param("name") String name,
     @Param("spotScenicId") Long spotScenicId,
     @Param("isVr") Integer isVr,
     @Param("moduleId") Long moduleId,
     @Param("remarks") String remarks);
    /** 新增景点*/
    public int insertTravelModuleDetail(TravelModuleDetail travelModuleDetail);
    /** 修改景点*/
    public int updateTravelModuleDetail(TravelModuleDetail travelModuleDetail);
    /** 删除景点*/
    public int deleteTravelModuleDetailById(Long id);

    public int  updateOrderBy(String orderby);

    List<TravelModuleDetail> selectTravelModuleDetail(TravelModuleDetail travelModuleDetail);
}
