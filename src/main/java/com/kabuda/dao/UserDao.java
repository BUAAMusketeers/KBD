package com.kabuda.dao;

import com.kabuda.dao.common.Dao;
import com.kabuda.entity.User;

@MyBatisDao
public interface UserDao extends Dao<User> {

    User getUserById(String id);

    User getUserByPhoneNumber(String phoneNumber);

    void insert(User user);

    void update(User user);

    void delete(User user);
}
