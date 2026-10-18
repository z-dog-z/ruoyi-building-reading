package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.TravelVideo;
import com.pz.travel.mapper.TravelVideoMapper;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @CLASSNAME TravelVideoService
 * @Author ymliu
 * @Date 2022/1/19、14:08
 */

@Service
public class TravelVideoService  {


    @Autowired
    private TravelVideoMapper travelVideoMapper;


    @Autowired
    private IdWorker idWorker;

    public TravelVideo save(TravelVideo travelModel){

        travelModel.setId(idWorker.nextId());
        travelModel.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());

        travelModel.setCreateTime(DateUtils.getNowDate());
        travelVideoMapper.insertSelective(travelModel);

        return travelModel;
    }


    public List<TravelVideo> list(TravelVideo travelVideo){
        // 使用 Example 构建条件，并按 inx 升序（宣传视频后台排序生效）
        Example example = new Example(TravelVideo.class);
        Example.Criteria criteria = example.createCriteria();
        if (travelVideo.getId() != null) {
            criteria.andEqualTo("id", travelVideo.getId());
        }
        if (travelVideo.getType() != null) {
            criteria.andEqualTo("type", travelVideo.getType());
        }
        if (travelVideo.getModelId() != null) {
            criteria.andEqualTo("modelId", travelVideo.getModelId());
        }
        if (travelVideo.getTourId() != null) {
            criteria.andEqualTo("tourId", travelVideo.getTourId());
        }
        if (StringUtils.isNotBlank(travelVideo.getName())) {
            criteria.andLike("name", "%" + travelVideo.getName().trim() + "%");
        }
        // inx 为空的排最后，其余按 inx 升序，同序按 id
        example.setOrderByClause("inx is null, inx asc, id asc");

        List<TravelVideo> towns = travelVideoMapper.selectByExample(example);

        if(travelVideo.getId()==null&&travelVideo.getType()!=null&&travelVideo.getType()==3){
            for (TravelVideo town:towns) {
                if(town.getStartDate()!=null && town.getStartDate().after(DateUtils.getNowDate())){
                    town.setStatus(0);
                }
                else  if (town.getEndDate()!=null && town.getEndDate().before(DateUtils.getNowDate())){
                    town.setStatus(2);
                }
                else {
                    town.setStatus(1);
                }
            }
        }
        return towns;
    }

    public int delete(Long id){
        return  travelVideoMapper.deleteByPrimaryKey(id);
    }


    public TravelVideo detail(Long id){
       TravelVideo travelVideo =   travelVideoMapper.selectByPrimaryKey(id);

       travelVideo.setCount(travelVideo.getCount()+1);

       travelVideoMapper.updateByPrimaryKeySelective(travelVideo);
       return  travelVideo;
    }

    public  TravelVideo  update (TravelVideo travelVideo){
        travelVideoMapper.updateByPrimaryKeySelective(travelVideo);
        return  travelVideo;
    }

}
