<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a
			class="btn btn-success radius r"
			style="line-height: 1.6em; margin-top: 3px"
			href="javascript:location.replace(location.href);" title="刷新"><i
			class="Hui-iconfont">&#xe68f;</i></a>
	</nav>
	<div class="pd-20">
		<form id="search_form" action="adminList" method="post">
			<div class="text-c">
				日期范围： <input type="text"
					onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
					id="datemin" name="dateMin" class="input-text Wdate"
					style="width: 120px;" autocomplete="off" value="${dateMin}">
				- <input type="text"
					onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
					id="datemax" name="dateMax" class="input-text Wdate"
					style="width: 120px;" autocomplete="off" value="${dateMax}">
				<input type="text" class="input-text" style="width: 250px"
					placeholder="输入会员名称" id="username" name="userName"
					value="${userName}"> <input type="hidden" name="admin"
					value="${admin}">
				<button type="submit" class="btn btn-success" id="" name="">
					<i class="icon-search"></i> 搜用户
				</button>
				<span id="new_user" class="btn btn-success"> <i
					class="icon-search"></i> 添加管理员
				</span>
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
						<jsp:useBean id="timestamp" class="java.util.Date" />
						<jsp:setProperty name="timestamp" property="time"
							value="${user.add_time*1000}" />
						<td><fmt:formatDate value="${timestamp}"
								pattern="MM/dd/yyyy HH:mm:ss" /></td>
						<td class="user-status"><s:if test="#user.status == 1">
								<span class="label label-success">正常</span>
							</s:if> <s:else>
								<span class="label label-success">已禁用</span>
							</s:else></td>
						<td class="f-14 user-manage"><a
							style="text-decoration: none;"
							onClick="user_stop(${user.id},${user.status})"
							href="javascript:;" title="停用"><i class="icon-hand-down"></i>
								<s:if test="#user.status == 1">停用</s:if> <s:else>恢复</s:else></a> <a
							style="text-decoration: none" class="ml-5"
							onClick="user_edit(${user.id})" href="javascript:;" title="修改密码"><i
								class="icon-key"></i>编辑</a></td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div id="pageNav" class="pageNav"></div>
		<div class="site-text" style="margin: 5%; display: none" id="window">
			<form class="layui-form form" id="admin" method="post">
				<input type="hidden" id="id" name="id" value="">
				<input type="hidden" name="admin" value="1">
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span
						class="c-red">*</span>用户名：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" class="input-text" value="" placeholder=""
							id="userName" name="userName">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3"><span
						class="c-red">*</span>密码：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" class="input-text" value="" placeholder=""
							id="password" name="password">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">性别：</label>
					<div class="formControls col-xs-8 col-sm-9 skin-minimal">
						<div class="radio-box">
							<input name="gender" type="radio" id="sex-1" value="0" checked>
							<label for="sex-1">男</label>
						</div>
						<div class="radio-box">
							<input type="radio" id="sex-2" name="gender" value="1"> <label
								for="sex-2">女</label>
						</div>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">手机：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" class="input-text" value="" placeholder=""
							id="phone" name="phone">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">邮箱：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" class="input-text" placeholder="@" name="email"
							id="email">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">地址：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input type="text" class="input-text" placeholder="@"
							name="address" id="address">
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">状态：</label>
					<div class="formControls col-xs-8 col-sm-9 skin-minimal">
						<div class="radio-box">
							<input name="status" type="radio" id="status-1" value="1" checked>
							<label for="status-1">正常</label>
						</div>
						<div class="radio-box">
							<input type="radio" id="status-2" name="status" value="0">
							<label for="status-2">禁用</label>
						</div>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-3">备注：</label>
					<div class="formControls col-xs-8 col-sm-9">
						<textarea id="note" name="note" cols="" rows="" class="textarea"
							placeholder="说点什么...最少输入10个字符"
							onKeyUp="$.Huitextarealength(this,100)"></textarea>
						<p class="textarea-numberbar">
							<em class="textarea-length">0</em>/100
						</p>
					</div>
				</div>
			</form>
		</div>
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

		function user_stop(id, status) {
			var text = "停用";
			if(status == 0) {
				text = "启用";
			}
			$.ajax({
				type:'post',
				dataType:'json',
				async:false,
				data: {
					"id" : id,
					"status" : status
				},
				url:'stopUser.action',
				success:function(data){
					if(data == 1) {
						layer.msg("用户"+ text +"成功", {time:2000}, function(){
							location.reload();
						});
					} else if (data == 0) layer.msg("用户"+ text +"失败", {time:2000});
				}	
			});
		}

		$('#new_user').on('click', function() {
			$("#id").val("");
			//页面层
			layer.open({
				type : 1 //Page层类型
				,
				skin : 'layui-layer-molv',
				area : [ '600px', '560px' ],
				title : [ '新增管理员', 'font-size:18px' ],
				btn : [ '确定', '取消' ],
				shadeClose : true,
				shade : 0 //遮罩透明度
				,
				maxmin : true //允许全屏最小化
				,
				content : $("#window"),
				success : function() {
				},
				yes : function() {
					var data = $("#admin").serializeArray();
					var newdata ={}
					data.map(function(val,key){
						newdata[val.name]=val.value;
					});
					$.ajax({
						type:'post',
						dataType:'json',
						async:false,
						data:newdata,
						url:'saveUser.action',
						success:function(data){
							if(data == 1) {
								layer.msg("用户新增成功", {time:2000}, function(){
									location.reload();
								});
							} else if (data == 0) layer.msg("用户新增失败", {time:2000});
						}	
					});
				}
			});
		});
		
		function user_edit(id) {
			$("#id").val(id);
			$.ajax({
				type:'get',
				dataType:'json',
				async:false,
				data:{
					"id" : id
				},
				url:'getUser.action',
				success:function(data){
					var obj = JSON.parse(data);
					var user = obj[0];
					console.log(user);
					$("#userName").val(user.userName);
					$("#password").val(user.password);
					if(user.gender == 1) {
						 $("#sex-1").removeAttr("checked");
					     $("#sex-2").attr("checked","checked");
					} else {
						 $("#sex-2").removeAttr("checked");
					     $("#sex-1").attr("checked","checked");
					}
					$("#phone").val(user.phone);
					$("#email").val(user.email);
					$("#address").val(user.address);
					if(user.status == 1) {
					     $("#status-2").removeAttr("checked");
					     $("#status-1").attr("checked","checked");
						 
					} else {
						 $("#status-1").removeAttr("checked");
					     $("#status-2").attr("checked","checked"); 
					}
					$("#note").val(user.note);
					if(user) {
						layer.open({
							type : 1, //Page层类型
							skin : 'layui-layer-molv',
							area : [ '600px', '560px' ],
							title : [ '新增管理员', 'font-size:18px' ],
							btn : [ '确定', '取消' ],
							shadeClose : true,
							shade : 0, //遮罩透明度
							maxmin : true, //允许全屏最小化
							content : $("#window"),
							success : function() {
							},
							yes : function() {
								var data = $("#admin").serializeArray();
								var newdata ={}
								data.map(function(val,key){
									newdata[val.name]=val.value;
								});
								$.ajax({
									type:'post',
									dataType:'json',
									async:false,
									data:newdata,
									url:'saveUser.action',
									success:function(data){
										if(data == 1) {
											layer.msg("用户保存成功", {time:2000}, function(){
												location.reload();
											});
										} else if (data == 0) layer.msg("用户保存失败", {time:2000});
									}	
								});
							}
						});
					}
				}	
			});
		}
	</script>
</body>
</html>