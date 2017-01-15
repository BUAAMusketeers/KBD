package com.kabuda.service;


import com.kabuda.dao.UserDao;
import com.kabuda.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        userDao.insert(user);
    }

    public void update(User user){
        userDao.update(user);
    }

    public void delete(User user){
        userDao.delete(user);
    }
}
