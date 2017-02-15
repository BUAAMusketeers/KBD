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


    /**
     * @return 返回省份列表
     */
    public List<Location> listProvince(){
        return locationDao.listProvince();
    }

    /**
     * @param parentProvince 省份名字
     * @return 该省份所拥有的市列表
     */
    public List<Location> listCity(String parentProvince){
        return locationDao.listCity(parentProvince);
    }

    /**
     * @param parentCity 市级行政单位名字
     * @return 该市所拥有县级行政单位列表
     */
    public List<Location> listCounty(String parentCity){
        return locationDao.listCounty(parentCity);
    }

    /**
     * @param id location表的id
     * @return 对应的地址信息
     */
    public Location getLocationById(int id){
        return locationDao.getLocationById(id);
    }

    /**
     * @param LocationCode 地区代码
     * @return 对应的地址信息
     */
    public Location getLocationByLC(String LocationCode){
        return locationDao.getLocationByLC(LocationCode);
    }

    /**
     * @param curCity 当前市级行政单位的名字
     * @return 对应的地址信息
     */
    public Location getCityByName(String curCity){
        return locationDao.getLocationByCity(curCity);
    }

    /**
     * @param curCounty 当前县级行政单位的名字
     * @return 对应的地址信息
     */
    public Location getLocationByCounty(String curCounty){
        return locationDao.getLocationByCounty(curCounty);
    }
}
