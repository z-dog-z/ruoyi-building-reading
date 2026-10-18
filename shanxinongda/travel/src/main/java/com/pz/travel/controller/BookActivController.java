package com.pz.travel.controller;

import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.BookActiv;
import com.pz.travel.service.BookActivService;
import com.ruoyi.common.core.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @CLASSNAME BookActivController
 * @Author ymliu
 * @Date 2022/8/31、11:32
 */
@RestController
@RequestMapping("/activ")
public class BookActivController extends BaseController {

    @Autowired
    BookActivService bookActivService;



    /**
     * 查询
     * @return
     */
    @GetMapping("/list")
    public CommonResult<BookActiv> list(BookActiv bookActiv){

        List<BookActiv> bookActivs = bookActivService.list(bookActiv);

        return CommonResult.success().setResult(bookActivs);
    }




    /**
     * 新增
     * @param bookActiv
     * @return
     */
    @PostMapping("/add")
    public CommonResult<BookActiv> add(@RequestBody BookActiv bookActiv){


        return CommonResult.success().setResult(bookActivService.save(bookActiv));
    }

    /**
     * 修改
     * @param bookActiv
     * @return
     */
    @PostMapping("/update")
    public CommonResult<BookActiv> update(@RequestBody BookActiv bookActiv){
        return CommonResult.success().setResult(bookActivService.update(bookActiv));
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @DeleteMapping("/delete")
    public CommonResult<BookActiv> delete(Long  id){

        return CommonResult.success().setResult(bookActivService.delete(id));
    }
}
