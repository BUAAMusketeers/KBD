package com.kabuda.service;


import com.kabuda.dao.PictureDao;
import com.kabuda.entity.Picture;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.List;

@Service("pictureService")
@Transactional
public class PictureService {

    private final PictureDao pictureDao;

    @Autowired
    public PictureService(PictureDao pictureDao) {
        this.pictureDao = pictureDao;
    }

    public List<Picture> listPictureByVehicleId(int vehicleId){
        return pictureDao.listPictureByVehicleId(vehicleId);
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

    public void removePicture(int id){
        pictureDao.removePicture(id);
    }

    public void removePictureByVehicleId(int vehicleId){
        pictureDao.removePictureByVehicleId(vehicleId);
    }

}
