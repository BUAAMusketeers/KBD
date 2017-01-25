package com.kabuda.entity.domain;


import com.kabuda.entity.Location;
import com.kabuda.util.ResponseCode;

import java.util.List;

public class LocationResponse {

    private int status;
    private String message;
    private Result result;

    public LocationResponse() {
    }

    public LocationResponse(ResponseCode responseCode, int total, List<Location> data) {
        this.status = responseCode.getStatus();
        this.message = responseCode.getMessage();
        this.result = new Result(total, data);
    }

    class Result{
        int total;
        List<Location> data;

        public Result(int total, List<Location> data) {
            this.total = total;
            this.data = data;
        }
    }
}
