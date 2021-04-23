package com.via.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.via.domain.Admin;
import com.via.domain.Admin;
import com.via.service.AdminService;
import com.via.util.UploadFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    private Map<String, Object> result = new HashMap<>();

    @Autowired
    private AdminService adminService;

    @GetMapping("/goAdminListView")
    public String goAdminListView(){
        return "admin/adminList";
    }


    @PostMapping("/getAdminList")
    @ResponseBody
    public Map<String, Object> getAdminList(Integer page, Integer rows, String username){
        Admin admin = new Admin();
        admin.setName(username);

        PageHelper.startPage(page, rows);

        List<Admin> list = adminService.selectList(admin);

        // 封装信息列表
        PageInfo<Admin> pageInfo = new PageInfo<>(list);

        long total = pageInfo.getTotal();
        // 获取当页数据列表
        List<Admin> adminList = pageInfo.getList();
        // 存储数据对象
        result.put("total", total);
        result.put("rows", adminList);

        return result;
    }

    @PostMapping("/addAdmin")
    @ResponseBody
    public Map<String, Object> addAdmin(Admin admin){
        // 判断邮箱是否已经存在
        if(adminService.findByEmail(admin) !=null){
            result.put("success", false);
            result.put("msg", "该邮箱已存在，请修改后重试！");
            return result;
        }
        // 添加管理员信息
        if(adminService.insert(admin)>0){
            result.put("success", true);
        }
        else{
            result.put("success", false);
            result.put("msg", "添加失败! 服务器端发生异常!");
        }
        return result;
    }

    @PostMapping("/editAdmin")
    @ResponseBody
    public Map<String, Object> editAdmin(Admin admin) {
        // System.out.println(admin);
        if (adminService.update(admin) > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! (ಥ_ಥ)服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/deleteAdmin")
    @ResponseBody
    public Map<String, Object>deleteAdmin(@RequestParam(value = "ids[]", required = true) Integer[] ids){
        // System.out.println(ids);
        if(adminService.deleteById(ids) > 0){
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("msg", "更新失败! 服务器端发生异常!");
        }

        return result;
    }

    @PostMapping("/uploadPhoto")
    @ResponseBody
    public Map<String, Object> uploadPhoto(MultipartFile photo, HttpServletRequest request) {
        //存储头像的本地目录
        final String dirPath = request.getServletContext().getRealPath("/upload/admin_portrait/");
        //存储头像的项目发布目录
        final String portraitPath = request.getServletContext().getContextPath() + "/upload/admin_portrait/";
        //返回头像的上传结果
        return UploadFile.getUploadResult(photo, dirPath, portraitPath);
    }

}
