package com.via.controller;

import com.via.domain.Admin;
import com.via.domain.LoginForm;
import com.via.domain.Student;
import com.via.service.AdminService;
import com.via.service.StudentService;
import com.via.util.CreateVerifiCodeImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/system")
public class SystemController {

    // 各业务层对象
    @Autowired
    private AdminService adminService;
    @Autowired
    private StudentService studentService;


    // 存储返回给页面的对象数据
    private Map<String, Object> result = new HashMap<>();


    @RequestMapping("/goLogin")
    public String goLogin(){
        return "system/login";
    }

    @RequestMapping("/getVerifiCodeImage")
    public void getVerifiCodeImage(HttpServletRequest request, HttpServletResponse response){
        // 验证码图片
        BufferedImage verifiCodeImage = CreateVerifiCodeImage.getVerifiCodeImage();
        // 验证码
        String verifiCode = String.valueOf(CreateVerifiCodeImage.getVerifiCode());

        // 将验证码输入到登录页面
        try{
            ImageIO.write(verifiCodeImage, "JPEG", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 存储验证码
        request.getSession().setAttribute("verifiCode", verifiCode);
    }

    // 返回的是键值对
    @RequestMapping("/login")
    @ResponseBody
    public Map<String, Object> login(LoginForm loginForm, HttpServletRequest request){
        // 判断验证码是否正确
        String vcode = (String) request.getSession().getAttribute("verifiCode");
        // System.out.println(loginForm);

        if("".equals(vcode)){
            result.put("success", false);
            result.put("msg", "长时间未操作，会话已失效，请刷新页面后重试！");
            return result;
        }
        else if(!loginForm.getVerifiCode().equalsIgnoreCase(vcode)){  // 注意忽略大小写
            result.put("success", false);
            result.put("msg", "验证码错误！");
            return result;
        }
        request.getSession().removeAttribute("verifiCode");  // 清除会话中的验证码

        // 判断类型，并进行响应的查询。如果是1，去查管理员的表；是2去查学生表
        switch (loginForm.getUserType()){
            case 1:
                System.out.println("查找管理员表");
                try{
                    Admin admin = adminService.login(loginForm);

                    System.out.println(admin);
                    if(admin!=null){
                        // 将信息存储到session中
                        HttpSession session = request.getSession();
                        session.setAttribute("userInfo", admin);
                        session.setAttribute("userType", loginForm.getUserType());

                        // System.out.println(admin);

                        result.put("success", true);
                        return result;
                    }
                } catch (Exception e) {
                    e.printStackTrace();

                    result.put("success", false);
                    result.put("msg", "登录失败！服务器内部异常！");
                    return result;
                }
                break;

            case 2:
                System.out.println("查找用户表");
                try{
                    Student student = studentService.login(loginForm);
                    if(student!=null){
                        // 将信息存储到session中
                        HttpSession session = request.getSession();
                        session.setAttribute("userInfo", student);
                        session.setAttribute("userType", loginForm.getUserType());

                        // System.out.println(student);

                        result.put("success", true);
                        return result;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    result.put("success", false);
                    result.put("msg", "登录失败！服务器内部异常！");
                    return result;
                }
                break;
            default:
                throw new IllegalStateException("Unexpected value: " + loginForm.getUserType());
        }


        // 如果到这里还没有返回，说明验证未通过
        result.put("success", false);
        result.put("msg", "用户名或密码错误！");

        return result;
    }

    @GetMapping("/goSystemMainView")
    public String goSystemMainView() {
        return "system/main";  // 实际跳转为/WEB-INF/view/system/main.jsp
    }

    @RequestMapping("/loginOut")
    public void loginOut(HttpServletRequest request, HttpServletResponse response){
        // 清除登录信息
        request.getSession().removeAttribute("userInfo");
        request.getSession().removeAttribute("userType");

        // 注销后重定向到登录页面
        try {
            response.sendRedirect("../index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
