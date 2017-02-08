package com.kabuda.dao;


import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.Location;

import java.util.List;

@MyBatisDao
public interface LocationDao extends Dao<Location>{

    List<Location> getProvinceList();

    List<Location> getCityList(String parentProvince);

    List<Location> getCountyList(String parentCity);

    Location getCityByName(String curCity);

    Location getLocationByLC(String LocationCode);

}
