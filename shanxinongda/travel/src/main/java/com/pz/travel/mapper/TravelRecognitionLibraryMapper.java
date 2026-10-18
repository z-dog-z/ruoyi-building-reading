package com.pz.travel.mapper;

import com.pz.travel.domain.TravelRecognitionLibrary;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TravelRecognitionLibraryMapper extends Mapper<TravelRecognitionLibrary> {
    /**
     * 通过景点名称搜索识别库
     * @param filename
     * @return
     */
    public List<TravelRecognitionLibrary> selectTravelRecognitionLibraryByName(@Param("filename") String filename);

    /**
     * 新增
     * @param travelRecognitionLibrary
     * @return
     */
    public int insertTravelRecognitionLibrary(TravelRecognitionLibrary travelRecognitionLibrary);

    /**
     * 批量删除
     * @param ids
     * @return
     */
    public int deleteTravelRecognitionLibraryByIds(Long[] ids);
}
