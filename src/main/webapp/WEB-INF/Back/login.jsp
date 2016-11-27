<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 登录</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
	<script language="javascript">
		function login() {
			var name = document.getElementById('name').value;
			var pwd = document.getElementById('pwd').value;
			if (name == "") {
				alert("用户名不能为空");
				return false;
			} else if (pwd == "") {
				alert("密码不能为空");
				return false;
			} else {
				userLogin(name, pwd);
			}
		}
		function userLogin(name, pwd) {
			var data = {
				name : name,
				pwd : pwd
			};
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/userController/doLogin',
				data : data,
				dataType : 'json',
				success : function(result) {
				if (result.status == "success") {
					window.location.href = "${pageContext.request.contextPath}/userController/index";
				} else {
					console.log(result);
	                var msg = "账号或密码错误，请重新输入！！！";
					toastr.options = {
						  "closeButton": true,
						  "debug": false,
						  "progressBar": true,
						  "positionClass": "toast-top-center",
						  "onclick": null,
						  "showDuration": "400",
						  "hideDuration": "1000",
						  "timeOut": "2000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "fadeIn",
						  "hideMethod": "fadeOut"
						}				
	                toastr["info"](msg); // Wire up an event handler to a button in the toast, if it exists
					document.getElementById('name').focus();
					document.getElementById('name').value="";
					document.getElementById('pwd').value="";
					return false;
					}
				}
			});
		}
	</script>
</head>
<body>

<body class="gray-bg">
    <div class="middle-box text-center loginscreen  animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">h</h1>
            </div>
            <h3>欢迎使用 hAdmin</h3>      
                <div class="form-group">
                    <input id="name" type="test" class="form-control" placeholder="用户名" required>
                </div>
                <div class="form-group">
                    <input id="pwd" type="password" class="form-control" placeholder="密码" required>
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b" onclick="login()">登 录</button>
                <p class="text-muted text-center"> <a href="login.html#"><small>忘记密码了？</small></a> | <a href="register.html">注册一个新账号</a>
                </p>
        </div>
    </div>
    <!-- 全局js -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js?v=2.1.4"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins/toastr/toastr.min.js"></script>
</body>
</html>
