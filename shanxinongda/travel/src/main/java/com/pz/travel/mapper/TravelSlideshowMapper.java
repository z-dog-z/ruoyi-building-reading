package com.pz.travel.mapper;

import com.pz.travel.domain.TravelSlideshow;
import tk.mybatis.mapper.common.Mapper;

public interface TravelSlideshowMapper extends Mapper<TravelSlideshow> {

    /**
     * 随机获取一条轮播图记录
     * @return
     */
    public TravelSlideshow slideshowRandom();

    /**
     * 删除首页轮播图照片
     * @return
     */
    int deleteSlideshow(Long id);

    /**
     * 获取所有启用的轮播图（status=1）
     * @return
     */
    java.util.List<TravelSlideshow> listAllActive();
}
