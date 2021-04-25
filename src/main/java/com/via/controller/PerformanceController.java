package com.via.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.via.domain.Performance;
import com.via.domain.Student;
import com.via.service.CourseService;
import com.via.service.PerformanceService;
import com.via.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/performance")
public class PerformanceController {
    private Map<String, Object> result = new HashMap<>();

    @Autowired
    private StudentService studentService;
    @Autowired
    private PerformanceService performanceService;
    @Autowired
    private CourseService courseService;


    @GetMapping("/goPerformanceListView")
    public ModelAndView goPerformanceListView(ModelAndView modelAndView){
        modelAndView.addObject("courseList", courseService.selectAll());
        modelAndView.addObject("studentList", studentService.selectAll());
        modelAndView.setViewName("performance/performanceList");
        return modelAndView;
    }

    @PostMapping("/getPerformanceList")
    @ResponseBody
    public Map<String, Object> getPerformanceList(HttpServletRequest request, Integer page, Integer rows, String studentname, String coursename){

        Performance performance = new Performance();
        performance.setSname(studentname);
        performance.setCname(coursename);

        // 设置每页的记录数
        PageHelper.startPage(page, rows);

        Integer userType = (Integer) request.getSession().getAttribute("userType");

        List<Performance> list;

        if(userType == 1){  // 管理员
            // 根据专业与学生名获取指定或全部学生信息列表
            list = performanceService.selectList(performance);
        }
        else{  // 学生只能获取他自己的
            Student student = (Student) request.getSession().getAttribute("userInfo");
            // 把student的学号赋给performance
            performance.setSno(student.getSno());
            list = performanceService.selectList(performance);
        }

        // System.out.println(list);

        // 封装信息列表
        PageInfo<Performance> pageInfo = new PageInfo<>(list);
        // 获取总记录数
        long total = pageInfo.getTotal();
        // 获取当页数据列表
        List<Performance> performanceList = pageInfo.getList();

        // System.out.println(performanceList);

        // 存储数据对象
        result.put("total", total);
        result.put("rows", performanceList);

        return result;
    }
}
