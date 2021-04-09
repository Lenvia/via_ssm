<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!-- 引入CSS -->
    <link href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/css/H-ui.login.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/h-ui/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet"
          type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/h-ui/js/H-ui.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/h-ui/lib/icheck/jquery.icheck.min.js"></script>

    <!-- 页面事件 -->
    <script type="text/javascript">
        $(function(){
            // 点击图片切换验证码
            $("#vcodeImg").click(function (){
                this.src = "getVerifiCodeImage?t=" + new Date().getTime();
            });

            // 点击了提交按钮
            $("#submitBtn").click(function () {
                if($("#email").val() === ""){  // 要用三个等号
                    $.messager.alert("提示", "请输入邮箱！", "warning");
                }
                else if($("#password").val() === "") {
                    $.messager.alert("提示", "请输入密码！", "warning");
                }
                else if($("#verifiCode").val() === "") {
                    $.messager.alert("提示", "请输入验证码！", "warning");
                }
                else{  // 提交
                    var data = $("#form").serialize();
                    $.ajax({
                        type: "post",
                        url: "login",
                        data: data,
                        dataType: "json",

                        success: function (data) {  // 这里的data是控制器传回来的信息
                            if(data.success){  // 验证通过
                                window.location.href = "goSystemMainView";  // 进入系统主页面
                            }
                            else{  // 没通过，显示错误信息，并刷新验证码
                                $.messager.alert("提示", data.msg, "warning");
                                $("#vcodeImg").click();  // 模拟一次点击切换验证码
                                $("#verifiCode").val("");  // 清空验证码输入框
                            }
                        }
                    })
                }
            });

            // 美化复选框
            $(".skin-minimal input").iCheck({
                radioClass: 'iradio-blue',
                increaseArea: '25%'
            });
        });

    </script>

    <title>学生管理系统 | 登录页面 </title>
    <meta name="keywords" content="学生信息管理系统">
</head>

<body style="font-weight: lighter; ">
<div class="header" style="padding: 0;">
    <h3 style="font-weight: lighter; color: white; width: 550px; height: 60px; line-height: 60px; margin: 0 0 0 30px; padding: 0;">
        教育教学信息管理系统
    </h3>
</div>
<div class="loginWraper">
    <div id="loginform" class="loginBox">
        <%--
            这里action="#"表示把数据传递到本页，并不是直接跳到控制器
            而是给submitBtn设置了onclick触发响应，先判断输入是否为空，然后ajax提交到控制器验证并接收返回值（json格式）
            然后根据返回值作出响应。
        --%>
        <form id="form" class="form form-horizontal" method="post" action="#">
            <!-- 用户身份信息 -->
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe60a;</i></label>
                <div class="formControls col-8">
                    <input id="email" name="email" type="text" placeholder="邮箱" class="input-text radius size-L"/>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe63f;</i></label>
                <div class="formControls col-8">
                    <input id="password" name="password" type="password" placeholder="密码" class="input-text radius size-L"/>
                </div>
            </div>
            <!-- 验证码 -->
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe647;</i></label>
                <div class="formControls col-8">
                    <input id="verifiCode" name="verifiCode" type="text" placeholder="验证码" class="input-text radius size-L" style="width: 200px;">

                    <img title="点击图片切换验证码" id="vcodeImg" src="/system/getVerifiCodeImage" alt="#">
                </div>
            </div>

            <!-- 用户类型 -->
            <div class="mt-20 skin-minimal" style="text-align: center;">
                <div class="radio-box">
                    <input type="radio" id="radio-1" name="userType" value="1"/>
                    <label for="radio-1">管理员</label>
                </div>
                <div class="radio-box">
                    <input type="radio" id="radio-2" name="userType" checked value="2"/>
                    <label for="radio-2">学生</label>
                </div>
            </div>
            <!-- 登录按钮 -->
            <div class="row">
                <div class="formControls col-8 col-offset-3">
                    <input id="submitBtn" type="button" class="btn btn-primary radius" value="&nbsp;
                    登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>