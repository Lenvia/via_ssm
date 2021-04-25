package com.via.service.impl;

import com.via.dao.CourseMapper;
import com.via.domain.Course;
import com.via.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CourseServiceImpl implements CourseService {
    @Autowired
    private CourseMapper courseMapper;

    @Override
    public List<Course> selectList(Course course) {
        return courseMapper.selectList(course);
    }

    @Override
    public Course findByCno(Course course) {
        return courseMapper.findByCno(course);
    }

    @Override
    public int insert(Course course) {
        return courseMapper.insert(course);
    }

    @Override
    public int update(Course course) {
        System.out.println(course);
        int temp = courseMapper.update(course);
        System.out.println(temp);
        // return courseMapper.update(course);
        return temp;
    }

    @Override
    public int deleteById(Integer[] ids) {
        return courseMapper.deleteById(ids);
    }

    @Override
    public List<Course> selectAll() {
        return courseMapper.selectAll();
    }
}
