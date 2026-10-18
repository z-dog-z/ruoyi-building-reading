package com.pz.travel.controller;

import com.pz.travel.common.BaseErrorCode;
import com.pz.travel.common.CommonResult;
import com.pz.travel.domain.vo.UploadVo;
import com.pz.travel.framework.cloud.CloudStorageService;
import com.pz.travel.framework.cloud.OSSFactory;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.exception.OssException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传
 */
@Controller
@RequestMapping("/travel/oss")
public class OssController extends BaseController {


    /**
     * 上传文件
     */
    //@PreAuthorize("@ss.hasPermi('sys:oss:add')")
    @PostMapping("/upload")
    @ResponseBody
    public CommonResult<UploadVo> upload(@RequestParam("file") MultipartFile file) throws Exception {

        if (file.isEmpty()) {
            throw new OssException("上传文件不能为空");
        }


//        // 上传文件
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        CloudStorageService storage = OSSFactory.build();
        String url = storage.uploadSuffix(file.getBytes(), suffix);
        UploadVo uploadVo = new UploadVo();
        uploadVo.setUrl(  url);
        uploadVo.setName(fileName);

        return CommonResult.ok().setResult(uploadVo);
    }


    /**
     * 上传文件
     */
    //@PreAuthorize("@ss.hasPermi('sys:oss:add')")
    @PostMapping("/admin/upload")
    @ResponseBody
    public CommonResult<UploadVo> upload(@RequestParam("file") MultipartFile file,
                                         @RequestHeader("token") String token) throws Exception {

        if (file.isEmpty()) {
            throw new OssException("上传文件不能为空");
        }

        // 上传文件
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        CloudStorageService storage = OSSFactory.build();
        String url = storage.uploadSuffix(file.getBytes(), suffix);
        UploadVo uploadVo = new UploadVo();
        uploadVo.setUrl(url);
        uploadVo.setName(fileName);
        return CommonResult.ok().setResult(uploadVo);
    }

}
