<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="hadmin/lib/html5shiv.js"></script>
<script type="text/javascript" src="hadmin/lib/respond.min.js"></script>
<![endif]-->
<link href="hadmin/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="hadmin/static/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
<link href="hadmin/static/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
<link href="hadmin/lib/Hui-iconfont/1.0.8/iconfont.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]>
<script type="text/javascript" src="hadmin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>管理后台登录</title>
<meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
<meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="header"></div>
<div class="loginWraper">
  <div id="loginform" class="loginBox">
    <form class="form form-horizontal" Onsubmit="return false">
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60d;</i></label>
        <div class="formControls col-xs-8">
          <input id="username" name="username" type="text" placeholder="账户" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <label class="form-label col-xs-3"><i class="Hui-iconfont">&#xe60e;</i></label>
        <div class="formControls col-xs-8">
          <input id="password" name="password" type="password" placeholder="密码" class="input-text size-L">
        </div>
      </div>
      <div class="row cl">
        <div class="formControls col-xs-8 col-xs-offset-3">
          <input id="login_btn" name="" type="submit" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
          <input id="reset_btn" name="" type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;" style="margin-left:165px;">
        </div>
      </div>
    </form>
  </div>
</div>
<div class="footer">Copyright 你的公司名称 by H-ui.admin v3.1</div>
<script type="text/javascript" src="hadmin/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="hadmin/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="hadmin/lib/layer/2.4/layer.js"></script>
<script>
$("#login_btn").click(function(){
	var userName = $("#username").val();
	var password = $("#password").val();
	$.ajax({
		type:'post',
		dataType:'json',
		async:false,
		data:{
			"userName":userName,
			"password":password,
		},
		url:'checkLogin.action',
		success:function(data){
			if(data == 400) layer.msg("用户不存在", {time:2000});
			else if (data == 0) layer.msg("账号或者密码不正确", {time:2000});
			else location.reload();
		}	
	});
});
</script>
</body>
</html>