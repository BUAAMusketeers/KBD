package com.kabuda.service;


import com.kabuda.dao.UserDao;
import com.kabuda.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userService")
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;

    public User getUser(){
        User user = userDao.getUser();
        System.out.println(user);
        return user;
    }

    public void insertUser(User user){
        userDao.insertUser(user);
    }
}
