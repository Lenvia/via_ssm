<%--
  Created by IntelliJ IDEA.
  User: yy
  Date: 2021/4/9
  Time: 上午11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>教育教学信息管理系统 | 系统主页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/default.css"/>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/metro/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css"/>
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>

    <script type="text/javascript" src='${pageContext.request.contextPath}/static/easyui/js/outlook2.js'></script>

    <script type="text/javascript">
        // 设置系统功能菜单栏
        // _menus["menus"]是一个数组，包含各个页面标签
        var _menus = {
            "menus":[
                // 学生信息（都可查看，管理员可增删改查，学生只能修改自己的）
                {
                    "menuid": "1",
                    "icon": "",
                    "menuname": "学生信息管理",
                    "menus":[
                        {
                            "menuid": "21",
                            "menuname": "学生列表",
                            "icon": "icon-student",
                            "url": "../student/goStudentListView"
                        }
                    ]
                },
                // 课程信息（都可查看，仅管理员可修改）
                {
                    "menuid": "2",
                    "icon": "",
                    "menuname": "课程信息管理",
                    "menus":[
                        {
                            "menuid": "22",
                            "menuname": "课程列表",
                            "icon": "",
                            "url": "../course/goCourseListView"
                        }
                    ]
                },

                // 成绩信息（学生只能查看自己的，管理员可操作）
                {
                    "menuid": "3",
                    "icon": "",
                    "menuname": "成绩管理",
                    "menus":[
                        {
                            "menuid": "23",
                            "menuname": "成绩列表",
                            "icon": "",
                            "url": "../performance/goPerformanceListView"
                        }
                    ]
                },

                // 管理员信息（仅管理员可见）
                <%-- 通过JSTL设置用户查看权限：仅管理员可以查看 --%>
                <c:if test="${userType == 1}">
                {
                    "menuid": "4",
                    "icon": "",
                    "menuname": "管理员信息管理",
                    "menus":[
                        {
                            "menuid": "24",
                            "menuname": "管理员列表",
                            "icon": "",
                            "url": "../admin/goAdminListView"
                        }
                    ]
                },
                </c:if>

                {
                    "menuid": "5", "icon": "",
                    "menuname": "个人信息管理",
                    "menus": [
                        {
                            "menuid": "25",
                            "menuname": "修改密码",
                            "icon": "icon-settings",
                            "url": "../common/goSettingView"
                        }
                    ]
                }
            ]
        }
    </script>
</head>

<body class="easyui-layout" style="overflow-y: hidden" scroll="no">

    <!-- 页面顶部-->
    <div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体,'Lucida Console',serif">
        <span style="float:right; padding-right:20px;" class="head">
        	<span style="color:blue;" class="easyui-linkbutton" data-options="iconCls:'icon-user',plain:true">
                <!--获取用户登录类型-->
                <c:choose>
                    <%--这里的${}内部是session里保存的变量--%>
                    <%--when用在<c:choose>中，可以进行多个条件选择--%>
                    <c:when test="${userType==1}">管理员：</c:when>
                    <c:when test="${userType==2}">学生：</c:when>
                </c:choose>
            </span>
            <%--从session中获取登录用户的用户名--%>
            <span style="color:red; font-weight:bold;">${userInfo.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
        	<a href="loginOut" id="loginOut" style="color: darkgrey;" class="easyui-linkbutton"
               data-options="iconCls:'icon-exit',plain:true">
                [安全退出]
        	</a>
        </span>

        <span style="padding-left:10px; font-size: 20px; color:darkgrey;font-weight: bold">教育教学信息管理系统</span>
    </div>

    <!-- 导航菜单内容 -->
    <div region="west" hide="true" split="true" title="[ 导航菜单 ]" style="width:180px;" id="west">
        <div id="nav" class="easyui-accordion" fit="true">
            <%--
                导航菜单内容在本页的js变量_menus中定义
                布局在outlook2.js中使用jQuery Accordion创建
            --%>
            <!-- ······ -->
        </div>
    </div>

    <!-- 引入欢迎页面资源 -->
    <div id="mainPanel" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs" fit="true">
            <jsp:include page="/WEB-INF/view/system/intro.jsp"/>
        </div>
    </div>
</body>
</html>
