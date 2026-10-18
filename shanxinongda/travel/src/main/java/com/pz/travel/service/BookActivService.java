package com.pz.travel.service;

import com.ruoyi.common.utils.IdWorker;
import com.pz.travel.domain.BookActiv;
import com.pz.travel.mapper.BookActivMapper;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @CLASSNAME BookActivService
 * @Author ymliu
 * @Date 2022/8/31、10:25
 */
@Service
public class BookActivService {


    @Autowired
    private BookActivMapper bookActivMapper;


    @Autowired
   private IdWorker idWorker;


    public BookActiv save(BookActiv bookActiv){
        bookActiv.setId(idWorker.nextId());
        bookActiv.setCreateTime(DateUtils.getNowDate());
        bookActiv.setCreateBy(SecurityUtils.getLoginUser().getUser().getUserId().toString());
        bookActivMapper.insertSelective(bookActiv);
        return  bookActiv;
    }


    public List<BookActiv> list(BookActiv bookActiv){
        return  bookActivMapper.select(bookActiv);
    }


    public int update(BookActiv bookActiv){
      return   bookActivMapper.updateByPrimaryKeySelective(bookActiv);
    }

    public int delete(Long id){
      return   bookActivMapper.deleteByPrimaryKey(id);
    }

}
