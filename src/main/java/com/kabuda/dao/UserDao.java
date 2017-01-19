package com.kabuda.dao;

import com.kabuda.dao.common.Dao;
import com.kabuda.dao.common.MyBatisDao;
import com.kabuda.entity.User;
import com.kabuda.entity.domain.VehicleBean;

import java.util.List;

@MyBatisDao
public interface UserDao extends Dao<User> {

    User getUserById(int id);

    User getUserByPhoneNumber(String phoneNumber);

    void insert(User user);

    void update(User user);

    void delete(User user);

    int getUserCarsCount(int id);

    List<VehicleBean> getUserCarsList(int id);
}
