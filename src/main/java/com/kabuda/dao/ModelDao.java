package com.kabuda.dao;


import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.Model;

import java.util.List;

@MyBatisDao
public interface ModelDao extends Dao<Model> {

    Model getModelById(int id);

    List<Model> listModel();

    List<Model> listModelByLetter(String firstLetter);
}
