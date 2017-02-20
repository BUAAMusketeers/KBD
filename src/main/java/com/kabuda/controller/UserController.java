package com.kabuda.controller;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Location;
import com.kabuda.entity.Model;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.ListResponse;
import com.kabuda.entity.domain.Response;
import com.kabuda.entity.domain.VehicleBean;
import com.kabuda.entity.domain.VehicleResponse;
import com.kabuda.service.LocationService;
import com.kabuda.service.ModelService;
import com.kabuda.service.UserService;
import com.kabuda.util.Encrypt;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class UserController {

    private final UserService userService;

    private final ModelService modelService;

    private final LocationService locationService;

    @Autowired
    public UserController(UserService userService, ModelService modelService, LocationService locationService) {
        this.userService = userService;
        this.modelService = modelService;
        this.locationService = locationService;
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
    public String login(String phoneNumber, @RequestParam(value = "password", required = false) String unencrypted, HttpSession session) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(phoneNumber) || StringUtils.isEmpty(unencrypted)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            phoneNumber = phoneNumber.trim();
            unencrypted = unencrypted.trim();

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist == null)
                return gson.toJson(new Response(ResponseCode.R_1002));

            String password = Encrypt.SHA256(unencrypted);
            if (!isUserExist.getPassword().equals(password))
                return gson.toJson(new Response(ResponseCode.R_1003));

            session.setAttribute("user", isUserExist);
            session.setMaxInactiveInterval(1800); // 30 minutes
            return getResponse(isUserExist);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    @ResponseBody
    @RequestMapping(path = "/user/register", method = RequestMethod.POST)
    public String register(String phoneNumber, @RequestParam(value = "password", required = false) String unencrypted,
                           String name, Integer sex, Integer isDriver, String model, Integer price, Integer drivingAge,
                           @RequestParam(value = "location", required = false) String locationCode,
                           HttpSession session) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(phoneNumber) || StringUtils.isEmpty(unencrypted) || StringUtils.isEmpty(name)
                    || StringUtils.isEmpty(sex) || StringUtils.isEmpty(isDriver)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            phoneNumber = phoneNumber.trim();
            unencrypted = unencrypted.trim();
            name = name.trim();
            model = model.trim();

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist != null) {
                Response response = new Response(ResponseCode.R_1004);
                return gson.toJson(response);
            }

            String password = Encrypt.SHA256(unencrypted);
            User user = new User(phoneNumber, password, name, sex, isDriver, 3, 1);
            user.setHeadPotrait("/images/default_avatar.png");
            if (isDriver == 0) {
                user.setPrice(-1);   // -1表示非驾驶员
                user.setDrivingAge(-1);   // -1表示非驾驶员
                userService.insert(user);
            } else {
                if (!StringUtils.isEmpty(model)) user.setModel(model);
                if (!StringUtils.isEmpty(price)) user.setPrice(price);
                if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                if (!StringUtils.isEmpty(locationCode)) user.setLocationCode(locationCode);
                userService.insert(user);
            }

            if(!StringUtils.isEmpty(locationCode)){
                Location locationByLC = locationService.getLocationByLC(locationCode);
                user.setLocation(locationByLC.getCity());
            }
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(1800); // 30 minutes
            return gson.toJson(new Response(ResponseCode.R_1000));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }

    @RequestMapping(path = "/user/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request){
        try {
            request.getSession().removeAttribute("user");
            return "redirect:/index.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/index.jsp";
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
            if (StringUtils.isEmpty(phoneNumber)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            phoneNumber = phoneNumber.trim();

            User isUserExist = userService.getUserByPhoneNumber(phoneNumber);
            if (isUserExist == null)
                return gson.toJson(new Response(ResponseCode.R_1000));
            else
                return gson.toJson(new Response(ResponseCode.R_1005));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 修改密码
     * @param oldPassword 原密码
     * @param newPassword 新密码
     * @return json数据
     */
    @ResponseBody
    @RequestMapping(path = "/user/changePassword", method = RequestMethod.POST)
    public String changePassword(String oldPassword, String newPassword, HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(ResponseCode.R_1010));
            }

            if (StringUtils.isEmpty(oldPassword) || StringUtils.isEmpty(newPassword)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }
            oldPassword = oldPassword.trim();
            newPassword = newPassword.trim();

            if (!user.getPassword().equals(Encrypt.SHA256(oldPassword))) {
                return gson.toJson(new Response(ResponseCode.R_1006));
            }

            user.setPassword(Encrypt.SHA256(newPassword));
            userService.update(user);
            return gson.toJson(new Response(ResponseCode.R_1000));

        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 用户修改个人信息
     */
    @ResponseBody
    @RequestMapping(path = "/user/update", method = RequestMethod.POST)
    public String update(String name, Integer sex, String phoneNumber, Integer isDriver, String model, Integer price, Integer drivingAge,
                         @RequestParam(value = "location", required = false) String locationCode, HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(ResponseCode.R_1010));
            }

            if (!StringUtils.isEmpty(name)) user.setName(name.trim());
            if (!StringUtils.isEmpty(sex)) user.setSex(sex);
            if (!StringUtils.isEmpty(phoneNumber)) user.setPhoneNumber(phoneNumber.trim());
            if (!StringUtils.isEmpty(isDriver)) {
                user.setIsDriver(isDriver);
                if (isDriver == 1) {
                    if (!StringUtils.isEmpty(model)) user.setModel(model.trim());
                    if (!StringUtils.isEmpty(price)) user.setPrice(price);
                    if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                    if (!StringUtils.isEmpty(locationCode)) user.setLocationCode(locationCode);
                } else {
                    user.setModel(null);
                    user.setPrice(-1);
                    user.setDrivingAge(-1);
                    user.setLocation(null);
                }
            } else {
                if (user.getIsDriver() == 1) {
                    if (!StringUtils.isEmpty(model)) user.setModel(model.trim());
                    if (!StringUtils.isEmpty(price)) user.setPrice(price);
                    if (!StringUtils.isEmpty(drivingAge)) user.setDrivingAge(drivingAge);
                    if (!StringUtils.isEmpty(locationCode)) user.setLocationCode(locationCode);
                }
            }
            userService.update(user);
            request.getSession().removeAttribute("user");
            request.getSession().setAttribute("user", user);
            return gson.toJson(new Response(ResponseCode.R_1000));

        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 根据用户id获取用户信息
     * @return json数据
     */
    @ResponseBody
    @RequestMapping(path = "/user/getInfo", method = RequestMethod.POST)
    public String getInfo(HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(ResponseCode.R_1010));
            }
            return getResponse(user);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
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
            return gson.toJson(new Response<User>(ResponseCode.R_1000, user));
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
        }).setPrettyPrinting().create().toJson(new Response<User>(ResponseCode.R_1000, user));
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


    /**
     * 获取驾驶员列表
     * @param city 城市名字
     * @param drivingAge 驾龄(0:不限，1:0-3年，2:4-6年，3:7-9年，4:10年及以上)
     * @param sort 排序方式(0:默认，1:按驾龄升序，2:驾龄降序)
     * @param keyword 搜索关键字
     * @param limit 每一页的个数
     * @param page 第几页
     * @param modelId 机型的id
     */
    @ResponseBody
    @RequestMapping(path = "/user/getDrivers", method = RequestMethod.POST)
    public String listDrivers(String city, Integer drivingAge, Integer sort, String keyword, Integer limit, Integer page,
                              @RequestParam(value = "model", required = false) Integer modelId){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        if(StringUtils.isEmpty(drivingAge) || StringUtils.isEmpty(sort) || StringUtils.isEmpty(limit)
                || StringUtils.isEmpty(page)){
            return gson.toJson(new Response(ResponseCode.R_1001));
        }
        city = StringUtils.isEmpty(city)? city : city.trim();
        keyword = StringUtils.isEmpty(keyword)? keyword : keyword.trim();

        int offset = (page - 1) * limit;
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("city", city);
        map.put("drivingAge", drivingAge);
        map.put("sort", sort);
        map.put("keyword", keyword);
        map.put("modelId", modelId);
        map.put("limit", limit);
        map.put("offset", offset);
        try {
            List<User> driverList = userService.listDrivers(map);
            int total = 0;
            if(driverList != null){
                total = driverList.size();

                List<Model> modelList = modelService.listModel();
                for(User u : driverList){
                    if(u.getModel() != null){
                        String[] models = u.getModel().split(",");
                        List<String> modelNameList = new ArrayList<String>();
                        for (String m : models){
                            if(!StringUtils.isEmpty(m.trim())){
                                modelNameList.add(modelList.get(Integer.valueOf(m) - 1).getModelName());
                            }
                        }
                        u.setModelNameList(modelNameList);
                    }
                }
            }
            return new GsonBuilder().serializeNulls().setPrettyPrinting().create()
                    .toJson(new ListResponse<User>(ResponseCode.R_1000, total, driverList));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 获取用户的车辆列表
     */
    @ResponseBody
    @RequestMapping(path = "/user/getCarList", method = RequestMethod.POST)
    public String getUserCarList(HttpServletRequest request){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            User user = (User) request.getSession().getAttribute("user");
            if(user == null){
                return gson.toJson(new Response(ResponseCode.R_1010));
            }
            int userId = user.getId();
            int userCarsCount = userService.getUserCarsCount(userId);
            List<VehicleBean> userCarsList = userService.getUserCarsList(userId);
            return getUserCarListGson(userCarsCount, userCarsList);
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }

    private String getUserCarListGson(int userCarsCount, List<VehicleBean> userCarsList){
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").serializeNulls().setPrettyPrinting().create();
        return gson.toJson(new VehicleResponse(ResponseCode.R_1000, userCarsCount, userCarsList));
    }
}
