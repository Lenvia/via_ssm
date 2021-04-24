package com.via.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.via.domain.Course;
import com.via.service.MajorService;
import com.via.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    private Map<String, Object> result = new HashMap<>();  // 得定义啊啊啊啊啊啊啊啊啊

    @Autowired
    private CourseService courseService;

    @Autowired
    private MajorService majorService;

    @PostMapping("/getCourseList")
    @ResponseBody
    public Map<String, Object> getCourseList(Integer page, Integer rows, String coursename, String typename){
        // 存储查询的coursename, majorname信息
        Course course = new Course();
        course.setName(coursename);
        course.setType(typename);

        // 设置每页的记录数
        PageHelper.startPage(page, rows);

        List<Course> list = courseService.selectList(course);


        // 封装信息列表
        PageInfo<Course> pageInfo = new PageInfo<>(list);
        // 获取总记录数
        long total = pageInfo.getTotal();
        // 获取当页数据列表
        List<Course> courseList = pageInfo.getList();


        // 存储数据对象
        result.put("total", total);
        result.put("rows", courseList);

        return result;
    }

    @PostMapping("/addCourse")
    @ResponseBody
    public Map<String, Object> addCourse(Course course) {
        //判断课程代码是否已存在
        if (courseService.findByCno(course) != null) {
            result.put("success", false);
            result.put("msg", "该课程代码已经存在! 请修改后重试!");
            return result;
        }
        //添加课程信息
        if (courseService.insert(course) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! 服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/editCourse")
    @ResponseBody
    public Map<String, Object> editCourse(Course course) {
        // 更新课程信息
        if (courseService.update(course) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! (ಥ_ಥ)服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/deleteCourse")
    @ResponseBody
    public Map<String, Object>deleteCourse(@RequestParam(value = "ids[]", required = true) Integer[] ids){
        // System.out.println(ids);
        if(courseService.deleteById(ids) > 0){
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! 服务器端发生异常!");
        }

        return result;
    }


    @GetMapping("/goCourseListView")
    public ModelAndView goCourseListView(ModelAndView modelAndView){
        //向页面发送一个存储着Clazz的List对象
        modelAndView.addObject("majorList", majorService.selectAll());
        modelAndView.setViewName("course/courseList");
        return modelAndView;
    }
}
