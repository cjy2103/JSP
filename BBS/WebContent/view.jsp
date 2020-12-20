<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" charset="UTF-8">
<meta name = "viewport" content = "width=device-width", intial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title> JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {	// 로그인한 사람은  userID에 해당 세션 ID가 담김 그렇지 않은 사람은 null값이 담김
			userID = (String) session.getAttribute("userID");
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
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);	// 유효한 글이라면 구체적인 정보를 bbs에 담아줌 
	
	
	%>
	

	<nav class="navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class = "navbar-toggle collapsed"
				data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1"
				aria-expanded = "false">
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
					<span class = "icon-bar"></span>
			</button>
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class ="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				// 로그인이 되어있지 않은 경우에만 나올수 있도록 
				if(userID == null){	
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class= "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expaned="false">접속하기<span class="caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			
			<%
				} else {	// 로그인이 되어있는 사람들이 볼수있는 페이지
			%>		
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href="#" class= "dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expaned="false">회원관리<span class="caret"></span></a>
					<ul class = "dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%		
				}
			
			%>
			
		</div>
		
	</nav>
	<div class ="container">
		<div class ="row">
				<table class ="table table-striped" style = "text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11,13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>					
						<tr>
							<td>내용</td>	 <!-- replace ALl을 사용해 특수문자 처리  -->
							<td colspan="2" style="min-height: 200px; text-align: left"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID != null && userID.equals(bbs.getUserID())){	// 글작성자가 본인일시 수정과 삭제 버튼이 보이도록 한다.
				%>		
					<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('글을 삭제하시겠습니까?')"href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
				<%		
					}
				%>
		</div>
	</div>
	
	
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>