package com.via.dao;

import com.via.domain.Admin;
import com.via.domain.LoginForm;

import java.util.List;

// 不用加注解了
public interface AdminMapper {
    Admin login(LoginForm loginForm);

    List<Admin> selectList(Admin admin);

    Admin findByEmail(Admin admin);

    int insert(Admin admin);

    int update(Admin admin);

    int deleteById(Integer[] ids);
}
