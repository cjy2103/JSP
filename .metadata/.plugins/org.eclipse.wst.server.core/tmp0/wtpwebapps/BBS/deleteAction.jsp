<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		
		if ( userID == null ){			// 로그인이 안되어 있는 사용자 -> 로그인페이지로
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href ='login.jsp'");
			script.println("</script>");
			
		} 
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if(bbsID == 0){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href ='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if( !userID.equals(bbs.getUserID())){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href ='bbs.jsp'");
			script.println("</script>");
		} else{	 
				BbsDAO bbsDAO =new BbsDAO();
				int result = bbsDAO.delete(bbsID);
				
				if(result == - 1){	// DB 오류 발생 
					PrintWriter script =response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다..')");
					script.println("history.back()");
					script.println("</script>");
					
				}else {	// 게시글 성공적으로 삭제
					PrintWriter script =response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
					
				}
	}
	
	
	

	
	%>
</body>
</html>