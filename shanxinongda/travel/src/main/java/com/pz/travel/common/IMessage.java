package com.pz.travel.common;

public interface IMessage {
    /**
     * error code
     *
     * @return String
     */
    Integer getCode();

    /**
     * error message
     *
     * @return String
     */
    String getMessage();
}
