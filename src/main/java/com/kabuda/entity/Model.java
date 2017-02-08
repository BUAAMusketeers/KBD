package com.kabuda.entity;


import com.google.gson.annotations.SerializedName;

import java.io.Serializable;

public class Model implements Serializable{

    private static final long serialVersionUID = 5529221459758885379L;

    private int id;

    private String firstLetter;     // 机型名称首字母

    @SerializedName("name")
    private String modelName;       // 机型名称

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

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }
}
