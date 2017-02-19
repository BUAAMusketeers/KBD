package com.kabuda.service;


import com.kabuda.dao.UserDao;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.VehicleBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("userService")
@Transactional
public class UserService {

    private final UserDao userDao;

    @Autowired
    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    public User getUserByPhoneNumber(String phoneNumber) {
        return userDao.getUserByPhoneNumber(phoneNumber);
    }

    public void insert(User user){
        userDao.saveUser(user);
    }

    public void update(User user){
        userDao.updateUser(user);
    }

    public void delete(User user){
        userDao.removeUser(user);
    }

    public int getUserCarsCount(int id){
        return userDao.countUserCars(id);
    }

    public List<VehicleBean> getUserCarsList(int id){
        return userDao.listUserCars(id);
    }

    public int countDrivers(){
        return userDao.countDrivers();
    }

    public List<User> listDrivers(Map map){
        return userDao.listDrivers(map);
    }
}
