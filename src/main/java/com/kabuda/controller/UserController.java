package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 登录
     *
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
            if (!isUserExist.getPassword().equals(password))
                return gson.toJson(new Response(1002, "密码不正确"));

            return getResponse(isUserExist);
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
     *
     * @param phoneNumber 电话号码
     * @return 返回体
     */
    @ResponseBody
    @RequestMapping(path = "/user/phone", method = RequestMethod.POST)
    public String isPhoneExist(String phoneNumber) {
        Gson gson = new Gson();
        try {
            if (StringUtils.isEmpty(phoneNumber)) {
                return gson.toJson(new Response(1002, "参数为空"));
            }

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist == null)
                return gson.toJson(new Response(1000, "不存在"));
            else
                return gson.toJson(new Response(1001, "已存在"));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1003, "其它错误"));
        }
    }


    /**
     * 修改密码
     * @param id 用户id
     * @param oldPassword 原密码
     * @param newPassword 新密码
     * @return json数据
     */
    @ResponseBody
    @RequestMapping(path = "/user/changePassword", method = RequestMethod.POST)
    public String changePassword(int id, String oldPassword, String newPassword) {
        Gson gson = new Gson();
        try {
            if (StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
                return gson.toJson(new Response(1002, "参数为空"));
            }

            User user = userService.getUserById(id);
            if (!user.getPassword().equals(Encrypt.SHA256(oldPassword))) {
                return gson.toJson(new Response(1001, "原密码不正确"));
            }

            user.setPassword(Encrypt.SHA256(newPassword));
            userService.update(user);
            return gson.toJson(new Response(1000, "success"));

        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1003, "其它错误"));
        }
    }


    /**
     * 用户是否为驾驶员返回不同的信息
     *
     * @param user 用户信息实体
     * @return json数据
     */
    private static String getResponse(User user) {
        //如果不是驾驶员，则不返回一些驾驶员相关的字段
        if (user.getIsDriver() == 0) {
            Gson gson = new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {
                public boolean shouldSkipField(FieldAttributes f) {
                    return f.getName().contains("model") || f.getName().contains("price")
                            || f.getName().contains("drivingAge") || f.getName().contains("location");
                }

                public boolean shouldSkipClass(Class<?> clazz) {
                    return false;
                }
            }).serializeNulls().create();
            return gson.toJson(new Response<User>(1000, "success", user));
        }
        //如果是驾驶员返回全部字段
        return new GsonBuilder().serializeNulls().create().toJson(new Response<User>(1000, "success", user));
    }
}
