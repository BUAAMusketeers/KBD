package com.kabuda.entity.domain;


import com.kabuda.util.ResponseCode;

public class Response<T> {

    private int status;
    private String message;
    private T data;

    public Response() {
    }

    public Response(ResponseCode responseCode) {
        this.status = responseCode.getStatus();
        this.message = responseCode.getMessage();
    }

    public Response(ResponseCode responseCode, T data) {
        this.status = responseCode.getStatus();
        this.message = responseCode.getMessage();
        this.data = data;
    }
}
