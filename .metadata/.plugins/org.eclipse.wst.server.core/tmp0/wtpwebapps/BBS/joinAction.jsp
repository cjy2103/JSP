<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" charset="UTF-8">
<title> JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	
	String userID = null;
	if(session.getAttribute("userID") != null){	
		userID = (String) session.getAttribute("userID");	// userID가 자신에게 할당된 세션ID를 담을수 있도록 함
	}
	
	if ( userID != null ){		// 이미 로그인된 사람은 회원가입 페이지에 접속할수 없게 막아줌
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href ='main.jsp'");
		script.println("</script>");
		
	}
	
	if( user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
	   || user.getUserGender() == null || user.getUserEmail() == null) {
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else { 
		UserDAO userDAO =new UserDAO();
		int result = userDAO.join(user);	// user가 매개변수로 join이라는 함수에 들어감
		
		if(result == - 1){	// DB 오류 발생 -> 해당 ID가 존재하는 경우 
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		}else {	// 정상 회원가입 -> 로그인시켜서 메인화면으로 이동 
			session.setAttribute("userID", user.getUserID());
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
	}

	
	%>
</body>
</html>