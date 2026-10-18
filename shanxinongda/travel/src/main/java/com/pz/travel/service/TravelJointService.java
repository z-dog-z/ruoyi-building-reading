package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelJoint;
import com.pz.travel.domain.TravelModuleDetail;
import com.pz.travel.mapper.TravelJointMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TravelJointService {
    @Autowired
    private TravelJointMapper travelJointMapper;
    @Autowired
    private IdWorker idWorker;

    public int insertTravelJoint(List<TravelJoint> travelJointList){
        for (TravelJoint travel:travelJointList
             ) {
            travel.setId(idWorker.nextId());
        }
        return travelJointMapper.insertTravelJoint(travelJointList);
    }

    public int delete(Long classification,Long scenicId){
        return travelJointMapper.delete(classification, scenicId);
    }

    /**
     * 根据分类id删除关联表记录
     * @param id
     * @return
     */
    public int deleteClassification(Long id){
        return travelJointMapper.deleteClassification(id);
    }

    /**
     * 根据景点id删除关联表记录
     * @param scenicId
     * @return
     */
    public int deleteScenic(Long scenicId){
        return travelJointMapper.deleteScenic(scenicId);
    }

    /**
     * 通过分类查id
     * @param classificationId
     * @return
     */
    public List<TravelModuleDetail> selectScenicByClassificatin(Long classificationId){
        return travelJointMapper.selectScenicByClassificatin(classificationId);
    }

    /**查询某景点的分类id*/
    public List<TravelJoint> selectClassification(Long scenicId){
        return travelJointMapper.selectClassification(scenicId);
    }


}
