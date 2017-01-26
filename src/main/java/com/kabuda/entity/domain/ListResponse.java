package com.kabuda.entity.domain;

import com.kabuda.util.ResponseCode;

import java.util.List;

public class ListResponse<T> {

    private int status;
    private String message;
    private Result<T> result;

    public ListResponse() {
    }

    public ListResponse(ResponseCode responseCode, int total, List<T> data) {
        this.status = responseCode.getStatus();
        this.message = responseCode.getMessage();
        this.result = new Result<T>(total, data);
    }

    class Result<T> {
        int total;
        List<T> data;

        public Result(int total, List<T> data) {
            this.total = total;
            this.data = data;
        }
    }
}
