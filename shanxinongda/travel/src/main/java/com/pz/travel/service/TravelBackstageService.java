package com.pz.travel.service;

import cn.hutool.json.JSONUtil;
import com.pz.travel.domain.TravelModelVideo;
import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.common.CommonConstant;
import com.pz.travel.domain.TravelJoint;
import com.pz.travel.domain.TravelModuleDetail;
import com.pz.travel.mapper.*;

import com.ruoyi.common.exception.BaseException;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.sign.Md5Utils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.geo.*;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class TravelBackstageService {
    @Autowired
    private TravelBackstageMapper travelBackstageMapper;
    @Autowired
    private TravelJointMapper travelJointMapper;
    @Autowired
    private TravelScenicSpotMapper travelScenicSpotMapper;
    @Autowired
    private TravelJointService travelJointService;
    @Autowired
    private TravelRecognitionLibraryService travelRecognitionLibraryService;
    @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private IdWorker idWorker;
    @Autowired
    private TravelModelVideoMapper travelModelVideoMapper;
    /**
     * 查询景点
     * @return
     */
    public List<TravelModuleDetail> selectTravelModuleDetailByName
    (Long clafficationId, String name,Long spotScenicId,Integer isVr,Long moduleId,String remarks){

        List<TravelModuleDetail> travelModuleDetails = travelBackstageMapper.selectTravelModuleDetailByName(clafficationId, name,spotScenicId,isVr,moduleId,remarks);
        if (CollectionUtils.isEmpty(travelModuleDetails)) {
            return travelModuleDetails;
        }
        List<String> ids = travelModuleDetails.stream()
                .map(travel -> {
                    travel.setTravelJointList(distinctTravelJoints(travelJointMapper.selectClassification(travel.getId())));
                    travel.setTravelModelVideos(getTravelModelVideos(travel.getId()));
                    travel.setRelateDetailIds(JSONUtil.toList(travel.getRelateDetailId(), String.class));
                    return travel.getRelateDetailIds();
                })
                .flatMap(List::stream)
                .distinct()
                .collect(Collectors.toList());

        if (!CollectionUtils.isEmpty(ids)) {
            Example example = new Example(TravelModuleDetail.class);
            example.createCriteria().andIn("id", ids);
            List<TravelModuleDetail> travelModuleDetails1 = travelBackstageMapper.selectByExample(example);
            Map<String, TravelModuleDetail> map = travelModuleDetails1.stream().collect(Collectors.toMap(
                    travel -> String.valueOf(travel.getId()),
                    travel -> travel
            ));

            for (TravelModuleDetail travel: travelModuleDetails) {
                if (!CollectionUtils.isEmpty(travel.getRelateDetailIds())) {
                    travel.getRelateDetailIds().forEach(id -> {
                        if (map.containsKey(id)) {
                            if (travel.getRelateDetailList() == null) {
                                ArrayList<TravelModuleDetail> list = new ArrayList<>();
                                list.add(map.get(id));
                                travel.setRelateDetailList(list);
                            } else {
                                travel.getRelateDetailList().add(map.get(id));
                            }
                        }
                    });
                }
            }
        }

        return  travelModuleDetails;
    }


    public List<TravelModuleDetail> select(TravelModuleDetail travelModuleDetail)
          {

              // 1.分页查询数据
              List<TravelModuleDetail> travelModuleDetails = travelBackstageMapper.selectTravelModuleDetail(travelModuleDetail);

              // 2.获取关联景点id
              List<String> ids = travelModuleDetails.stream().map(travel -> {
                  travel.setRelateDetailIds(JSONUtil.toList(travel.getRelateDetailId(), String.class));
                  return travel.getRelateDetailIds();
              }).flatMap(List::stream).distinct().collect(Collectors.toList());

              // 3.查看关联景点记录
              List<TravelModuleDetail> relateTravelModuleDetails;
              if (!CollectionUtils.isEmpty(ids)) {
                  Example example = new Example(TravelModuleDetail.class);
                  example.createCriteria().andIn("id", ids);
                  relateTravelModuleDetails = travelBackstageMapper.selectByExample(example);
              } else {
                  relateTravelModuleDetails = new ArrayList<>();
              }

              // 4.将关联景点转换为map，key为id，value为TravelModuleDetail
              Map<String, TravelModuleDetail> map = relateTravelModuleDetails.stream().collect((Collectors.toMap(
                      travel -> String.valueOf(travel.getId()),
                      travel -> travel
              )));


              // 5.填充关联记录
              travelModuleDetails.forEach(travel -> {
                  travel.setTravelModelVideos(getTravelModelVideos(travel.getId()));
                  List<String> list = travel.getRelateDetailIds();
                  ArrayList<TravelModuleDetail> details = new ArrayList<>();
                  if (!CollectionUtils.isEmpty(list)) {
                      list.forEach(relateId -> {
                          if (map.containsKey(relateId)) {
                              details.add(map.get(relateId));
                          }
                      });
                  }
                  travel.setRelateDetailList(details);
              });
              return  travelModuleDetails;
    }
    /**
     * 更新
     */
    public Integer update (TravelModuleDetail travelModuleDetail) {
        return travelBackstageMapper.updateByPrimaryKeySelective(travelModuleDetail);
    }

    /**
     * 新增景点
     * @param travelModuleDetail
     * @return
     */
    @Transactional
    public int insertTravelModuleDetail(TravelModuleDetail travelModuleDetail)   throws  CustomException{
        Long id=idWorker.nextId();
        travelModuleDetail.setId(id);
        travelModuleDetail.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());//获取当前用户id
        travelModuleDetail.setCreateTime(DateUtils.getNowDate());//获取当前系统时间
        if (!CollectionUtils.isEmpty(travelModuleDetail.getRelateDetailIds())&&!travelModuleDetail.getRelateDetailIds().equals("")) {
            Example example = new Example(TravelModuleDetail.class);
            example.createCriteria().andIn("id", travelModuleDetail.getRelateDetailIds());

            int count = travelBackstageMapper.selectCountByExample(example);
            if (count != travelModuleDetail.getRelateDetailIds().size()) {
                throw new BaseException("某些关联景点不存在");
            }
            travelModuleDetail.setRelateDetailId(JSONUtil.toJsonStr(travelModuleDetail.getRelateDetailIds()));
        }


      //  List<TravelJoint> travelJointList=travelModuleDetail.getTravelJointList();//向关联表中插入分类

        if(travelModuleDetail.getTravelJointList()!=null&&travelModuleDetail.getTravelJointList().size()!=0) {
            List<TravelJoint> travelJointList=travelModuleDetail.getTravelJointList();//向关联表中插入分类
            for (TravelJoint travelJoint : travelJointList) {
                travelJoint.setId(idWorker.nextId());
                travelJoint.setScenicId(id);//该景点的id
            }
            travelJointMapper.insertTravelJoint(travelJointList);
        }
        // 兼容：前端可能把数字类型的列（blockId 对应 INT）以空字符串传来，导致 MySQL 拒绝写入
        if (travelModuleDetail.getBlockId() != null && travelModuleDetail.getBlockId().trim().isEmpty()) {
            travelModuleDetail.setBlockId(null);
        }
        int result =  travelBackstageMapper.insertSelective(travelModuleDetail);
        if (result == 1) {
            saveTravelModelVideos(id, travelModuleDetail.getTravelModelVideos());
        }
        if(result == 1 && StringUtils.isNotBlank(travelModuleDetail.getLongitude())) {

           try { //travelScenicSpotMapper.travelScenicSpotInformation(travelModuleDetail.getId())
               String[] strarray = travelModuleDetail.getLongitude().split(",");

               Point point = new Point(Double.valueOf(strarray[1]), Double.valueOf(strarray[0]));
               redisTemplate.opsForGeo().add(CommonConstant.TRAVEL_GEO_KEY, point, String.valueOf(travelModuleDetail.getId()));
           }catch (Exception e){
                throw new  CustomException("经纬度填写错误");
            }
        }



        return result;
    }

    /**
     * 修改景点信息
     * @param travelModuleDetail
     * @return
     */
    @Transactional
    public int updateTravelModuleDetail(TravelModuleDetail travelModuleDetail)  throws CustomException {

        TravelModuleDetail travelModuleDetail2 = new TravelModuleDetail();
        travelModuleDetail2.setId(travelModuleDetail.getId());
        TravelModuleDetail travelModuleDetail1 = travelBackstageMapper.selectOne(travelModuleDetail2);
        // 兼容 selectOne 查不到记录的情况：跳过 inx 重排比较
        if (travelModuleDetail1 != null
                && travelModuleDetail1.getInx() != null
                && !travelModuleDetail1.getInx().equals(travelModuleDetail.getInx())) {

          TravelModuleDetail travelModuleDetail3 = new TravelModuleDetail();
          travelModuleDetail3.setInx(travelModuleDetail.getInx());
          if(travelBackstageMapper.select(travelModuleDetail3).size()!=0){
                    travelBackstageMapper.updateOrderBy(travelModuleDetail.getInx().toString());
          }
        }

        if (!CollectionUtils.isEmpty(travelModuleDetail.getRelateDetailIds())) {
            Example example = new Example(TravelModuleDetail.class);
            example.createCriteria().andIn("id", travelModuleDetail.getRelateDetailIds());

            int count = travelBackstageMapper.selectCountByExample(example);
            if (count != travelModuleDetail.getRelateDetailIds().size()) {
                throw new BaseException("某些关联景点不存在");
            }
            travelModuleDetail.setRelateDetailId(JSONUtil.toJsonStr(travelModuleDetail.getRelateDetailIds()));
        }

        travelJointMapper.deleteScenic(travelModuleDetail.getId());
        if(travelModuleDetail.getTravelJointList()!=null&&travelModuleDetail.getTravelJointList().size()!=0) {
            List<TravelJoint> travelJointList=travelModuleDetail.getTravelJointList();//向关联表中插入分类
            for (TravelJoint travel : travelJointList) {
                travel.setId(idWorker.nextId());
                travel.setScenicId(travelModuleDetail.getId());
            }


            travelJointMapper.insertTravelJoint(travelJointList);

        }
        if(travelModuleDetail.getVideoUrl()==null){

            travelModuleDetail.setVideoUrl("");
        }
        // 兼容：前端可能把数字类型的列（blockId 对应 INT）以空字符串传来，导致 MySQL 拒绝写入
        if (travelModuleDetail.getBlockId() != null && travelModuleDetail.getBlockId().trim().isEmpty()) {
            travelModuleDetail.setBlockId(null);
        }
        int result = travelBackstageMapper.updateByPrimaryKeySelective(travelModuleDetail);
        if (result == 1) {
            saveTravelModelVideos(travelModuleDetail.getId(), travelModuleDetail.getTravelModelVideos());
        }
        if(result == 1) {
            TravelModuleDetail travelDetail = travelScenicSpotMapper.travelScenicSpotInformation(travelModuleDetail.getId());
            if (travelDetail != null) {
                try{if(travelDetail.getStatus() == 1 && StringUtils.isNotBlank(travelDetail.getLongitude())) {
                    String[] strarray  = travelDetail.getLongitude().split(",");

                    Point point = new Point(Double.valueOf(strarray[1]), Double.valueOf(strarray[0]));
                    redisTemplate.opsForGeo().add(CommonConstant.TRAVEL_GEO_KEY, point, String.valueOf(travelModuleDetail.getId()));
                }else {
                    redisTemplate.opsForGeo().remove(CommonConstant.TRAVEL_GEO_KEY, String.valueOf(travelModuleDetail.getId()));
                }
            }
                catch (Exception e){
                    throw new  CustomException("经纬度填写错误");
                }
            }
        }

        return result;
    }

    /**
     * 删除景点
     * @param id
     * @return
     */
    @Transactional(rollbackFor = Throwable.class)
    public int deleteTravelModuleDetail(Long id){
        int count = travelRecognitionLibraryService.getRecognitionLibraryCountByModuleDetailId(id);
        if(count > 0) {
            throw new BaseException("501", "存在识别库资源，请先删除识别库资源");
        }
        travelJointService.deleteScenic(id);//删除关联表中景点id
        int result =  travelBackstageMapper.deleteTravelModuleDetailById(id);
        Example example = new Example(TravelModelVideo.class);
        example.createCriteria().andEqualTo("modelId", id);
        travelModelVideoMapper.deleteByExample(example);
        if(result==1) {
            redisTemplate.opsForGeo().remove(CommonConstant.TRAVEL_GEO_KEY, String.valueOf(id));
        }

        return result;
    }

    private List<TravelModelVideo> getTravelModelVideos(Long modelId) {
        Example example = new Example(TravelModelVideo.class);
        example.createCriteria().andEqualTo("modelId", modelId);
        example.setOrderByClause("inx asc, id asc");
        return travelModelVideoMapper.selectByExample(example);
    }

    private void saveTravelModelVideos(Long modelId, List<TravelModelVideo> travelModelVideos) {
        Example example = new Example(TravelModelVideo.class);
        example.createCriteria().andEqualTo("modelId", modelId);
        travelModelVideoMapper.deleteByExample(example);
        if (CollectionUtils.isEmpty(travelModelVideos)) {
            return;
        }
        int defaultInx = 1;
        for (TravelModelVideo travelModelVideo : travelModelVideos) {
            if (travelModelVideo == null || StringUtils.isBlank(travelModelVideo.getUrl())) {
                continue;
            }
            travelModelVideo.setId(idWorker.nextId());
            travelModelVideo.setModelId(modelId);
            if (travelModelVideo.getInx() == null) {
                travelModelVideo.setInx(defaultInx);
            }
            travelModelVideoMapper.insertSelective(travelModelVideo);
            defaultInx++;
        }
    }

    private List<TravelJoint> distinctTravelJoints(List<TravelJoint> travelJoints) {
        if (CollectionUtils.isEmpty(travelJoints)) {
            return travelJoints;
        }
        return new ArrayList<>(travelJoints.stream()
                .filter(travelJoint -> travelJoint != null && StringUtils.isNotBlank(travelJoint.getClassificationId()))
                .collect(Collectors.toMap(
                        TravelJoint::getClassificationId,
                        travelJoint -> travelJoint,
                        (left, right) -> left,
                        LinkedHashMap::new
                ))
                .values());
    }



    private static double EARTH_RADIUS = 6378.137;

    private static double rad(double d) {
        return d * Math.PI / 180.0;
    }


    public static String getDistance(String lat1Str, String lng1Str, String lat2Str, String lng2Str) {
        Double lat1 = Double.parseDouble(lat1Str);
        Double lng1 = Double.parseDouble(lng1Str);
        Double lat2 = Double.parseDouble(lat2Str);
        Double lng2 = Double.parseDouble(lng2Str);

        double radLat1 = rad(lat1);
        double radLat2 = rad(lat2);
        double difference = radLat1 - radLat2;
        double mdifference = rad(lng1) - rad(lng2);
        double distance = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(difference / 2), 2)
                + Math.cos(radLat1) * Math.cos(radLat2)
                * Math.pow(Math.sin(mdifference / 2), 2)));
        distance = distance * EARTH_RADIUS;
        distance = Math.round(distance * 10000) / 10000;
        String distanceStr = distance+"";
        distanceStr = distanceStr.
                substring(0, distanceStr.indexOf("."));

        return distanceStr;
    }









}
