package com.kabuda.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.kabuda.entity.Picture;
import com.kabuda.entity.User;
import com.kabuda.entity.Vehicle;
import com.kabuda.entity.domain.Response;
import com.kabuda.service.PictureService;
import com.kabuda.service.UserService;
import com.kabuda.service.VehicleService;
import com.kabuda.util.ResponseCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;


@Controller
@RequestMapping("/file")
public class FileController {

    private final UserService userService;

    private final PictureService pictureService;

    private final VehicleService vehicleService;

    @Autowired
    public FileController(UserService userService, PictureService pictureService, VehicleService vehicleService) {
        this.userService = userService;
        this.pictureService = pictureService;
        this.vehicleService = vehicleService;
    }


    /**
     *  用户头像上传
     */
    @ResponseBody
    @RequestMapping("/uploadAvatar")
    public String uploadAvatar(HttpServletRequest request){
        return upload(1, null, null, request);
    }


    /**
     * 车辆图片上传
     * @param id 车辆id
     * @param isFirst 是否首图
     */
    @ResponseBody
    @RequestMapping("/uploadCar")
    public String uploadCar(Integer id, Integer isFirst, HttpServletRequest request){
        return upload(0, id, isFirst, request);
    }

    /**
     * 图片上传
     * @param type 上传类型(车辆:0, 头像:1)
     * @param id 车辆id
     * @param isFirst 是否首图(不是:0，是:1)
     */
    private String upload(int type, Integer id, Integer isFirst, HttpServletRequest request) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (type == 0 && StringUtils.isEmpty(id)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }

            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return gson.toJson(new Response(ResponseCode.R_1010));
            }

            if(type == 0 && !userHasCar(user.getId(), id)){
                return gson.toJson(new Response(ResponseCode.R_1011));
            }

            String realPath = request.getSession().getServletContext().getRealPath("/");

            initFile(realPath); // 初始化保存图片的路径

            CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
            //判断 request 是否有文件上传,即多部分请求
            if (multipartResolver.isMultipart(request)) {
                MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
                Iterator<String> iterator = multiRequest.getFileNames();
                while (iterator.hasNext()) {
                    //取得上传文件
                    MultipartFile file = multiRequest.getFile(iterator.next());
                    if (file != null) {
                        //取得当前上传文件的文件名称
                        String myFileName = file.getOriginalFilename();

                        //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                        if (!StringUtils.isEmpty(myFileName.trim())) {
                            //保存图片
                            return saveFile(file, realPath, type, id, isFirst, request);
                        }
                    } else {
                        return gson.toJson(new Response(ResponseCode.R_1100));
                    }
                }
                return gson.toJson(new Response(ResponseCode.R_1000));
            }
            return gson.toJson(new Response(ResponseCode.R_1009));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * @param type 上传类型(车辆:0, 头像:1)
     */
    private String saveFile(MultipartFile file, String realPath, int type, Integer id, Integer isFirst,
                            HttpServletRequest request) throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        String timeStamp = String.valueOf(System.currentTimeMillis());
        String myFileName = timeStamp + "_" + file.getOriginalFilename();

        // 车辆: 0, 头像: 1
        if (type == 1) {
            // 保存头像
            String relativePath = "/file/avatar/" + myFileName;
            String path = realPath + relativePath;
            File localFile = new File(path);
            file.transferTo(localFile);
            // 更新数据库
            User user = (User) request.getSession().getAttribute("user");
            user.setHeadPotrait(relativePath);
            userService.update(user);
            request.getSession().removeAttribute("user");
            request.getSession().setAttribute("user", user);
            return gson.toJson(new Response(ResponseCode.R_1000));
        } else {
            String relativePath = "/file/vehicle/" + myFileName;
            String path = realPath + relativePath;
            File localFile = new File(path);
            file.transferTo(localFile);

            // 插入数据库表picture
            Picture picture = new Picture();
            picture.setIsFirst(isFirst == null ? 0 : isFirst);
            picture.setVehicleId(id);
            picture.setUrl(relativePath);
            picture.setName(myFileName);
            picture.setSize(file.getSize());
            pictureService.insert(picture);

            // 返回的数据
            Map<String, Object> result = new HashMap<String, Object>();

            List<String> initialPreview = new ArrayList<String>();
            initialPreview.add("file/vehicle/" + myFileName);
            result.put("initialPreview", initialPreview);

            List<Object> initialPreviewConfig = new ArrayList<Object>();
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("caption", myFileName);
            map.put("url", "/file/delete");
            map.put("key", picture.getId());
            map.put("size", file.getSize());
            initialPreviewConfig.add(map);

            result.put("initialPreviewConfig", initialPreviewConfig);
            return gson.toJson(result);
        }
    }

    private void initFile(String realPath) {

        File filePath = new File(realPath + "file");
        if (!filePath.exists() && !filePath.isDirectory()) filePath.mkdir();

        File avatarPath = new File(realPath + "file/avatar");
        if (!avatarPath.exists() && !avatarPath.isDirectory()) avatarPath.mkdir();

        File vehiclePath = new File(realPath + "file/vehicle");
        if (!vehiclePath.exists() && !vehiclePath.isDirectory()) vehiclePath.mkdir();
    }


    /**
     *  删除车辆图片接口
     */
    @ResponseBody
    @RequestMapping(path = "/delete", method = RequestMethod.POST)
    public String delete(Integer id, HttpServletRequest request){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(id)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }

            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return gson.toJson(new Response(ResponseCode.R_1010));
            }

            if(!userHasCar(user.getId(), id)){
                return gson.toJson(new Response(ResponseCode.R_1011));
            }

            pictureService.delete(id);
            return gson.toJson(new Response(ResponseCode.R_1000));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 车辆图片设为首图
     * @param vehicleId 车辆id
     * @param pictureId 车辆图片的id
     */
    @ResponseBody
    @RequestMapping(path = "/setFirst", method = RequestMethod.POST)
    public String setFirst(Integer vehicleId, Integer pictureId, HttpServletRequest request){
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (StringUtils.isEmpty(vehicleId) || StringUtils.isEmpty(pictureId)) {
                return gson.toJson(new Response(ResponseCode.R_1001));
            }

            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return gson.toJson(new Response(ResponseCode.R_1010));
            }

            if(!userHasCar(user.getId(), vehicleId)){
                return gson.toJson(new Response(ResponseCode.R_1011));
            }

            List<Picture> pictureList = pictureService.getPictureByVehicleId(vehicleId);
            for(Picture picture : pictureList){
                if(picture.getIsFirst() == 1){
                    picture.setIsFirst(0);
                    pictureService.update(picture);
                }
                if(picture.getId() == pictureId.intValue()){
                    picture.setIsFirst(1);
                    pictureService.update(picture);
                }
            }
            return gson.toJson(new Response(ResponseCode.R_1000));
        } catch (Exception e) {
            e.printStackTrace();
            return gson.toJson(new Response(ResponseCode.R_1100));
        }
    }


    /**
     * 判断用户是否拥有对应车辆
     * @param userId 用户id
     * @param vehicleId 车辆id
     */
    private boolean userHasCar(int userId, int vehicleId){
        List<Vehicle> vehicleList = vehicleService.getVehicleListByUserId(userId);
        if(vehicleList != null){
            for(Vehicle vehicle : vehicleList){
                if(vehicle.getId() == vehicleId)
                    return true;
            }
        }
        return false;
    }
}
