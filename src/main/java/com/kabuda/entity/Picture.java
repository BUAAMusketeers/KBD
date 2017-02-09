package com.kabuda.entity;


import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

public class Picture implements Serializable {
    private static final long serialVersionUID = 6118912157955963525L;

    private Integer id;
    private Integer isFirst;
    private transient Integer vehicleId;
    private String url;

    @SerializedName("caption")
    private String name;
    private Long size;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIsFirst() {
        return isFirst;
    }

    public void setIsFirst(Integer isFirst) {
        this.isFirst = isFirst;
    }

    public Integer getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(Integer vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }
}
