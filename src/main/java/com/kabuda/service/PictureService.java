package com.kabuda.service;


import com.kabuda.dao.PictureDao;
import com.kabuda.entity.Picture;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("pictureService")
@Transactional
public class PictureService {

    private final PictureDao pictureDao;

    @Autowired
    public PictureService(PictureDao pictureDao) {
        this.pictureDao = pictureDao;
    }

    public List<Picture> getPictureByVehicleId(int vehicleId){
        return pictureDao.getPictureByVehicleId(vehicleId);
    }

    public Picture getPictureById(int id){
        return pictureDao.getPictureById(id);
    }

    public int insert(Picture picture){
        return pictureDao.savePicture(picture);
    }

    public void update(Picture picture){
        pictureDao.updatePicture(picture);
    }

    public void delete(int id){
        pictureDao.removePicture(id);
    }
}
