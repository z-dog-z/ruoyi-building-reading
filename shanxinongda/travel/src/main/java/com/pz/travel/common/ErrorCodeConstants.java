package com.pz.travel.common;

import lombok.Data;

/**
 * @program: ruoyi
 * @description: 返回信息枚举
 * @author: Anakin Yang
 * @create: 2020-08-27 15:31
 **/
@Data
public class ErrorCodeConstants {

    public static Integer WARNING=1100;
    /**
    * 返回码
    **/
    //成功
    public static Integer SUCCESS_CODE=200;
    //预约码扫码失败
    public static Integer OTHER_SUCCESS_CODE=406;
    public static Integer OTHER_SUCCESS_CODE1=407;

    //参数异常
    public static Integer PARAM_EXCEPTION_CODE=1001;
    //系统异常
    public static Integer SYSTEM_EXCEPTION_CODE=3000;


    /**
    * 返回码描述
    **/
    //成功
    public static String SUCCESS_MESSAGE="成功";

    //参数异常
    public static String PARAM_EXCEPTION_MESSAGE="参数异常";
    //系统异常
    public static String SYSTEM_EXCEPTION_MESSAGE="系统异常";

}
