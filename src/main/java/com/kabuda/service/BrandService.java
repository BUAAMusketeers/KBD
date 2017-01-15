package com.kabuda.service;

import com.kabuda.dao.BrandDao;
import com.kabuda.entity.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("brandService")
@Transactional
public class BrandService {

    private final BrandDao brandDao;

    @Autowired
    public BrandService(BrandDao brandDao) {
        this.brandDao = brandDao;
    }

    public List<Brand> getBrandList(){
        return brandDao.getBrandList();
    }

    public List<Brand> getBrandListByLetter(String firstLetter){
        return brandDao.getBrandListByLetter(firstLetter);
    }
}
