package com.kabuda.dao;

import com.kabuda.entity.User;

@MyBatisDao
public interface UserDao {

    User getUser();

    void insertUser(User user);
}
