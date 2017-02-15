package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Location;
import com.kabuda.entity.Picture;
import com.kabuda.entity.User;
import com.kabuda.entity.Vehicle;
import com.kabuda.entity.domain.*;
import com.kabuda.service.LocationService;
import com.kabuda.service.PictureService;
import com.kabuda.service.VehicleService;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class VehicleController {

    private final VehicleService vehicleService;

    private final LocationService locationService;

    private final PictureService pictureService;

    @Autowired
    public VehicleController(VehicleService vehicleService, LocationService locationService, PictureService pictureService) {
        this.vehicleService = vehicleService;
        this.locationService = locationService;
        this.pictureService = pictureService;
    }

    /**
     * 获取出售车辆列表
     */
    @ResponseBody
    @RequestMapping(path = "/car/getSellList", method = RequestMethod.POST)
    public String getSellList(String city, Integer brand, Integer model, Integer sort,
                              Integer limit, Integer page, String keyword) {
        return getCarList(city, brand, model, sort, limit, page, keyword, 1);
    }

    /**
     * 获取出租车辆列表
     */
    @ResponseBody
    @RequestMapping(path = "/car/getRentList", method = RequestMethod.POST)
    public String getRentList(String city, Integer brand, Integer model, Integer sort,
                              Integer limit, Integer page, String keyword) {
        return getCarList(city, brand, model, sort, limit, page, keyword, 2);
    }


    /**
     * 返回车辆列表
     * @param city    城市id
     * @param brand   品牌id
     * @param model   机型id
     * @param sort    排序方式  0默认 1价格升序 2价格降序 3使用时间升序 4车龄升序
     * @param limit   每一页数量
     * @param page    第几页
     * @param keyword 关键字
     * @param sellOrRent  1表示出售，2表示出租
     * @return 车辆列表
     */
    private String getCarList(String city, Integer brand, Integer model, Integer sort,
                              Integer limit, Integer page, String keyword, int sellOrRent) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(city) || StringUtils.isEmpty(brand) || StringUtils.isEmpty(model) || StringUtils.isEmpty(sort) ||
                    StringUtils.isEmpty(limit) || StringUtils.isEmpty(page)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            city = city.trim();
            keyword = StringUtils.isEmpty(keyword)? keyword : keyword.trim();

//            Location cityByName = locationService.getCityByName(city);
//            if(cityByName == null){
//                return gson.toJson(new Response(ResponseCode.R_1008));
//            }
//            String cityCode = cityByName.getLocationCode();

            //int vehicleCount = vehicleService.getVehicleCount(sellOrRent);
            int offset = (page - 1) * limit;
            VehicleRequest vehicleRequest = new VehicleRequest(city, brand, model, sort, keyword, offset, limit, sellOrRent);
            List<VehicleBean> carList = vehicleService.getVehicleList(vehicleRequest);
            int vehicleCount = 0;
            if(carList != null){
                vehicleCount = carList.size();
            }
            return carListJson(vehicleCount, carList, sellOrRent);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }

    private String carListJson(int vehicleCount, List<VehicleBean> carList, int sellOrRent){
        ExclusionStrategy exclusionStrategy = new ExclusionStrategy() {
            public boolean shouldSkipField(FieldAttributes f) {
                return f.getName().equals("userId") || f.getName().equals("equipmentNumber") ||
                        f.getName().equals("description") || f.getName().contains("contact") ||
                        f.getName().equals("releaseDate") || f.getName().equals("isSell") ||
                        f.getName().equals("isRent") || f.getName().contains("State");
            }
            public boolean shouldSkipClass(Class<?> clazz) {
                return false;
            }
        };
        if(sellOrRent == 1){
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(0).setExclusionStrategies(exclusionStrategy)
                    .serializeNulls().setPrettyPrinting().create();
            return gson.toJson(new VehicleResponse(ResponseCode.R_1000, vehicleCount, carList));
        }
        if(sellOrRent == 2){
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(4).setExclusionStrategies(exclusionStrategy)
                    .serializeNulls().setPrettyPrinting().create();
            return gson.toJson(new VehicleResponse(ResponseCode.R_1000, vehicleCount, carList));
        }
        return null;
    }

    /**
     * @param id 车辆id
     * @return 车辆详细信息
     */
    @ResponseBody
    @RequestMapping(path = "/car/getCarInfo", method = RequestMethod.POST)
    public String getCarInfo(Integer id){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if(StringUtils.isEmpty(id)){
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            VehicleBean vehicleBean = vehicleService.getVehicleInfoById(id);
            return carInfoJson(vehicleBean);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }

    private String carInfoJson(VehicleBean vehicleBean){
        if(vehicleBean.getIsSell() == 0 || vehicleBean.getIsRent() == 0){
            if(vehicleBean.getIsSell() == 0 && vehicleBean.getIsRent() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(2).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(ResponseCode.R_1000, vehicleBean));
            }
            if(vehicleBean.getIsSell() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(4).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(ResponseCode.R_1000, vehicleBean));
            }
            if(vehicleBean.getIsRent() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(0).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(ResponseCode.R_1000, vehicleBean));
            }
        }
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").serializeNulls().setPrettyPrinting().create();
        return gson.toJson(new Response<VehicleBean>(ResponseCode.R_1000, vehicleBean));
    }


    /**
     * 发布车辆信息
     */
    @ResponseBody
    @RequestMapping(path = "/car/publishCar", method = RequestMethod.POST)
    public String publishCar(Integer model, Integer brand, String location, Integer usedHours,
                             Integer vehicleAge, Integer tonnage, String equipmentNumber, String description, String contact,
                             String contactPhone, Integer isSell, Integer isRent, Integer sellState, Integer rentState,
                             Double sellPrice, Double rentPrice, HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(ResponseCode.R_1010));
            }
            int userId = user.getId();

            if (StringUtils.isEmpty(model) || StringUtils.isEmpty(brand) ||
                    StringUtils.isEmpty(location) || StringUtils.isEmpty(usedHours) || StringUtils.isEmpty(vehicleAge) ||
                    StringUtils.isEmpty(tonnage) || StringUtils.isEmpty(equipmentNumber) || StringUtils.isEmpty(description) ||
                    StringUtils.isEmpty(contact) || StringUtils.isEmpty(contactPhone) || StringUtils.isEmpty(isSell) ||
                    StringUtils.isEmpty(isRent)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            location = location.trim();
            equipmentNumber = equipmentNumber.trim();
            description = description.trim();
            contact = contact.trim();
            contactPhone = contactPhone.trim();

            Date releaseDate = Calendar.getInstance().getTime();
            Vehicle vehicle = new Vehicle(userId, model, brand, location, usedHours, vehicleAge, equipmentNumber,
                    description, contact, contactPhone, tonnage, isSell, isRent, -1, -1, -1, -1, releaseDate, releaseDate);
            if (isSell == 1) {
                if (StringUtils.isEmpty(sellState) || StringUtils.isEmpty(sellPrice)) {
                    return gson.toJson(new Response(ResponseCode.R_1001));
                }
                vehicle.setSellState(sellState);
                vehicle.setSellPrice(sellPrice);
            }
            if (isRent == 1) {
                if (StringUtils.isEmpty(rentState) || StringUtils.isEmpty(rentPrice)) {
                    return gson.toJson(new Response(ResponseCode.R_1001));
                }
                vehicle.setRentState(rentState);
                vehicle.setRentPrice(rentPrice);
            }

            if (vehicleService.getVehicleByEN(equipmentNumber) != null) {
                return gson.toJson(new Response(ResponseCode.R_1007));
            }

            vehicleService.insert(vehicle);
            int id = vehicle.getId();
            Map<String, Integer> hashMap = new HashMap<String, Integer>();
            hashMap.put("id", id);
            return gson.toJson(new Response<Map<String, Integer>>(ResponseCode.R_1000, hashMap));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 更新车辆信息
     */
    @ResponseBody
    @RequestMapping(path = "/car/updateCar", method = RequestMethod.POST)
    public String updateCar(Integer id, Integer model, Integer brand, String location, Integer usedHours,
                            Integer vehicleAge, Integer tonnage, String equipmentNumber, String description, String contact,
                            String contactPhone, Integer isSell, Integer isRent, Integer sellState, Integer rentState,
                            Double sellPrice, Double rentPrice) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(id) || StringUtils.isEmpty(isSell) || StringUtils.isEmpty(isRent)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }

            Vehicle vehicleById = vehicleService.getVehicleById(id);
            vehicleById.setIsSell(isSell);
            if (isSell == 1) {
                if (StringUtils.isEmpty(sellState) || StringUtils.isEmpty(sellPrice)) {
                    return gson.toJson(new Response(ResponseCode.R_1001));
                }
                vehicleById.setSellState(sellState);
                vehicleById.setSellPrice(sellPrice);
            } else {
                vehicleById.setSellState(-1);
                vehicleById.setSellPrice(-1);
            }
            vehicleById.setIsRent(isRent);
            if (isRent == 1) {
                if (StringUtils.isEmpty(rentState) || StringUtils.isEmpty(rentPrice)) {
                    return gson.toJson(new Response(ResponseCode.R_1001));
                }
                vehicleById.setRentState(rentState);
                vehicleById.setRentPrice(rentPrice);
            } else {
                vehicleById.setRentState(-1);
                vehicleById.setRentPrice(-1);
            }
            if (!StringUtils.isEmpty(model)) vehicleById.setModelId(model);
            if (!StringUtils.isEmpty(brand)) vehicleById.setBrandId(brand);
            if (!StringUtils.isEmpty(location)) vehicleById.setLocationCode(location);
            if (!StringUtils.isEmpty(usedHours)) vehicleById.setUsedHours(usedHours);
            if (!StringUtils.isEmpty(vehicleAge)) vehicleById.setVehicleAge(vehicleAge);
            if (!StringUtils.isEmpty(tonnage)) vehicleById.setTonnage(tonnage);
            if (!StringUtils.isEmpty(equipmentNumber)) vehicleById.setEquipmentNumber(equipmentNumber.trim());
            if (!StringUtils.isEmpty(description)) vehicleById.setDescription(description.trim());
            if (!StringUtils.isEmpty(contact)) vehicleById.setContact(contact.trim());
            if (!StringUtils.isEmpty(contactPhone)) vehicleById.setContactPhone(contactPhone.trim());

            vehicleById.setUpdateDate(Calendar.getInstance().getTime());
            vehicleService.update(vehicleById);
            return gson.toJson(new Response(ResponseCode.R_1000));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }

    }


    /**
     * 获取车辆图片
     * @param id 车辆id
     */
    @ResponseBody
    @RequestMapping(path = "/car/getPictures", method = RequestMethod.POST)
    public String getPictures(Integer id, HttpServletRequest request){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if(StringUtils.isEmpty(id)){
                return gson.toJson(new Response(ResponseCode.R_1001));
            }

            List<Picture> pictures = pictureService.getPictureByVehicleId(id);
            int total = 0;
            if(pictures != null){
                total = pictures.size();
            }
            return gson.toJson(new ListResponse<Picture>(ResponseCode.R_1000, total, pictures));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }
}
