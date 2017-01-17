package com.kabuda.entity.domain;


import java.util.List;

public class VehicleResponse extends Response{

    private Result result;

    public VehicleResponse() {
    }

    public VehicleResponse(int status, String message, int total, List<VehicleBean> data) {
        super(status, message);
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


