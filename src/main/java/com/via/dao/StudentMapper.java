package com.via.dao;

import com.via.domain.LoginForm;
import com.via.domain.Student;

public interface StudentMapper {
    Student login(LoginForm loginForm);
}
