<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>토론 웹사이트</title>
</head>
<style type="text/css">
	.backgroundimage { 
  		background: url(image/mainback.jpg) no-repeat center center fixed; 
		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
		background-size: cover;
	}
</style>
<body class="backgroundimage">
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String admintype = null;
		if (session.getAttribute("admintype") != null) {
			admintype = (String) session.getAttribute("admintype");
		}
		if(admintype == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 할 수 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		ArrayList<User> userDAO = new UserDAO().get_admin_user();
	%>
	<jsp:include page="nav_admin.jsp" flush="false"/>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>