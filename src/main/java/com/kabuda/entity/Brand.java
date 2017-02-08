package com.kabuda.entity;


import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

public class Brand implements Serializable{

    private static final long serialVersionUID = -3296819672584830066L;

    private int id;

    private String firstLetter;    // 品牌名称首字母

    @SerializedName("name")
    private String brandName;     // 品牌名称

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstLetter() {
        return firstLetter;
    }

    public void setFirstLetter(String firstLetter) {
        this.firstLetter = firstLetter;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
