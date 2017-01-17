package com.kabuda.entity.domain;


public class VehicleRequest {

    private int city;
    private int brand;
    private int model;
    private int sort;
    private String keyword;
    private int offset;
    private int limit;
    private int sellOrRent;  // 0表示全部，1表示出售的，2表示出租的

    public VehicleRequest() {
    }

    public VehicleRequest(int city, int brand, int model, int sort, String keyword, int offset, int limit, int sellOrRent) {
        this.city = city;
        this.brand = brand;
        this.model = model;
        this.sort = sort;
        this.keyword = keyword;
        this.offset = offset;
        this.limit = limit;
        this.sellOrRent = sellOrRent;
    }

    public int getCity() {
        return city;
    }

    public void setCity(int city) {
        this.city = city;
    }

    public int getBrand() {
        return brand;
    }

    public void setBrand(int brand) {
        this.brand = brand;
    }

    public int getModel() {
        return model;
    }

    public void setModel(int model) {
        this.model = model;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getSellOrRent() {
        return sellOrRent;
    }

    public void setSellOrRent(int sellOrRent) {
        this.sellOrRent = sellOrRent;
    }
}
