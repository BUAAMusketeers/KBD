package com.kabuda.entity.domain;


import com.kabuda.util.ResponseCode;

import java.util.List;

public class VehicleResponse{

    private int status;
    private String message;
    private Result result;

    public VehicleResponse() {
    }

    public VehicleResponse(ResponseCode responseCode, int total, List<VehicleBean> data) {
        this.status = responseCode.getStatus();
        this.message = responseCode.getMessage();
        this.result = new Result(total, data);
    }

    class Result{
        int total;
        List<VehicleBean> data;

        public Result(int total, List<VehicleBean> data) {
            this.total = total;
            this.data = data;
        }
    }
}


