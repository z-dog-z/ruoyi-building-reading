package com.pz.travel.common;


import java.io.Serializable;

public abstract class BaseResult<T> implements Serializable {

    /**
     * 是否成功
     */
    private boolean success = false;

    /**
     * 错误提示(成功succeed)
     */
    private String msg;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    private  String message;
    /**
     * 成功返回的数据
     */
    private T data;

    /**
     * 错误代码
     */
    private Integer code;

    /**
     * 响应时间
     */
    private String timestamp;


    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
