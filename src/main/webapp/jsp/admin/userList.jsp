<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="hadmin/lib/html5shiv.js"></script>
<script type="text/javascript" src="hadmin/lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css"
	href="hadmin/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css"
	href="hadmin/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css"
	href="hadmin/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css"
	href="hadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css"
	href="hadmin/static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="hadmin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>用户管理</title>
</head>
<body>
	<nav class="breadcrumb">
		<i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>
		会员管理 <span class="c-gray en">&gt;</span> 会员列表 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="pd-20">
		<form id="search_form" action="userList" method="post">
			<div class="text-c">
				日期范围： <input type="text"
					onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
					id="datemin" name="dateMin" class="input-text Wdate"
					style="width: 120px;" autocomplete="off" value="${dateMin}"> - <input type="text"
					onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
					id="datemax" name="dateMax" class="input-text Wdate"
					style="width: 120px;" autocomplete="off"  value="${dateMax}"> <input type="text"
					class="input-text" style="width: 250px" placeholder="输入会员名称"
					id="username" name="userName"  value="${userName}">
					<input type="hidden" name="admin" value="${admin}">	
				<button type="submit" class="btn btn-success" id="" name="">
					<i class="icon-search"></i> 搜用户
				</button>
			</div>
		</form>
		<table
			class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="80">ID</th>
					<th width="100">用户名</th>
					<th width="40">性别</th>
					<th width="90">手机</th>
					<th width="150">邮箱</th>
					<th width="">地址</th>
					<th width="130">加入时间</th>
					<th width="70">状态</th>
					<th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#request.users_list" id="user" status="st">
					<tr class="text-c">
						<td><input type="checkbox" value="1" name=""></td>
						<td>${user.id}</td>
						<td>${user.userName}</td>
						<td><s:if test="#user.gender == 1">女</s:if> <s:else>男</s:else></td>
						<td>${user.phone}</td>
						<td>${user.email}</td>
						<td class="text-l">${user.address}</td>
						<jsp:useBean id="timestamp" class="java.util.Date"/> 
						<jsp:setProperty name="timestamp" property="time" value="${user.add_time*1000}"/>  
						<td><fmt:formatDate value="${timestamp}" pattern="MM/dd/yyyy HH:mm:ss"/></td>
						<td class="user-status"><s:if test="#user.status == 1">
								<span class="label label-success">正常</span>
							</s:if> <s:else>
								<span class="label label-success">已禁用</span>
							</s:else></td>
						<td class="f-14 user-manage">
							<a style="text-decoration: none;<s:if test="#user.status != 1">color:#ccc</s:if>" <s:if test="#user.status == 1">onClick="user_stop(${user.id})"</s:if>href="javascript:;" title="停用"><i class="icon-hand-down"></i>停用</a> 
							<a style="text-decoration: none" class="ml-5" onClick="user_password_edit('10001','370','228','修改密码','user-password-edit.html')" href="javascript:;" title="修改密码"><i class="icon-key"></i>编辑</a>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div id="pageNav" class="pageNav"></div>
	</div>
	<!--_footer 作为公共模版分离出去-->
	<script type="text/javascript"
		src="hadmin/lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="hadmin/lib/layer/2.4/layer.js"></script>
	<script type="text/javascript" src="hadmin/static/h-ui/js/H-ui.min.js"></script>
	<script type="text/javascript"
		src="hadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
	<!--/_footer 作为公共模版分离出去-->

	<!--请在下方写此页面业务相关的脚本-->
	<script type="text/javascript"
		src="hadmin/lib/My97DatePicker/4.8/WdatePicker.js"></script>
	<script type="text/javascript"
		src="hadmin/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="hadmin/lib/laypage/1.2/laypage.js"></script>
	<script type="text/javascript">
		window.onload = (function() {
			// optional set
			pageNav.pre = "&lt;上一页";
			pageNav.next = "下一页&gt;";
			// p,当前页码,pn,总页面
			pageNav.go = function(p, pn) {
				$("#pageinfo").text("当前页:" + p + " 总页: " + pn);
			};
			//重写分页状态,跳到第三页,总页33页
			pageNav.go(1, 13);
		});
		$('.table-sort').dataTable({
			"aaSorting" : [ [ 1, "desc" ] ],//默认第几个排序
			"bStateSave" : true,//状态保存
			"aoColumnDefs" : [
			//{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
			{
				"orderable" : false,
				"aTargets" : [ 0, 2, 4 ]
			} // 制定列不参与排序
			]
		});
		
		function user_stop(id) {
			alert(id);
		}
	</script>
</body>
</html>