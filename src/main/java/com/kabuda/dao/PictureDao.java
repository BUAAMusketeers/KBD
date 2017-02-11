package com.kabuda.dao;

import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.Picture;

import java.util.List;

@MyBatisDao
public interface PictureDao extends Dao<Picture>{

    List<Picture> getPictureByVehicleId(int vehicleId);

    Picture getPictureById(int id);

    int insert(Picture picture);

    void update(Picture picture);

    void delete(int id);
}
