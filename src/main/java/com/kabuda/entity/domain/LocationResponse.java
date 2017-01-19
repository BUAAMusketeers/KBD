package com.kabuda.entity.domain;


import com.kabuda.entity.Location;

import java.util.List;

public class LocationResponse {

    private int status;
    private String message;
    private Result result;

    public LocationResponse() {
    }

    public LocationResponse(int status, String message, int total, List<Location> data) {
        this.status = status;
        this.message = message;
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
