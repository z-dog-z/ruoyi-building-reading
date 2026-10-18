package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelRecognitionLibrary;
import com.pz.travel.mapper.TravelRecognitionLibraryMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelRecognitionLibraryService {
    @Autowired
    private TravelRecognitionLibraryMapper travelRecognitionLibraryMapper;
    @Autowired
    private IdWorker idWorker;

    /**
     * 根据景点id获取识别库数量
     * @param moduleDetailId
     * @return
     */
    public Integer getRecognitionLibraryCountByModuleDetailId(Long moduleDetailId){
        TravelRecognitionLibrary travelRecognitionLibrary = new TravelRecognitionLibrary();
        travelRecognitionLibrary.setModuleDetailId(moduleDetailId);
        return travelRecognitionLibraryMapper.selectCount(travelRecognitionLibrary);
    }
    /**
     * 通过名称搜索识别库
     * @param filename
     * @return
     */
    public List<TravelRecognitionLibrary> selectTravelRecognitionLibraryByName(String filename){
        return travelRecognitionLibraryMapper.selectTravelRecognitionLibraryByName(filename);
    }

    /**
     * 新增
     * @param travelRecognitionLibrary
     * @return
     */
    public int insertTravelRecognitionLibrary(TravelRecognitionLibrary travelRecognitionLibrary){
        travelRecognitionLibrary.setId(idWorker.nextId());
        travelRecognitionLibrary.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());
        travelRecognitionLibrary.setCreateTime(DateUtils.getNowDate());
        return travelRecognitionLibraryMapper.insertTravelRecognitionLibrary(travelRecognitionLibrary);
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    public int deleteTravelRecognitionLibraryByIds(Long[] ids){
        return travelRecognitionLibraryMapper.deleteTravelRecognitionLibraryByIds(ids);
    }
}
