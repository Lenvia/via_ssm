package com.via.service;

import com.via.domain.LoginForm;
import com.via.domain.Student;

import java.util.List;

public interface StudentService {
    public Student login(LoginForm loginForm);

    List<Student> selectList(Student student);
}
