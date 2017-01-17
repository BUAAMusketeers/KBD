package com.kabuda.service;

import com.kabuda.dao.VehicleDao;
import com.kabuda.entity.Vehicle;
import com.kabuda.entity.domain.VehicleBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("vehicleService")
@Transactional
public class VehicleService {

    private final VehicleDao vehicleDao;

    @Autowired
    public VehicleService(VehicleDao vehicleDao) {
        this.vehicleDao = vehicleDao;
    }

    public int getVehicleCount(int type) {
        return vehicleDao.getVehicleCount(type);
    }

    public List<VehicleBean> getCarList(Map<String, String> map) {
        return vehicleDao.getCarList(map);
    }

    public VehicleBean getVehicleInfoById(int id){
        return vehicleDao.getVehicleInfoById(id);
    }


    public Vehicle getVehicleById(int id){
        return vehicleDao.getVehicleById(id);
    }

    public Integer getVehicleByEN(String equipmentNumber){
        return vehicleDao.getVehicleByEN(equipmentNumber);
    }

    public void insert(Vehicle vehicle){
        vehicleDao.insert(vehicle);
    }

    public void update(Vehicle vehicle){
        vehicleDao.update(vehicle);
    }
}
