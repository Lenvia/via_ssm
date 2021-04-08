
$(function(){
	InitLeftMenu();  // 初始化左侧菜单栏
	tabClose();
	tabCloseEven();


})

//初始化左侧
function InitLeftMenu() {

	// jQuery Accordion 插件用于创建折叠菜单。它通常与嵌套的列表、定义列表或嵌套的 div 一起使用。选项用于指定结构、激活的元素和定制的动画。
	$("#nav").accordion({animate:false});

	// _menus是json格式的数据；_menus.menus是个数组
	/**
	  $.each(Array, function(i, value) {
		  this;      //this指向当前元素
		  i;         //i表示Array当前下标
		  value;     //value表示Array当前元素
	  });

	 _menus.menus的每个子项（也就是括号里的n）大概长这样
	 {
		"menuid": "1",
		"icon": "",
		"menuname": "学生信息管理",
		"menus": [
			{
				"menuid": "21",
				"menuname": "学生列表",
				"icon": "icon-student",
				"url": "../student/goStudentListView"
			}
		]
	},

	 n.menus的每个子项（括号里的o）大概长这样
	 {
		"menuid": "21",
		"menuname": "学生列表",
		"icon": "icon-student",
		"url": "../student/goStudentListView"
	}
	 */
    $.each(_menus.menus, function(i, n) {
		var menulist ='';
		/*
			以第一个为例，menulist添加的html文本为
			<ul><li><div>
				  <a ref="21" href="#" rel="../student/goStudentListView" >
				    <span class="icon icon-student" >&nbsp;</span>
				    <span class="nav">学生列表</span>
				  </a>
			</div></li></ul>
		*/
		menulist +='<ul>';
        $.each(n.menus, function(j, o) {
			menulist += '<li><div><a ref="'+o.menuid+'" href="#" rel="' + o.url + '" ><span class="icon '+o.icon+'" >&nbsp;</span><span class="nav">' + o.menuname + '</span></a></div></li> ';
        })
		menulist += '</ul>';

		// 新增一个分类面板
		$('#nav').accordion('add', {
            title: n.menuname,
            content: menulist,
            iconCls: 'icon ' + n.icon
        });

    });

    // CSS 后代选择器
	// 对于easyui-accordion类的 li标签下的a标签 添加click响应
	// （注释以菜单第一项为例）
	$('.easyui-accordion li a').click(function(){
		var tabTitle = $(this).children('.nav').text();  // "学生列表"

		var url = $(this).attr("rel");  // "../student/goStudentListView"
		var menuid = $(this).attr("ref");  // "21"
		var icon = getIcon(menuid,icon);  // "icon icon-student"

		addTab(tabTitle,url,icon);
		$('.easyui-accordion li div').removeClass("selected");  // 移除左侧其他div的选中状态样式
		$(this).parent().addClass("selected");  // 给当前div添加选中状态样式
	}).hover(function(){
		$(this).parent().addClass("hover");  // 当鼠标悬停在上面时 添加hover样式
	},function(){
		$(this).parent().removeClass("hover");
	});

	//选中第一个
	var panels = $('#nav').accordion('panels');  // 获取全部的面板（panel）
	var t = panels[0].panel('options').title;
    $('#nav').accordion('select', t);  // 'select'选择指定的面板（panel）。'which' 参数可以是面板（panel）的标题（title）或索引（index）。
}
//获取左侧导航的图标
function getIcon(menuid){
	var icon = 'icon ';
	$.each(_menus.menus, function(i, n) {
		 $.each(n.menus, function(j, o) {
		 	if(o.menuid==menuid){
				icon += o.icon;
			}
		 })
	})

	return icon;
}

// 例如 addTab("学生列表", "../student/goStudentListView", "icon icon-student")
// 说实话这里我不知道为啥url要加个..，我在menus中去掉了并没有报错，src仍然是localhost:8080/student/goStudentListView
function addTab(subtitle,url,icon){
	if(!$('#tabs').tabs('exists',subtitle)){
		$('#tabs').tabs('add',{
			title:subtitle,
			content:createFrame(url),
			closable:true,
			icon:icon
		});
	}else{  // 如果已经存在了，点击左侧标签相当于就选择它
		$('#tabs').tabs('select',subtitle);
		$('#mm-tabupdate').click();
	}
	tabClose();
}

// 当前标签下的内容框架
function createFrame(url)
{
	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
	return s;
}

function tabClose()
{
	/*双击关闭TAB选项卡*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
	})
	/*为选项卡绑定右键*/
	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});

		var subtitle =$(this).children(".tabs-closable").text();

		$('#mm').data("currtab",subtitle);
		$('#tabs').tabs('select',subtitle);
		return false;
	});
}
//绑定右键菜单事件
function tabCloseEven()
{
	//刷新
	$('#mm-tabupdate').click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		$('#tabs').tabs('update',{
			tab:currTab,
			options:{
				content:createFrame(url)
			}
		})
	})
	//关闭当前
	$('#mm-tabclose').click(function(){
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close',currtab_title);
	})
	//全部关闭
	$('#mm-tabcloseall').click(function(){
		$('.tabs-inner span').each(function(i,n){
			var t = $(n).text();
			$('#tabs').tabs('close',t);
		});
	});
	//关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function(){
		$('#mm-tabcloseright').click();
		$('#mm-tabcloseleft').click();
	});
	//关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function(){
		var nextall = $('.tabs-selected').nextAll();
		if(nextall.length==0){
			//msgShow('系统提示','后边没有啦~~','error');
			alert('后边没有啦~~');
			return false;
		}
		nextall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});
	//关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		if(prevall.length==0){
			alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});

	//退出
	$("#mm-exit").click(function(){
		$('#mm').menu('hide');
	})
}

//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}
