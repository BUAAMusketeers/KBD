package com.kabuda.dao;

import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.VehicleBean;

import java.util.List;
import java.util.Map;

@MyBatisDao
public interface UserDao extends Dao<User> {

    User getUserById(int id);

    User getUserByPhoneNumber(String phoneNumber);

    int saveUser(User user);

    void updateUser(User user);

    void removeUser(User user);

    int countUserCars(int id);

    List<VehicleBean> listUserCars(int id);

    List<User> listDrivers(Map map);
}
