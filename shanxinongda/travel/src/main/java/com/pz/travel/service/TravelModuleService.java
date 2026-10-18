package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelModule;
import com.pz.travel.mapper.TravelModuleMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelModuleService {
    @Autowired
    private TravelModuleMapper travelModuleMapper;
    @Autowired
    private IdWorker idWorker;

    public List<TravelModule> selectTravelModule(TravelModule travelModule){
        return travelModuleMapper.selectTravelModule(travelModule);
    }
    /**
     * 新增栏目
     * @param travelModule
     * @return
     */
    public int insertTravelModule(TravelModule travelModule){
        travelModule.setId(idWorker.nextId());
        travelModule.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());
        travelModule.setCreateTime(DateUtils.getNowDate());
        return travelModuleMapper.insertTravelModule(travelModule);
    }

    /**
     * 删除栏目
     * @param id
     * @return
     */
    public int deleteTravelModule(Long id){
        return travelModuleMapper.deleteTravelModule(id);
    }
}
