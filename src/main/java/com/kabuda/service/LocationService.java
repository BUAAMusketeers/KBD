package com.kabuda.service;


import com.kabuda.dao.LocationDao;
import com.kabuda.entity.Location;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("locationService")
@Transactional
public class LocationService {

    private final LocationDao locationDao;

    @Autowired
    public LocationService(LocationDao locationDao) {
        this.locationDao = locationDao;
    }

    public List<Location> getProvinceList(){
        return locationDao.listProvince();
    }

    public List<Location> getCityList(String parentProvince){
        return locationDao.listCity(parentProvince);
    }

    public List<Location> getCountyList(String parentCity){
        return locationDao.listCounty(parentCity);
    }

    public Location getCityByName(String curCity){
        return locationDao.getCityByName(curCity);
    }

    /**
     *  根据地址代码获取地址信息
     */
    public Location getLocationByLC(String LocationCode){
        return locationDao.getLocationByLC(LocationCode);
    }
}
