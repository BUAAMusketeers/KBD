package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Location;
import com.kabuda.entity.User;
import com.kabuda.entity.Vehicle;
import com.kabuda.entity.domain.Response;
import com.kabuda.entity.domain.VehicleBean;
import com.kabuda.entity.domain.VehicleRequest;
import com.kabuda.entity.domain.VehicleResponse;
import com.kabuda.service.LocationService;
import com.kabuda.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
public class VehicleController {

    private final VehicleService vehicleService;

    private final LocationService locationService;

    @Autowired
    public VehicleController(VehicleService vehicleService, LocationService locationService) {
        this.vehicleService = vehicleService;
        this.locationService = locationService;
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
                return gson.toJson(new Response(1001, "参数为空"));
            }
            city = city.trim();
            keyword = StringUtils.isEmpty(keyword)? keyword : keyword.trim();

            Location cityByName = locationService.getCityByName(city);
            if(cityByName == null){
                return gson.toJson(new Response(1012, "城市不存在"));
            }
            int cityId = cityByName.getId();

            //int vehicleCount = vehicleService.getVehicleCount(sellOrRent);
            int offset = (page - 1) * limit;
            VehicleRequest vehicleRequest = new VehicleRequest(cityId, brand, model, sort, keyword, offset, limit, sellOrRent);
            List<VehicleBean> carList = vehicleService.getVehicleList(vehicleRequest);
            int vehicleCount = 0;
            if(carList != null){
                vehicleCount = carList.size();
            }
            return carListJson(vehicleCount, carList, sellOrRent);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1100, "其它错误"));
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
            return gson.toJson(new VehicleResponse(1000, "success", vehicleCount, carList));
        }
        if(sellOrRent == 2){
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(4).setExclusionStrategies(exclusionStrategy)
                    .serializeNulls().setPrettyPrinting().create();
            return gson.toJson(new VehicleResponse(1000, "success", vehicleCount, carList));
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
                return gson.toJson(new Response(1001, "参数为空"));
            }
            VehicleBean vehicleBean = vehicleService.getVehicleInfoById(id);
            return carInfoJson(vehicleBean);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1100, "其它错误"));
        }
    }

    private String carInfoJson(VehicleBean vehicleBean){
        if(vehicleBean.getIsSell() == 0 || vehicleBean.getIsRent() == 0){
            if(vehicleBean.getIsSell() == 0 && vehicleBean.getIsRent() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(2).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(1000, "success", vehicleBean));
            }
            if(vehicleBean.getIsSell() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(4).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(1000, "success", vehicleBean));
            }
            if(vehicleBean.getIsRent() == 0){
                Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").setVersion(0).serializeNulls()
                        .setPrettyPrinting().create();
                return gson.toJson(new Response<VehicleBean>(1000, "success", vehicleBean));
            }
        }
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").serializeNulls().setPrettyPrinting().create();
        return gson.toJson(new Response<VehicleBean>(1000, "success", vehicleBean));
    }


    /**
     * 发布车辆信息
     */
    @ResponseBody
    @RequestMapping(path = "/car/publishCar", method = RequestMethod.POST)
    public String publishCar(Integer model, Integer brand, Integer location, Integer usedHours,
                             Integer vehicleAge, Integer tonnage, String equipmentNumber, String description, String contact,
                             String contactPhone, Integer isSell, Integer isRent, Integer sellState, Integer rentState,
                             Double sellPrice, Double rentPrice, HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(1010, "用户未登录"));
            }
            int userId = user.getId();

            if (StringUtils.isEmpty(model) || StringUtils.isEmpty(brand) ||
                    StringUtils.isEmpty(location) || StringUtils.isEmpty(usedHours) || StringUtils.isEmpty(vehicleAge) ||
                    StringUtils.isEmpty(tonnage) || StringUtils.isEmpty(equipmentNumber) || StringUtils.isEmpty(description) ||
                    StringUtils.isEmpty(contact) || StringUtils.isEmpty(contactPhone) || StringUtils.isEmpty(isSell) ||
                    StringUtils.isEmpty(isRent)) {
                return gson.toJson(new Response(1001, "缺少参数"));
            }
            equipmentNumber = equipmentNumber.trim();
            description = description.trim();
            contact = contact.trim();
            contactPhone = contactPhone.trim();

            Date releaseDate = Calendar.getInstance().getTime();
            Vehicle vehicle = new Vehicle(userId, model, brand, location, usedHours, vehicleAge, equipmentNumber,
                    description, contact, contactPhone, tonnage, isSell, isRent, -1, -1, -1, -1, releaseDate, releaseDate);
            if (isSell == 1) {
                if (StringUtils.isEmpty(sellState) || StringUtils.isEmpty(sellPrice)) {
                    return gson.toJson(new Response(1001, "缺少参数"));
                }
                vehicle.setSellState(sellState);
                vehicle.setSellPrice(sellPrice);
            }
            if (isRent == 1) {
                if (StringUtils.isEmpty(rentState) || StringUtils.isEmpty(rentPrice)) {
                    return gson.toJson(new Response(1001, "缺少参数"));
                }
                vehicle.setRentState(rentState);
                vehicle.setRentPrice(rentPrice);
            }

            if (vehicleService.getVehicleByEN(equipmentNumber) != null) {
                return gson.toJson(new Response(1007, "该车辆已存在"));
            }
            vehicleService.insert(vehicle);
            return gson.toJson(new Response(1000, "success"));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1100, "其它错误"));
        }
    }


    /**
     * 更新车辆信息
     */
    @ResponseBody
    @RequestMapping(path = "/car/updateCar", method = RequestMethod.POST)
    public String updateCar(Integer id, Integer model, Integer brand, Integer location, Integer usedHours,
                            Integer vehicleAge, Integer tonnage, String equipmentNumber, String description, String contact,
                            String contactPhone, Integer isSell, Integer isRent, Integer sellState, Integer rentState,
                            Double sellPrice, Double rentPrice) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(id) || StringUtils.isEmpty(isSell) || StringUtils.isEmpty(isRent)) {
                return gson.toJson(new Response(1001, "参数为空"));
            }

            Vehicle vehicleById = vehicleService.getVehicleById(id);
            vehicleById.setIsSell(isSell);
            if (isSell == 1) {
                if (StringUtils.isEmpty(sellState) || StringUtils.isEmpty(sellPrice)) {
                    return gson.toJson(new Response(1001, "参数为空"));
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
                    return gson.toJson(new Response(1001, "参数为空"));
                }
                vehicleById.setRentState(rentState);
                vehicleById.setRentPrice(rentPrice);
            } else {
                vehicleById.setRentState(-1);
                vehicleById.setRentPrice(-1);
            }
            if (!StringUtils.isEmpty(model)) vehicleById.setModelId(model);
            if (!StringUtils.isEmpty(brand)) vehicleById.setBrandId(brand);
            if (!StringUtils.isEmpty(location)) vehicleById.setLocationId(location);
            if (!StringUtils.isEmpty(usedHours)) vehicleById.setUsedHours(usedHours);
            if (!StringUtils.isEmpty(vehicleAge)) vehicleById.setVehicleAge(vehicleAge);
            if (!StringUtils.isEmpty(tonnage)) vehicleById.setTonnage(tonnage);
            if (!StringUtils.isEmpty(equipmentNumber)) vehicleById.setEquipmentNumber(equipmentNumber.trim());
            if (!StringUtils.isEmpty(description)) vehicleById.setDescription(description.trim());
            if (!StringUtils.isEmpty(contact)) vehicleById.setContact(contact.trim());
            if (!StringUtils.isEmpty(contactPhone)) vehicleById.setContactPhone(contactPhone.trim());

            vehicleById.setUpdateDate(Calendar.getInstance().getTime());
            vehicleService.update(vehicleById);
            return gson.toJson(new Response(1000, "success"));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1100, "其它错误"));
        }

    }

//    @ResponseBody
//    @RequestMapping(path = "/car/publishCar", method = RequestMethod.POST)
//    public String publishCar(HttpServletRequest request, HttpServletResponse response){
//        Gson gson = new Gson();
//        try {
//            Map<String, String> paramsMap = new HashMap<String, String>();
//            Enumeration parameterNames = request.getParameterNames();
//            while (parameterNames.hasMoreElements()){
//                String parameterName = (String) parameterNames.nextElement();
//                paramsMap.put(parameterName, request.getParameter(parameterName));
//            }
//            if(paramsIsEmpty(paramsMap)){
//                return gson.toJson(new Response(1001, "参数为空"));
//            }
//
//            paramsMap.put("releaseDate", Calendar.getInstance().getTime().toString());
//            paramsMap.put("updateDate", null);
//            vehicleService.insert(paramsMap);
//            return gson.toJson(new Response(1000, "success"));
//        } catch (Exception e) {
//            e.printStackTrace();
//            return gson.toJson(new Response(1100, "其它错误"));
//        }
//    }
//
//    private boolean paramsIsEmpty(Map map){
//        for(Object key : map.keySet()){
//            if(!(key.equals("sellState") || key.equals("rentState") || key.equals("sellPrice") || key.equals("rentPrice"))
//                    && map.get(key) == null){
//                return true;
//            }
//        }
//        return false;
//    }
}
