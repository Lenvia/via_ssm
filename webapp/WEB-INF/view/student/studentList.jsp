<%--
  Created by IntelliJ IDEA.
  User: yy
  Date: 2021/4/14
  Time: 下午10:55
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
    <title>学生信息管理页面</title>
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
                url: "getStudentList?t" + new Date().getTime(),
                idField: 'sid',
                singleSelect: false,  // 是否单选
                rownumbers: true,  // 行号
                pagination: true,  // 分页控件
                sortName: 'sid',
                sortOrder: 'DESC',
                remoteSort: false,
                columns: [[
                    {field: 'chk', checkbox:true, width:50},
                    {field: 'sid', title:'ID', width: 50, sortable: true},
                    {field: 'name', title:'姓名', width: 150},
                    {field: 'major', title:'专业', width: 200},
                    {field: 'gender', title:'性别', width: 50},
                    {field: 'email', title:'邮箱', width: 150},
                    {field: 'telephone', title:'电话', width: 150},
                    {field: 'introduction', title:'简介', width: 220}
                ]],
                emptyMsg:'<span style=\"color:#ff0000\">无数据</span>',  //显示提示
                toolbar: "#toolbar"  // 工具栏
            })
        });

        //设置分页控件
        var p = $('#dataList').datagrid('getPager');
        $(p).pagination({
            pageSize: 10,//设置每页显示的记录条数,默认为10
            pageList: [10, 20, 30, 50, 100],//设置每页记录的条数
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
        });

        $('#search-btn').click(function () {
           $('#dataList').datagrid('load', {
               studentname: $('#search-studentname').val(),  // 获取学生名称
               marjorname: $('#search-majorname').combobox('getValue'),  // 获取学生专业
           });
        });

    </script>
</head>
<body>

<!-- 学生列表信息 -->
<table id="dataList" cellspacing="0" cellpadding="0"></table>
<!-- 工具栏 -->
<div id="toolbar">
    <div style="float: left;"><a id="add" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-add',plain:true">添加</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="edit" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-edit',plain:true">修改</a></div>
    <div style="float: left;" class="datagrid-btn-separator"></div>
    <div style="float: left;"><a id="delete" href="javascript:" class="easyui-linkbutton"
                                 data-options="iconCls:'icon-some-delete',plain:true">删除</a></div>

    <!-- 学生,专业搜索域 -->
    <div style="margin-left: 10px;">
        <div style="float: left;" class="datagrid-btn-separator"></div>
        <!-- 专业名称下拉框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-class',plain:true">所在专业</a>
        <select id="search-majorname" style="width: 155px;" class="easyui-combobox" name="majorname">
            <option value="">未选择专业</option>
            <option value="cs">计算机科学与技术</option>
            <option value="se">软件工程</option>
            <option value="math">数学</option>
            <option value="phy">物理</option>
            <option value="chem">化学</option>
        </select>
        <!-- 学生姓名搜索框 -->
        <a href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-user-student',plain:true">学生名称</a>
        <input id="search-studentname" class="easyui-textbox" name="studentname"/>
        <!-- 搜索按钮 -->
        <a id="search-btn" href="javascript:" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',plain:true">搜索</a>
    </div>
</div>
</body>
</html>
