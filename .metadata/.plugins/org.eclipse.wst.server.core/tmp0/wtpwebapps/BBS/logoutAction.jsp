<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" charset="UTF-8">
<title> JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		session.invalidate();	// 세션을 빼앗기도록 해주는 부분  -> 로그아웃
		
	%>
	<script>
		location.href = 'main.jsp';	
	</script>
</body>
</html>