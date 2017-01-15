package com.kabuda.controller;

import com.google.gson.Gson;
import com.kabuda.entity.Response;
import com.kabuda.entity.User;
import com.kabuda.service.UserService;
import com.kabuda.util.Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {

    public final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 登录
     * @param phoneNumber 电话号码
     * @param unencrypted 明文密码
     * @return 返回体
     */
    @ResponseBody
    @RequestMapping(path = "/login", method = RequestMethod.POST)
    public String login(String phoneNumber, @RequestParam("password") String unencrypted) {
        Gson gson = new Gson();
        try {
            if (StringUtils.isEmpty(phoneNumber) || StringUtils.isEmpty(unencrypted)) {
                return gson.toJson(new Response(1003, "缺少必要信息"));
            }

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist == null)
                return gson.toJson(new Response(1001, "用户不存在"));

            String password = Encrypt.SHA256(unencrypted);
            if(!isUserExist.getPassword().equals(password))
                return gson.toJson(new Response(1002, "密码不正确"));


            return gson.toJson(new Response<User>(1000, "success", isUserExist));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1004, "其它错误"));
        }
    }


    @ResponseBody
    @RequestMapping(path = "/register", method = RequestMethod.POST)
    public String register(String phoneNumber, @RequestParam("password") String unencrypted, String name, Integer sex, Integer isDriver,
                           String model, Integer price, Integer drivingAge, String location) {
        Gson gson = new Gson();
        try {
            if (StringUtils.isEmpty(phoneNumber) || StringUtils.isEmpty(unencrypted) || StringUtils.isEmpty(name)
                    || StringUtils.isEmpty(sex) || StringUtils.isEmpty(isDriver)) {
                return gson.toJson(new Response(1002, "缺少必要信息"));
            }

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist != null) {
                Response response = new Response(1001, "用户已存在");
                return gson.toJson(response);
            }

            String password = Encrypt.SHA256(unencrypted);
            User user = new User(phoneNumber, password, name, sex, isDriver, 3, 1);
            if (isDriver == 0) {
                user.setPrice(-1);   // -1表示非驾驶员
                user.setDrivingAge(-1);   // -1表示非驾驶员
                userService.insert(user);
            } else {
                user.setModel(model);
                user.setPrice(price);
                user.setDrivingAge(drivingAge);
                user.setLocation(location);
                userService.insert(user);
            }
            return gson.toJson(new Response(1000, "success"));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1003, "其它错误"));
        }
    }


    /**
     * 判断手机号是否存在
     * @param phoneNumber 电话号码
     * @return 返回体
     */
    @ResponseBody
    @RequestMapping(path = "/user/phone", method = RequestMethod.POST)
    public String isPhoneExist(String phoneNumber){
        Gson gson = new Gson();
        try {
            if(StringUtils.isEmpty(phoneNumber)){
                return gson.toJson(new Response(1002, "参数为空"));
            }

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if(isUserExist == null)
                return gson.toJson(new Response(1000, "不存在"));
            else
                return gson.toJson(new Response(1001, "已存在"));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1003, "其它错误"));
        }
    }
}
