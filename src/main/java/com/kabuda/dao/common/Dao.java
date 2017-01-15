package com.kabuda.dao.common;


public interface Dao<T> {

    T get(String id);

    T get(T entity);

    T insert(T entity);

    T update(T entity);

    T delete(T entity);

}
