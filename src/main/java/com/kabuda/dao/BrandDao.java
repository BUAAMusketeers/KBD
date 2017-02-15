package com.kabuda.dao;

import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.Brand;

import java.util.List;

@MyBatisDao
public interface BrandDao extends Dao<Brand>{

    List<Brand> listBrand();

    List<Brand> listBrandByLetter(String firstLetter);

    Brand getBrandById(int id);
}
