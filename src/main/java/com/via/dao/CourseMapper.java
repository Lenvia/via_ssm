package com.via.dao;

import com.via.domain.Course;

import java.util.List;

public interface CourseMapper {
    List<Course> selectList(Course course);

    Course findByCno(Course course);

    int insert(Course course);

    int update(Course course);

    int deleteById(Integer[] ids);

    List<Course> selectAll();

}
