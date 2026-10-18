package com.pz.travel.common;

import com.ruoyi.common.utils.DateUtils;

import java.io.Serializable;

public class CommonResult<T> extends BaseResult implements Serializable {

    /**
     * serialVersionUID:.
     */
    private static final long serialVersionUID = -7268040542410707954L;


    /**
     * 默认构造器
     */
    public CommonResult() {

    }

    /**
     * @param success 是否成功
     * @param message 返回的消息
     */
    public CommonResult(boolean success, String message) {
        this.setSuccess(success);
        this.setMsg(message);
    }

    /**
     * @param success 是否成功
     */
    public CommonResult(boolean success) {
        this.setSuccess(success);
    }

    /**
     * @param code    error code
     * @param message success or error messages
     */
    public CommonResult(Integer code, String message) {
        this.setCode(code);
        this.setMsg(message);
    }

    /**
     *  成功
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult success() {
        CommonResult result = new CommonResult();
        result.setSuccess(true);
        result.setCode(ErrorCodeConstants.SUCCESS_CODE);
        result.setMsg(ErrorCodeConstants.SUCCESS_MESSAGE);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    /**
     *  成功
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult otherSuccess(Object data) {
        CommonResult result = new CommonResult();
        result.setCode(ErrorCodeConstants.SUCCESS_CODE);
        result.setMsg(ErrorCodeConstants.SUCCESS_MESSAGE);
        result.setData(data);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }

    /**
     *  成功
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult newOtherSuccess(Object data) {
        CommonResult result = new CommonResult();
        result.setCode(ErrorCodeConstants.OTHER_SUCCESS_CODE);
        result.setMsg(ErrorCodeConstants.SUCCESS_MESSAGE);
        result.setData(data);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    public static CommonResult newOtherSuccess1(Object data) {
        CommonResult result = new CommonResult();
        result.setCode(ErrorCodeConstants.OTHER_SUCCESS_CODE1);
        result.setMsg(ErrorCodeConstants.SUCCESS_MESSAGE);
        result.setData(data);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    /**
     *  参数异常
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult paramError() {
        CommonResult result = new CommonResult();
        result.setCode(ErrorCodeConstants.PARAM_EXCEPTION_CODE);
        result.setMsg(ErrorCodeConstants.PARAM_EXCEPTION_MESSAGE);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    /**
     *  系统异常
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult systemError() {
        CommonResult result = new CommonResult();
        result.setCode(ErrorCodeConstants.SYSTEM_EXCEPTION_CODE);
        result.setMsg(ErrorCodeConstants.SYSTEM_EXCEPTION_MESSAGE);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    /**
     *  其他异常
     * @author Anakin Yang
     * @date 2020/8/27 15:40
     */
    public static CommonResult otherError(Integer code,String message) {
        CommonResult result = new CommonResult();
        result.setCode(code);
        result.setMsg(message);
        result.setMessage(message);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }

    public static CommonResult otherError1(Integer code,String message, String  idcard) {
        CommonResult result = new CommonResult();
        result.setCode(code);
        result.setMsg(message);
        result.setData(idcard);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }
    /**
     * @param success 是否成功
     * @param message 消息
     * @param data    数据
     */
    public CommonResult(boolean success, String message, T data) {
        this.setSuccess(success);
        this.setMsg(message);
        this.setData(data);
    }

    /**
     * 通用成功响应(默认响应码为0000)
     *
     * @return CommonResult
     */
    public static CommonResult ok() {
        return ok(BaseErrorCode.Common.SUCCESS);
    }

    /**
     * 自动义成功响应，一般定义枚举实现IMessage
     *
     * @param msg IMessage interface
     * @param <T> Object
     * @return CommonResult
     */
    public static <T> CommonResult<T> ok(IMessage msg) {
        return baseCreate(msg.getCode(), msg.getMessage(), true);
    }

    /**
     * 通用服务器未知异常(默认响应码9999)
     *
     * @return CommonResult
     */
    public static CommonResult fail() {
        return fail(BaseErrorCode.Common.UNKNOWN_ERROR);
    }

    /**
     * 失败响应
     *
     * @param message IMessage
     * @return CommonResult
     */
    public static CommonResult fail(IMessage message) {
        return fail(message.getCode(), message.getMessage());
    }

    /**
     * 失败或失败响应
     *
     * @param code 错误响应码
     * @param msg  错误信息
     * @return CommonResult
     */
    public static CommonResult fail(Integer code, String msg) {
        return baseCreate(code, msg, false);
    }

    private static <T> CommonResult<T> baseCreate(Integer code, String msg, boolean success) {
        CommonResult result = new CommonResult();
        result.setCode(code);
        result.setSuccess(success);
        result.setMsg(msg);
        result.setTimestamp(DateUtils.dateTimeNow(DateUtils.YYYY_MM_DD_HH_MM_SS));
        return result;
    }

    /**
     * Usage:
     * Result.ok().setResult("hello")
     * 返回结果时携带数据
     *
     * @param data you return data
     * @return CommonResult
     */
    public CommonResult<T> setResult(T data) {
        this.setData(data);
        return this;
    }

    /**
     * 返回数据和msg
     * @param data
     * @param msg
     * @return
     */
    public CommonResult<T> setResult(T data,String msg) {
        this.setData(data);
        this.setMsg(msg);
        return this;
    }
    /**
     * 覆盖supper方法
     *
     * @return T
     */
    @Override
    public T getData() {
        return (T) super.getData();
    }

}
