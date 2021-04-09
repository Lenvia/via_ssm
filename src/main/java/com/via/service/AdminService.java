package com.via.service;

import com.via.domain.Admin;
import com.via.domain.LoginForm;

public interface AdminService {
    public Admin login(LoginForm loginForm);
}
