package com.via.service;

import com.via.domain.LoginForm;
import com.via.domain.Student;

public interface StudentService {
    public Student login(LoginForm loginForm);
}
