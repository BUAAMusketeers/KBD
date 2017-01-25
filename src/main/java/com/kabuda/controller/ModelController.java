package com.kabuda.controller;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Model;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.ModelService;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;


@Controller
public class ModelController {

    private final ModelService modelService;

    @Autowired
    public ModelController(ModelService modelService) {
        this.modelService = modelService;
    }

    @ResponseBody
    @RequestMapping(path = "/car/getModelList", method = RequestMethod.POST)
    public String getModelList() {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            List<List<Model>> data = new ArrayList<List<Model>>();
            for(char i = 'A'; i <= 'Z'; i++){
                List<Model> models = modelService.getModelListByLetter(String.valueOf(i));
                data.add(models);
            }
            return gson.toJson(new Response<List<List<Model>>>(ResponseCode.R_1000, data));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }
}
