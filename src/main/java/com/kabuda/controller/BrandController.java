package com.kabuda.controller;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Brand;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.BrandService;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class BrandController {

    private final BrandService brandService;

    @Autowired
    public BrandController(BrandService brandService) {
        this.brandService = brandService;
    }

    @ResponseBody
    @RequestMapping(path = "/car/getBrandList", method = RequestMethod.POST)
    public String getBrandList(){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            List<List<Brand>> data = new ArrayList<List<Brand>>();
            for(char i = 'A'; i <= 'Z'; i++){
                List<Brand> brands = brandService.getBrandListByLetter(String.valueOf(i));
                data.add(brands);
            }
            return gson.toJson(new Response<List<List<Brand>>>(ResponseCode.R_1000, data));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }
}
