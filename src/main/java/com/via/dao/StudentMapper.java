package com.via.dao;

import com.via.domain.LoginForm;
import com.via.domain.Student;

import java.util.List;

public interface StudentMapper {
    Student login(LoginForm loginForm);

    List<Student> selectList(Student student);

    Student findBySno(Student student);

    int insert(Student student);
}
