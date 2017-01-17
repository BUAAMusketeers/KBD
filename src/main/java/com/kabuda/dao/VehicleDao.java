package com.kabuda.dao;


import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.Vehicle;
import com.kabuda.entity.domain.VehicleBean;

import java.util.List;
import java.util.Map;

@MyBatisDao
public interface VehicleDao extends Dao<Vehicle>{

    /**
     * @param type 0表示全部，1表示出售的，2表示出租的
     * @return 车辆数量
     */
    int getVehicleCount(int type);

    List<VehicleBean> getCarList(Map<String, String> map); //int city, int brand, int model, int sort, int limit, int offset, String keyword, int isSell

    VehicleBean getVehicleInfoById(int id);


    Integer getVehicleByEN(String equipmentNumber);

    Vehicle getVehicleById(int id);

    void insert(Vehicle vehicle);

    void update(Vehicle vehicle);
}
