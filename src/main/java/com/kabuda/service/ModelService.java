package com.kabuda.service;


import com.kabuda.dao.ModelDao;
import com.kabuda.entity.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("modelService")
@Transactional
public class ModelService {

    private final ModelDao modelDao;

    @Autowired
    public ModelService(ModelDao modelDao) {
        this.modelDao = modelDao;
    }

    public List<Model> getModelList(){
        return modelDao.getModelList();
    }

    public List<Model> getModelListByLetter(String firstLetter){
        return modelDao.getModelListByLetter(firstLetter);
    }
}
