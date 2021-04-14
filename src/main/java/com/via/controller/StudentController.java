package com.via.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.via.domain.Student;
import com.via.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {
    private Map<String, Object> result = new HashMap<>();  // 得定义啊啊啊啊啊啊啊啊啊

    @Autowired
    private StudentService studentService;

    @PostMapping("/getStudentList")
    @ResponseBody  // 记得加啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊
    public Map<String, Object> getStudentList(Integer page, Integer rows, String studentname, String majorname){
        // 存储查询的studentname, majorname信息
        Student student = new Student(studentname, majorname);
        // 设置每页的记录数
        PageHelper.startPage(page, rows);
        // 根据专业与学生名获取指定或全部学生信息列表
        List<Student> list = studentService.selectList(student);

        // 封装信息列表
        PageInfo<Student> pageInfo = new PageInfo<>(list);
        // 获取总记录数
        long total = pageInfo.getTotal();
        // 获取当页数据列表
        List<Student> studentList = pageInfo.getList();

        System.out.println(studentList);

        // 存储数据对象
        result.put("total", total);
        result.put("rows", studentList);

        return result;
    }

    @GetMapping("/goStudentListView")
    public String goStudentListView(){
        return "student/studentList";
    }
}
