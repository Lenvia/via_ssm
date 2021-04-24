package com.via.service;

import com.via.domain.Course;

import java.util.List;

public interface CourseService {
    List<Course> selectList(Course course);

    Course findByCno(Course course);

    int insert(Course course);

    int update(Course course);

    int deleteById(Integer[] ids);
}
