package com.kabuda.dao.common;


public interface Dao<T> {

    T get(String id);

    T get(T entity);

    int insert(T entity);

    void update(T entity);

    void delete(T entity);

}
