package com.kabuda.entity;


public class Location {

    private int id;
    private String locationCode;
    private String province;
    private String city;
    private String county;
    private transient int locationLevel;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLocationCode() {
        return locationCode;
    }

    public void setLocationCode(String locationCode) {
        this.locationCode = locationCode;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public int getLocationLevel() {
        return locationLevel;
    }

    public void setLocationLevel(int locationLevel) {
        this.locationLevel = locationLevel;
    }
}
