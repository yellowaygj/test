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
<base href="<%=basePath%>">

<title>My JSP 'index.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
${pageContext.request.contextPath}
	<form
		action="${pageContext.request.contextPath}/userController/showUser"
		method="post">
		<br> <input type="text" name="id" size=10 value="1"><br>
		<input type="submit" value="提交">
		
	</form>
	<br><br><br><br>
	<a href="${pageContext.request.contextPath}/userController/testRestful/1">注解知识点</a>
	<br><br><br><br>
	<form action="${pageContext.request.contextPath}/userController/testRestful" method="post">
		用户：<input type="text" name="name" id="name"/> 
		密码：<input type="password" name="pwd" id="pwd"/><br> 
		<input type="submit" value="提交">
	</form>
	<br><br><br><br>
	PUT请求和DELETE请求:
	<br>
	DELETE
	<form action="${pageContext.request.contextPath}/userController/testRestful/1" method="post">
		<input type="hidden" name="_method" value="DELETE" /> 
		用户：<input type="text" name="username" /> 
		密码：<input type="password" name="password" />
		<br> 
		<input type="submit" value="提交">
	</form>
	<br><br><br><br>
	PUT
	<form action="${pageContext.request.contextPath}/userController/testRestful/1" method="post">
		<input type="hidden" name="_method" value="PUT" /> 
		用户：<input type="text" name="username" /> 
		密码：<input type="password" name="password" /><br>
		<input type="submit" value="提交">
	</form>

</body>
</html>
