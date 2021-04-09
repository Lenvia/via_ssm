package com.via.service.impl;

import com.via.dao.AdminMapper;
import com.via.domain.Admin;
import com.via.domain.LoginForm;
import com.via.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public Admin login(LoginForm loginForm) {
        return adminMapper.login(loginForm);
    }
}
