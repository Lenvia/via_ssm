package com.via.service.impl;

import com.via.dao.StudentMapper;
import com.via.domain.LoginForm;
import com.via.domain.Student;
import com.via.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student login(LoginForm loginForm) {
        return studentMapper.login(loginForm);
    }

    @Override
    public List<Student> selectList(Student student) {
        return studentMapper.selectList(student);
    }

    @Override
    public List<Student> findByEmail(Student student) {
        return studentMapper.findByEmail(student);
    }

    @Override
    public Student findBySno(Student student) {
        return studentMapper.findBySno(student);
    }

    @Override
    public int insert(Student student) {
        return studentMapper.insert(student);
    }

    @Override
    public int update(Student student) {
        return studentMapper.update(student);
    }

    @Override
    public int deleteById(Integer[] ids){
        return studentMapper.deleteById(ids);
    }
}
