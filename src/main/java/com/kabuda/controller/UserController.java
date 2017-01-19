package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Model;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.ModelService;
import com.kabuda.service.UserService;
import com.kabuda.util.Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;


@Controller
public class UserController {

    private final UserService userService;

    private final ModelService modelService;

    @Autowired
    public UserController(UserService userService, ModelService modelService) {
        this.userService = userService;
        this.modelService = modelService;
    }

    /**
     * 登录
     *
     * @param phoneNumber 电话号码
     * @param unencrypted 明文密码
     * @return 返回体
     */
    @ResponseBody
    @RequestMapping(path = "/user/login", method = RequestMethod.POST)
    public String login(String phoneNumber, @RequestParam("password") String unencrypted, HttpSession session) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            phoneNumber = phoneNumber.trim();
            unencrypted = unencrypted.trim();
            if (StringUtils.isEmpty(phoneNumber) || StringUtils.isEmpty(unencrypted)) {
                return gson.toJson(new Response(1003, "缺少必要信息"));
            }

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist == null)
                return gson.toJson(new Response(1001, "用户不存在"));

            String password = Encrypt.SHA256(unencrypted);
            if (!isUserExist.getPassword().equals(password))
                return gson.toJson(new Response(1002, "密码不正确"));

            session.setAttribute("user", isUserExist);
            session.setMaxInactiveInterval(1800);
            return getResponse(isUserExist);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1004, "其它错误"));
        }
    }


    @ResponseBody
    @RequestMapping(path = "/user/register", method = RequestMethod.POST)
    public String register(String phoneNumber, @RequestParam("password") String unencrypted, String name, Integer sex, Integer isDriver,
                           String model, Integer price, Integer drivingAge, @RequestParam(value = "location", required = false) Integer locationId) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            phoneNumber = phoneNumber.trim();
            unencrypted = unencrypted.trim();
            name = name.trim();
            model = model.trim();
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
                if (!StringUtils.isEmpty(model)) user.setModel(model);
                if (!StringUtils.isEmpty(price)) user.setPrice(price);
                if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                if (!StringUtils.isEmpty(locationId)) user.setLocationId(locationId);
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
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            phoneNumber = phoneNumber.trim();
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
     *
     * @param id          用户id
     * @param oldPassword 原密码
     * @param newPassword 新密码
     * @return json数据
     */
    @ResponseBody
    @RequestMapping(path = "/user/changePassword", method = RequestMethod.POST)
    public String changePassword(Integer id, String oldPassword, String newPassword) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();  // TODO: 2017/1/19 userid session
        try {
            oldPassword = oldPassword.trim();
            newPassword = newPassword.trim();
            if (StringUtils.isEmpty(id) || StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
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
     * 用户修改个人信息
     */
    @ResponseBody
    @RequestMapping(path = "/user/update", method = RequestMethod.POST)
    public String update(Integer id, String name, Integer sex, Integer isDriver, String model,
                         Integer price, Integer drivingAge, @RequestParam(value = "location", required = false) Integer locationId) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();  // TODO: 2017/1/19 userid session
        try {
            name = name.trim();
            model = model.trim();
            if (StringUtils.isEmpty(id)) {
                return gson.toJson(new Response(1002, "参数为空"));
            }
            User user = userService.getUserById(id);
            if (!StringUtils.isEmpty(name)) user.setName(name);
            if (!StringUtils.isEmpty(sex)) user.setSex(sex);
            if (!StringUtils.isEmpty(isDriver)) {
                user.setIsDriver(isDriver);
                if (isDriver == 1) {
                    if (!StringUtils.isEmpty(model)) user.setModel(model);
                    if (!StringUtils.isEmpty(price)) user.setPrice(price);
                    if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                    if (!StringUtils.isEmpty(locationId)) user.setLocationId(locationId);
                } else {
                    user.setModel(null);
                    user.setPrice(-1);
                    user.setDrivingAge(-1);
                    user.setLocation(null);
                }
            } else {
                if (user.getIsDriver() == 1) {
                    if (!StringUtils.isEmpty(model)) user.setModel(model);
                    if (!StringUtils.isEmpty(price)) user.setPrice(price);
                    if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                    if (!StringUtils.isEmpty(locationId)) user.setLocationId(locationId);
                }
            }
            userService.update(user);
            return gson.toJson(new Response(1000, "success"));

        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(1003, "其它错误"));
        }
    }


    /**
     * 根据用户id获取用户信息
     *
     * @param id 用户id
     * @return json数据
     */
    @ResponseBody
    @RequestMapping(path = "/user/getInfo", method = RequestMethod.POST)
    public String getInfo(Integer id) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();  // TODO: 2017/1/19 userId session
        try {
            if (StringUtils.isEmpty(id)) {
                return gson.toJson(new Response(1002, "缺少必要信息"));
            }

            User isUserExist = userService.getUserById(id);
            if (isUserExist == null)
                return gson.toJson(new Response(1001, "用户不存在"));

            return getResponse(isUserExist);
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
    private String getResponse(User user) {
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
            }).serializeNulls().setPrettyPrinting().create();
            return gson.toJson(new Response<User>(1000, "success", user));
        }

        //如果是驾驶员返回全部字段
        user.setModelNameList(getModelNameList(user));
        return new GsonBuilder().serializeNulls().setExclusionStrategies(new ExclusionStrategy() {
            public boolean shouldSkipField(FieldAttributes f) {
                return f.getName().equals("model");
            }

            public boolean shouldSkipClass(Class<?> clazz) {
                return false;
            }
        }).setPrettyPrinting().create().toJson(new Response<User>(1000, "success", user));
    }

    /**
     * 根据user中的model设置modelNameList的值
     */
    private List<String> getModelNameList(User user){
        List<String> modelNameList = new ArrayList<String>();
        String model = user.getModel();
        String[] models = model.split(",");
        for (String m : models){
            if(!StringUtils.isEmpty(m.trim())){
                Model modelById = modelService.getModelById(Integer.valueOf(m));
                modelNameList.add(modelById.getModelName());
            }
        }
        return modelNameList;
    }
}
