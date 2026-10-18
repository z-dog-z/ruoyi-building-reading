package com.pz.travel.common;

public interface BaseErrorCode {

    enum Common implements IMessage {

        SUCCESS(200, "succeed"),

        UNKNOWN_ERROR(500, "系统繁忙，请稍后再试...."),

        NO_DATA(501, "无记录...."),

        NO_LOGIN(2001, "未登录"),

        ERROR_PASSWORD(2002, "用户名/密码不正确"),

        APPOINTMENT_NUM_LIMIT_CODE(2003, "达到预约人数限制"),

        NO_REGISTER(2004, "请先预约"),

        BLOCK_UP(2005, "账号已停用");


        private Integer code;
        private String message;


        Common(Integer errCode, String errMsg) {
            this.code = errCode;
            this.message = errMsg;
        }

        @Override
        public Integer getCode() {
            return this.code;
        }

        @Override
        public String getMessage() {
            return this.message;
        }
    }
}
