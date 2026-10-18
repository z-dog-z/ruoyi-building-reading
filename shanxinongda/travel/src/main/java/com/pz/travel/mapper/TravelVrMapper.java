package com.pz.travel.mapper;

import com.pz.travel.domain.TravelVr;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TravelVrMapper extends Mapper<TravelVr> {
    /**
     * 通过名称搜索VR
     * @param name
     * @return
     */
    public List<TravelVr> selectTravelVrByName(@Param("name") String name);

    /**
     * 修改VR名称和封面图
     * @param travelVr
     * @return
     */
    int modifyVr(TravelVr travelVr);

    /**
     * 返回状态码为1的VR列表
     * @return
     */
    List<TravelVr> selectTravelVr();

    /**
     * 修改VR是否启用的状态
     * @param id
     * @return
     */
    public int modifyVrStatus(@Param("status") int status ,@Param("id") Long id);

    /**
     * 删除VR前清理景点中的VR关联关系
     * @param id
     * @return
     */
    int deleteVrRelation(@Param("id") Long id);
}
