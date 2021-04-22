package com.via.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.via.domain.Student;
import com.via.service.StudentService;
import com.via.util.UploadFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
    public Map<String, Object> getStudentList(HttpServletRequest request, Integer page, Integer rows, String studentname, String majorname){
        // System.out.println(studentname+"  "+majorname);
        // 存储查询的studentname, majorname信息
        Student student = new Student(studentname, majorname);
        // 设置每页的记录数
        PageHelper.startPage(page, rows);

        Integer userType = (Integer) request.getSession().getAttribute("userType");

        List<Student> list;

        if(userType == 1){  // 管理员
            // 根据专业与学生名获取指定或全部学生信息列表
            list = studentService.selectList(student);
        }
        else{  // 学生只能获取他自己的
            student = (Student) request.getSession().getAttribute("userInfo");
            list = studentService.findByEmail(student);
        }

        // System.out.println(list);

        // 封装信息列表
        PageInfo<Student> pageInfo = new PageInfo<>(list);
        // 获取总记录数
        long total = pageInfo.getTotal();
        // 获取当页数据列表
        List<Student> studentList = pageInfo.getList();

        // System.out.println(studentList);

        // 存储数据对象
        result.put("total", total);
        result.put("rows", studentList);

        return result;
    }

    @PostMapping("/addStudent")
    @ResponseBody
    public Map<String, Object> addStudent(Student student) {
        //判断学号是否已存在
        if (studentService.findBySno(student) != null) {
            result.put("success", false);
            result.put("msg", "该学号已经存在! 请修改后重试!");
            return result;
        }
        //添加学生信息
        if (studentService.insert(student) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "添加失败! 服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/editStudent")
    @ResponseBody
    public Map<String, Object> editStudent(Student student) {
        // System.out.println(student);
        // 更新学生信息
        if (studentService.update(student) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! (ಥ_ಥ)服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/deleteStudent")
    @ResponseBody
    public Map<String, Object>deleteStudent(@RequestParam(value = "ids[]", required = true) Integer[] ids){
        // System.out.println(ids);
        if(studentService.deleteById(ids) > 0){
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! 服务器端发生异常!");
        }

        return result;
    }


    @GetMapping("/goStudentListView")
    public String goStudentListView(){
        return "student/studentList";
    }

    @PostMapping("/uploadPhoto")
    @ResponseBody
    public Map<String, Object> uploadPhoto(MultipartFile photo, HttpServletRequest request) {
        //存储头像的本地目录
        final String dirPath = request.getServletContext().getRealPath("/upload/student_portrait/");
        //存储头像的项目发布目录
        final String portraitPath = request.getServletContext().getContextPath() + "/upload/student_portrait/";
        //返回头像的上传结果
        return UploadFile.getUploadResult(photo, dirPath, portraitPath);
    }
}
