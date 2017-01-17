package com.kabuda.entity.domain;


public class Response<T> {

    private int status;
    private String message;
    private T data;

    public Response() {
    }

    public Response(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public Response(int status, String message, T data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }
}
