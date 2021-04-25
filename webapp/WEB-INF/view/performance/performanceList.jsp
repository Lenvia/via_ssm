<%--
  Created by IntelliJ IDEA.
  User: yy
  Date: 2021/4/26
  Time: 上午12:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- use EL-Expression-->
<%@ page isELIgnored="false" %>
<!-- use JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8" content="#">
    <title>成绩管理页面</title>
    <!-- 引入CSS -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/css/demo.css">
    <!-- 引入JS -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/themes/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/easyui/js/validateExtends.js"></script>

    <script type="text/javascript">
        $(function (){
            var table;
            // 初始化 datagrid
            $('#dataList').datagrid({
                iconCls: 'icon-more',  // 图标
                border: true,
                collapsible: false,  // 是否可折叠
                fit: true,  // 自动大小
                method: "post",
                url: "getPerformanceList?t" + new Date().getTime(),
                idField: 'id',
                singleSelect: false,  // 是否单选
                rownumbers: true,  // 行号
                pagination: true,  // 分页控件
                sortName: 'id',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox:true, width:50},
                    {field: 'id', title:'ID', width: 50, sortable: true, hidden:'true'},
                    {field: 'sno', title:'学号', width:150},
                    {field: 'sname', title:'学生姓名', width:150},
                    {field: 'cno', title:'课程代码', width:150},
                    {field: 'cname', title:'课程名称', width:150},
                    {field: 'score', title:'分数', width: 50},
                    {field: 'pass', title:'通过', width: 50},

                ]],
                emptyMsg:'<span style=\"color:#ff0000\">无数据</span>',  //显示提示
                toolbar: "#toolbar"  // 工具栏
            })


            //设置分页控件
            var p = $('#dataList').datagrid('getPager');
            console.log(p)
            $(p).pagination({
                pageSize: 10,//设置每页显示的记录条数,默认为10
                pageList: [10, 20, 30, 50, 100],//设置每页记录的条数
                beforePageText: '第',
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            });

            $('#search-btn').click(function () {
                $('#dataList').datagrid('load', {
                    studentname: $('#search-studentname').val(),  // 学生姓名
                    coursename: $('#search-coursename').val(),  // 课程名
                });
            });

            // 信息添加按钮事件
            $("#add").click(function () {
                table = $("#addTable");
                $("#addTable").form("clear");//清空表单数据
                $("#addDialog").dialog("open");//打开添加窗口
            });

            // 信息修改按钮事件
            $("#edit").click(function () {
                table = $("#editTable");
                var selectRows = $("#dataList").datagrid("getSelections");
                if(selectRows.length !== 1){
                    $.messager.alert("消息提醒", "请选择想要修改的数据（限一行）!", "warning");
                }
                else{
                    $("#editDialog").dialog("open");//打开添加窗口
                }
            });

            // 信息删除按钮事件
            $("#delete").click(function () {
                var selectRows = $("#dataList").datagrid("getSelections");//返回所有选中的行,当没有选中的记录时,将返回空数组
                var selectLength = selectRows.length;
                if (selectLength === 0) {
                    $.messager.alert("消息提醒", "请选择想要删除的数据哟!", "warning");
                }
                else {
                    var ids = [];
                    $(selectRows).each(function (i, row){
                        ids[i] = row.id;
                    });

                    $.messager.confirm("消息提醒", "删除后将无法恢复，是否确认？", function(r){
                        if(r){
                            // console.log(ids);
                            $.ajax({
                                type: "post",
                                url: "deletePerformance?t" + new Date().getTime(),
                                data: {ids:ids},
                                dataType: 'json',
                                success: function(data){
                                    if(data.success){  // controller 返回的数据
                                        $.messager.alert("消息提醒", "删除成功！", "info");
                                        $('#dataList').datagrid("reload");
                                        $('#dataList').datagrid("uncheckAll");
                                    }
                                    else{
                                        $.messager.alert("消息提醒", data.msg, "warning");
                                    }
                                }
                            });
                        }
                    });
                }
            });


            //设置添加课程信息窗口
            $("#addDialog").dialog({  // 创建对话框（dialog
                title: "添加成绩",
                width: 660,
                height: 530,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '添加',
                        plain: true,
                        iconCls: 'icon-add',
                        handler: function () {
                            // validate参数从哪来的
                            var validate = $("#addForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟 !", "warning");
                            } else {
                                var data = $("#addForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "addPerformance?t"+ new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {  // controller返回的数据
                                            $("#addDialog").dialog("close"); //关闭窗口
                                            $('#dataList').datagrid("reload");//重新刷新页面数据
                                            $.messager.alert("消息提醒", "添加成功啦!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#add_snp").textbox('setValue', "");
                            $("#add_cno").textbox('setValue', "");
                            $("#add_score").textbox('setValue', "");
                            $("#add_pass").textbox('setValue', "");
                        }
                    }
                ]
            });

            //设置编辑课程信息窗口
            $("#editDialog").dialog({
                title: "修改成绩",
                width: 660,
                height: 500,
                iconCls: "icon-house",
                modal: true,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                draggable: true,
                closed: true,
                buttons: [
                    {
                        text: '提交',
                        plain: true,
                        iconCls: 'icon-edit',
                        handler: function () {
                            var validate = $("#editForm").form("validate");
                            if (!validate) {
                                $.messager.alert("消息提醒", "请检查你输入的数据哟!", "warning");
                            } else {
                                var data = $("#editForm").serialize();//序列化表单信息
                                $.ajax({
                                    type: "post",
                                    url: "editPerformance?t=" + new Date().getTime(),
                                    data: data,
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.success) {
                                            //关闭窗口
                                            $("#editDialog").dialog("close");
                                            //重新刷新页面数据
                                            $('#dataList').datagrid("reload");
                                            $('#dataList').datagrid("uncheckAll");
                                            //用户提示
                                            $.messager.alert("消息提醒", "修改成功!", "info");
                                        } else {
                                            $.messager.alert("消息提醒", data.msg, "warning");
                                        }
                                    }
                                });
                            }
                        }
                    },
                    {
                        text: '重置',
                        plain: true,
                        iconCls: 'icon-reload',
                        handler: function () {
                            $("#edit_sno").textbox('setValue', "");
                            $("#edit_cno").textbox('setValue', "");
                            $("#edit_score").textbox('setValue', "");
                            $("#edit_pass").textbox('setValue', "");
                        }
                    }
                ],
                //打开窗口前先初始化表单数据(表单回显)
                onBeforeOpen: function () {
                    var selectRow = $("#dataList").datagrid("getSelected");

                    $("#edit_id").val(selectRow.id);  // 初始化id值,需根据id更新课程信息

                    $("#edit_sno").textbox('setValue', selectRow.sno);
                    $("#edit_cno").textbox('setValue', selectRow.cno);

                    $("#edit_score").textbox('setValue', selectRow.score);
                    $("#edit_pass").textbox('setValue', selectRow.pass);

                }
            });

        });


    </script>
</head>
<body>

<!-- 成绩列表信息 -->
<table id="dataList" cellspacing="0" cellpadding="0"></table>
<!-- 工具栏 -->
<div id="toolbar">
    <!-- 只有管理员才能看到添加、编辑、删除按钮-->
    <c:if test="${userType == 1}">
        <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-add',plain:true">添加</a></div>

        <div style="float: left;" class="datagrid-btn-separator"></div>


        <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-edit',plain:true">修改</a></div>
        <div style="float: left;" class="datagrid-btn-separator"></div>

        <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
                                     data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>

    </c:if>

    <!-- 学生信息搜索域 -->
    <div style="margin-left: 10px;">
        <c:if test="${userType == 1}">
            <div style="float: left;" class="datagrid-btn-separator"></div>
            <!-- 学生姓名搜索框 -->
            <a href="javascript:" class="easyui-linkbutton"
               data-options="iconCls:'icon-user-class',plain:true">学生姓名</a>
            <input id="search-studentname" class="easyui-textbox" name="studentname"/>
        </c:if>

        <!-- 课程名称搜索框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-user-class',plain:true">课程名称</a>
        <input id="search-coursename" class="easyui-textbox" name="coursename"/>


        <!-- 搜索按钮 -->
        <a id="search-btn" href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',plain:true">搜索</a>
    </div>

</div>

<!-- 添加信息窗口 -->
<!-- 只有管理员能添加成绩信息-->
<div id="addDialog" style="padding: 15px 0 0 55px;">
    <!-- 课程信息表单 -->
    <form id="addForm" method="post" action="#">
        <table id="addTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">

            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="add_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'请填写学号~'"/>
                </td>
            </tr>

            <tr>
                <td>课程</td>
                <%-- 这里选择的时候显示的是课程名，但实际传递的是课程代码--%>
                <td colspan="1">
                    <select id="add_cno" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="cno" data-options="required:true, missingMessage:'请选择课程~'">
                        <option value="">未选择</option>
                        <c:forEach items="${courseList}" var="course">
                            <option value="${course.cno}">(${course.cno})${course.name}</option>
                        </c:forEach>
                    </select>

                    <%--<input id="add_cno" style="width: 200px; height: 30px;" class="easyui-textbox"--%>
                    <%--       type="text" name="cno" data-options="required:true, missingMessage:'请填写课程代码哟~'"/>--%>
                </td>
            </tr>

            <tr>
                <td>分数</td>
                <td colspan="1">
                    <input id="add_score" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="score" data-options="required:true, missingMessage:'请填写分数~'"/>
                </td>
            </tr>

            <tr>
                <td>是否通过</td>
                <td colspan="1">
                    <input id="add_pass" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="pass" placeholder="是" data-options="required:false"/>
                </td>
            </tr>



        </table>
    </form>
</div>

<!-- 修改信息窗口 -->
<div id="editDialog" style="padding: 20px 0 0 65px">
    <!-- 课程信息表单 -->

    <form id="editForm" method="post" action="#">
        <input type="hidden" id="edit_id" name="id"/>
        <table id="editTable" style="border-collapse:separate; border-spacing:0 3px;" cellpadding="6">
            <tr>
                <td>学号</td>
                <td colspan="1">
                    <input id="edit_sno" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="sno" data-options="required:true, missingMessage:'请填写学号~'"/>
                </td>
            </tr>

            <tr>
                <td>课程</td>
                <%-- 这里选择的时候显示的是课程名，但实际传递的是课程代码--%>
                <td colspan="1">
                    <select id="edit_cno" style="width: 200px; height: 30px;" class="easyui-combobox"
                            name="cno" data-options="required:true, missingMessage:'请选择课程~'">
                        <option value="">未选择</option>
                        <c:forEach items="${courseList}" var="course">
                            <option value="${course.cno}">(${course.cno})${course.name}</option>
                        </c:forEach>
                    </select>

                    <%--<input id="edit_cno" style="width: 200px; height: 30px;" class="easyui-textbox"--%>
                    <%--       type="text" name="cno" data-options="required:true, missingMessage:'请填写课程代码哟~'"/>--%>
                </td>
            </tr>

            <tr>
                <td>分数</td>
                <td colspan="1">
                    <input id="edit_score" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="score" data-options="required:true, missingMessage:'请填写分数~'"/>
                </td>
            </tr>

            <tr>
                <td>是否通过</td>
                <td colspan="1">
                    <input id="edit_pass" style="width: 200px; height: 30px;" class="easyui-textbox"
                           type="text" name="pass" placeholder="是" data-options="required:false"/>
                </td>
            </tr>


        </table>
    </form>
</div>

</body>
</html>
