package com.pz.travel.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.pz.travel.config.IdSerializer;
import com.ruoyi.common.annotation.Excel;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import javax.persistence.Transient;
import java.util.List;

/**
 * 景点对象 travel_module_detail
 *
 * @author ruoyi
 * @date 2020-11-25
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class TravelModuleDetail extends TravelBaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @Id
    @JsonSerialize(using = IdSerializer.class)
    private Long id;

    /**
     * 模块id
     */
    @JsonSerialize(using = IdSerializer.class)
    @Excel(name = "模块id")
    private Long moduleId;

    /**
     * 二级分类id
     */
    @Transient
    @Excel(name = "二级分类id")
    @JsonSerialize(using = IdSerializer.class)
    private Long subClassificationId;

    /**
     * 景点名称
     */
    @Excel(name = "景点名称")
    private String name;
    /**
     * 英文景点名称
     */
    @Excel(name = "英文景点名称")
    private String englishName;

    /**
     * 景点标题
     */
    @Excel(name = "景点标题")
    private String title;

    /**
     * 景点副标题
     */
    @Excel(name = "景点副标题")
    private String subTitle;

    /**
     * 景点图片
     */
    @Excel(name = "景点图片")
    private String pictureUrl;

    /**
     * 视频
     */
    @Excel(name = "视频")
    private String videoUrl;

    /**
     * 景点音频
     */
    @Excel(name = "景点音频")
    private String audioUrl;

    /**
     * 英文景点地址
     */
    @Excel(name = "景点地址")
    private String address;

    /**
     * 景点内容链接
     */
    @Excel(name = "景点内容链接")
    private String contentLink;
    /**
     * 景点内容
     */
    @Excel(name = "景点内容")
    private String content;

    /**
     * 状态，0：失效 1：正常
     */
    @Excel(name = "状态，0：失效 1：正常")
    private Integer status;

    /**
     * 经度
     */
    @Excel(name = "经度")
    private String longitude;

    /**
     * 纬度
     */
    @Excel(name = "纬度")
    private String latitude;

    /**x
     * 景点简介
     */
    @Excel(name = "景点简介")
    private String introduction;

    /**
     * 英文景点内容
     */
    @Excel(name = "英文景点内容")
    private String englishIntroduction;
    /**
     * 是否存在VR，0：不存在，1：存在
     */
    @Excel(name = "是否存在VR，0：不存在，1：存在")
    private Integer isVr;

    /**
     * vr_id
     */
    @Excel(name = "vr_id")
    private Long vrId;

    /**
     * VR图浏览量
     */
    @Excel(name = "VR图浏览量")
    private Long pageviews;

    /**
     * 点赞量
     */
    @Excel(name = "点赞量")
    private Long likes;

    /**
     * 手机号
     */
    @Excel(name = "手机号")
    private String phoneNumber;

    /**
     *景点排序
     */
    @Excel(name="排序")
    private Integer inx;

    /**背景图*/
    @Excel(name="背景图")
    private String backgroundCover;

    /**视频封面*/
    @Excel(name="视频封面")
    private String videoCover;

    /**中文地址*/
    @Excel(name="中文地址")
    private String remarks;

    /**中文开放时间*/
    @Excel(name="中文开放时间")
    private String chineseOpenTime;

    /**英文开放时间*/
    @Excel(name="英文开放时间")
    private String englishOpenTime;

    /**
     * 门票信息
     */
    @Excel(name="门票信息")
    private String ticket;

    /**
     * 英文门票信息
     */
    @Excel(name="英语门票信息")
    private String englishTicket;

    /**
     * 建筑级别
     */
    @Excel(name="门票信息")
    private String level;
    /** 用户识别是否打开 0.关  1开
     */
    @Excel(name="用户识别是否打开")
    private  Integer isUser;
    /**
     * 历史人物逗号隔开
     */
    @Excel(name="历史人物")
    private String human;
    /**
     * 英文建筑级别
     */
    @Excel(name="英语门票信息")
    private String englishLevel;

    @Excel(name="关联景点id")
    private String relateDetailId;
    /**关联表*/
    @Transient
    private List<TravelJoint> travelJointList;

    /**VR地址*/
    @Transient
    private String vrUrl;

    /**是否可预约*/
    @Transient
    private Boolean isAppointment;

    @Transient
    @JsonIgnore
    private Integer distanceWithSort;

    @Transient
    private String distance;
    /**
     * 音频列表
     */
    @Transient
    private List<TravelModelVideo> travelModelVideos;

    private String blockId;
    private Integer deleted;
    private  Integer activity;
    private  String activityUrl;
    private  String activityName;

    @Transient
    private List<TravelVideo> travelVideoList;

    @Transient
    private  Integer clock;

    @Transient
    private  Integer clockCount;

    /**
     * 相关景点id
     */
    @JsonSetter
    @Transient
    private List<String> relateDetailIds;

    /**
     * 相关景点集合
     */
    @Transient
    private List<TravelModuleDetail> relateDetailList;


}

