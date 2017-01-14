package com.kabuda.controller;

import com.kabuda.entity.User;
import com.kabuda.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path = "/user", method = RequestMethod.GET)
public class UserController {

    @Autowired
    public UserService userService;

    @ResponseBody
    @RequestMapping(path = "get", method = RequestMethod.GET)
    public String getUser(){
        User user = userService.getUser();
        return user.toString();
    }

    @RequestMapping(path = "save", method = RequestMethod.POST)
    public void insertUser(@RequestParam("phoneNumber") String phoneNumber,
                           @RequestParam("password") String password,
                           @RequestParam("name") String name){
        User user = new User();
        user.setPhoneNumber(phoneNumber);
        user.setPassword(password);
        user.setName(name);
        userService.insertUser(user);
    }
}
