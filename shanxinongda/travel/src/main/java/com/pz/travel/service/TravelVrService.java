package com.pz.travel.service;

import com.pz.travel.domain.TravelVr;
import com.pz.travel.mapper.TravelVrMapper;
import com.ruoyi.common.exception.BaseException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.IdWorker;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

@Service
public class TravelVrService {
    @Value("${travel.vrUrl}")
    private String travelVrUrl;
    @Autowired
    private TravelVrMapper travelVrMapper;
    @Autowired
    private IdWorker idWorker;


    public List<TravelVr> selectTravelVr(){
        List<TravelVr> travelVrs = travelVrMapper.selectTravelVr();
        setTravelVrUrl(travelVrs);
        return travelVrs;
    }

    /**
     * 通过名称搜索相应的VR
     * @param name
     * @return
     */
    public List<TravelVr> selectTravelVrByName(String name){
        List<TravelVr> travelVrs = travelVrMapper.selectTravelVrByName(name);
        setTravelVrUrl(travelVrs);
       // https://ar-travel-file.1jiaohu.com/vtour/tour.html?type=v1
        return travelVrs;
    }

    /**
     * 新增VR
     * @param travelVr
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public int insertVr(TravelVr travelVr){
        validateTravelVr(travelVr, false);
        travelVr.setId(idWorker.nextId());
        travelVr.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());
        travelVr.setCreateTime(DateUtils.getNowDate());
        if (travelVr.getStatus() == null) {
            travelVr.setStatus(1);
        }
        return travelVrMapper.insertSelective(travelVr);
    }

    /**
     * 修改VR信息
     * @param travelVr
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public int modifyVr(TravelVr travelVr){
        validateTravelVr(travelVr, true);
        return travelVrMapper.modifyVr(travelVr);
    }

    /**
     * 修改VR是否启用的状态
     * @param id
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public int modifyVrStatus(int status,Long id){
        TravelVr travelVr = travelVrMapper.selectByPrimaryKey(id);
        if (travelVr == null) {
            throw new BaseException("VR数据不存在");
        }
        travelVr.setStatus(status);
        travelVrMapper.updateByPrimaryKeySelective(travelVr);
        return travelVrMapper.modifyVrStatus(status,id);
    }

    /**
     * 删除VR
     * @param id
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public int deleteVr(Long id){
        TravelVr travelVr = travelVrMapper.selectByPrimaryKey(id);
        if (travelVr == null) {
            throw new BaseException("VR数据不存在");
        }
        travelVrMapper.deleteVrRelation(id);
        return travelVrMapper.deleteByPrimaryKey(id);
    }

    private void validateTravelVr(TravelVr travelVr, boolean checkId) {
        if (travelVr == null) {
            throw new BaseException("VR数据不能为空");
        }
        if (checkId && travelVr.getId() == null) {
            throw new BaseException("VR主键不能为空");
        }
        if (StringUtils.isBlank(travelVr.getName())) {
            throw new BaseException("VR名称不能为空");
        }
        if (StringUtils.isBlank(travelVr.getIdentify())) {
            throw new BaseException("VR标识不能为空");
        }
        if (existsIdentify(travelVr.getIdentify(), checkId ? travelVr.getId() : null)) {
            throw new BaseException("VR标识已存在");
        }
    }

    private boolean existsIdentify(String identify, Long excludeId) {
        Example example = new Example(TravelVr.class);
        Example.Criteria criteria = example.createCriteria().andEqualTo("identify", identify);
        if (excludeId != null) {
            criteria.andNotEqualTo("id", excludeId);
        }
        return travelVrMapper.selectCountByExample(example) > 0;
    }

    private void setTravelVrUrl(List<TravelVr> travelVrs) {
        travelVrs.forEach(travelVr -> travelVr.setTravelVrUrl(travelVrUrl + "?type=" + travelVr.getIdentify()));
    }
}
