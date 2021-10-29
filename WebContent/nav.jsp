<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<title>Insert title here</title>
</head>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String admintype = null;
		if (session.getAttribute("admintype") != null) {
			admintype = (String) session.getAttribute("admintype");
		}
	%>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Debate</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">공지사항</a></li>
				<li><a href="debatebbs.jsp">토론 게시판</a></li>
				<li><a href="bbs.jsp">자유 게시판</a></li>
				<li><a href="main.jsp">고객센터</a></li>
			</ul>
			<%
				if (userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<%
					if(admintype != null){
				%>
					<li><a href="admin_main.jsp">관리자 페이지</a></li>
				<%
					}
				%>
					<li><a href="mypage.jsp">마이 페이지</a></li>
					<li><a href="logoutAction.jsp">로그아웃</a></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
</body>
</html>