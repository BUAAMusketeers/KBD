package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Location;
import com.kabuda.entity.domain.LocationResponse;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.LocationService;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/location")
public class LocationController {

    private final LocationService locationService;

    @Autowired
    public LocationController(LocationService locationService) {
        this.locationService = locationService;
    }


    /**
     * @return 获取省份列表
     */
    @ResponseBody
    @RequestMapping(path = "/getProvinceList", method = RequestMethod.POST)
    public String getProvinceList(){
        Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
            public boolean shouldSkipField(FieldAttributes f) {
                return f.getName().equals("city") || f.getName().equals("county");
            }

            public boolean shouldSkipClass(Class<?> clazz) {
                return false;
            }
        }).setPrettyPrinting().create();
        try {
            List<Location> provinceList = locationService.listProvince();
            int total = 0;
            if(provinceList != null){
                total = provinceList.size();
            }
            return gson.toJson(new LocationResponse(ResponseCode.R_1000, total, provinceList));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * @param province 省份名字
     * @return 该省份的市列表
     */
    @ResponseBody
    @RequestMapping(path = "/getCityList", method = RequestMethod.POST)
    public String getCityList(String province) {
        Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
            public boolean shouldSkipField(FieldAttributes f) {
                return f.getName().equals("province") || f.getName().equals("county");
            }

            public boolean shouldSkipClass(Class<?> clazz) {
                return false;
            }
        }).setPrettyPrinting().create();

        if (StringUtils.isEmpty(province)) {
            return gson.toJson(new Response(ResponseCode.R_1001));
        }
        province = province.trim();

        try {
            List<Location> cityList = locationService.listCity(province);
            int total = 0;
            if (cityList != null) {
                total = cityList.size();
            }
            return gson.toJson(new LocationResponse(ResponseCode.R_1000, total, cityList));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * @param city 市名字
     * @return 该市的县级行政单位列表
     */
    @ResponseBody
    @RequestMapping(path = "/getCountyList", method = RequestMethod.POST)
    public String getCountyList  (String city){
        Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
            public boolean shouldSkipField(FieldAttributes f) {
                return f.getName().equals("province") || f.getName().equals("city");
            }

            public boolean shouldSkipClass(Class<?> clazz) {
                return false;
            }
        }).setPrettyPrinting().create();

        if(StringUtils.isEmpty(city)){
            return gson.toJson(new Response(ResponseCode.R_1001));
        }
        city = city.trim();

        try {
            List<Location> countyList = locationService.listCounty(city);
            int total = 0;
            if (countyList != null) {
                total = countyList.size();
            }
            return gson.toJson(new LocationResponse(ResponseCode.R_1000, total, countyList));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * @param locationCode 地区代码
     * @return 对应的地址信息
     */
    @ResponseBody
    @RequestMapping(path = "/getLocation", method = RequestMethod.POST)
    public String getLocationByLC(String locationCode) {
        Gson gson = new GsonBuilder().serializeNulls().setPrettyPrinting().create();

        if (StringUtils.isEmpty(locationCode)) {
            return gson.toJson(new Response(ResponseCode.R_1001));
        }

        try {
            Location location = locationService.getLocationByLC(locationCode);
            return gson.toJson(new Response<Location>(ResponseCode.R_1000, location));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }
}
