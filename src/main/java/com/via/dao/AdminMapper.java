package com.via.dao;

import com.via.domain.Admin;
import com.via.domain.LoginForm;

// 不用加注解了
public interface AdminMapper {
    Admin login(LoginForm loginForm);
}
