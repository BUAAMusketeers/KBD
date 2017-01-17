package com.kabuda.entity;

import java.io.Serializable;
import java.util.Date;

public class Vehicle implements Serializable {

    private static final long serialVersionUID = 903029017125667104L;

    private int id;
    private int userId;               // 所属用户的id
    private int modelId;              // 所属机型的id
    private int brandId;              // 所属品牌的id
    private int locationId;           // 所属地址的id
    private int usedHours;            // 使用小时数
    private int vehicleAge;           // 车龄
    private String equipmentNumber;   // 设备编号
    private String description;       // 车主描述
    private String contact;           // 联系人
    private String contactPhone;      // 联系人电话
    private int tonnage;              // 吨位，单位吨
    private int isSell;               // 出售,0代表不出售，1代表出售
    private int isRent;               // 0代表不出租，1代表出租
    private int sellState;            // 出售状态，0代表待售，1代表已出售，2代表下架
    private int rentState;            // 车辆状态，0代表待租，1代表已租出，2代表下架
    private double sellPrice;         // 出售价格，单位万元
    private double rentPrice;         // 出租价格，单位元/天
    private Date releaseDate;         // 发布时间
    private Date updateDate;          // 更新时间

    public Vehicle() {
    }

    public Vehicle(int userId, int modelId, int brandId, int locationId, int usedHours, int vehicleAge, String equipmentNumber,
                   String description, String contact, String contactPhone, int tonnage, int isSell, int isRent,
                   int sellState, int rentState, double sellPrice, double rentPrice, Date releaseDate, Date updateDate) {
        this.userId = userId;
        this.modelId = modelId;
        this.brandId = brandId;
        this.locationId = locationId;
        this.usedHours = usedHours;
        this.vehicleAge = vehicleAge;
        this.equipmentNumber = equipmentNumber;
        this.description = description;
        this.contact = contact;
        this.contactPhone = contactPhone;
        this.tonnage = tonnage;
        this.isSell = isSell;
        this.isRent = isRent;
        this.sellState = sellState;
        this.rentState = rentState;
        this.sellPrice = sellPrice;
        this.rentPrice = rentPrice;
        this.releaseDate = releaseDate;
        this.updateDate = updateDate;
    }

    public int getIsRent() {
        return isRent;
    }

    public void setIsRent(int isRent) {
        this.isRent = isRent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getUsedHours() {
        return usedHours;
    }

    public void setUsedHours(int usedHours) {
        this.usedHours = usedHours;
    }

    public int getVehicleAge() {
        return vehicleAge;
    }

    public void setVehicleAge(int vehicleAge) {
        this.vehicleAge = vehicleAge;
    }

    public String getEquipmentNumber() {
        return equipmentNumber;
    }

    public void setEquipmentNumber(String equipmentNumber) {
        this.equipmentNumber = equipmentNumber;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public int getTonnage() {
        return tonnage;
    }

    public void setTonnage(int tonnage) {
        this.tonnage = tonnage;
    }

    public int getIsSell() {
        return isSell;
    }

    public void setIsSell(int isSell) {
        this.isSell = isSell;
    }

    public int getSellState() {
        return sellState;
    }

    public void setSellState(int sellState) {
        this.sellState = sellState;
    }

    public int getRentState() {
        return rentState;
    }

    public void setRentState(int rentState) {
        this.rentState = rentState;
    }

    public double getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(double sellPrice) {
        this.sellPrice = sellPrice;
    }

    public double getRentPrice() {
        return rentPrice;
    }

    public void setRentPrice(double rentPrice) {
        this.rentPrice = rentPrice;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}
