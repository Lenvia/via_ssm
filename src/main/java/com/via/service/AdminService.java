package com.via.service;

import com.via.domain.Admin;
import com.via.domain.LoginForm;

import java.util.List;

public interface AdminService {
    public Admin login(LoginForm loginForm);

    List<Admin> selectList(Admin admin);

    List<Admin> findByEmail(Admin admin);

    int insert(Admin admin);
}
