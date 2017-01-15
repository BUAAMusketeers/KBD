package com.kabuda.controller;


import com.google.gson.Gson;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.ModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


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
        Gson gson = new Gson();
        modelService.getModelListByLetter("a");
        return gson.toJson(new Response(1000, "success"));
    }
}
