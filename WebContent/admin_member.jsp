<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>토론 웹사이트</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none !important;
	}
	
	.backgroundimage { 
  		background: url(image/mainback.jpg) no-repeat center center fixed; 
		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
		background-size: cover;
	}
</style>
</head>
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
	%>
	<jsp:include page="nav_admin.jsp" flush="false"/>
<div class="container">
	<div class="jumbotron">
		<div class="row">
		<h2>회원 정보</h2>
		<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th><h4>Number</h4></th>
						<th><h4>ID</h4></th>
						<th><h4>Password</h4></th>
						<th><h4>Name</h4></th>
						<th><h4>Gender</h4></th>
						<th><h4>Email</h4></th>
						<th><h4>grade</h4></th>
						<th><h4>option</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						UserDAO userDAO = new UserDAO();
						ArrayList<User> list = userDAO.getList();
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= list.get(i).getUserNum() %></td>
						<td style="padding: 15px;"><%= list.get(i).getUserID() %></td>
						<td style="padding: 15px;"><%= list.get(i).getUserPassword() %></td>
						<td style="padding: 15px;"><%= list.get(i).getUserName() %></td>
						<td style="padding: 15px;"><%= list.get(i).getUserGender() %></td>
						<td style="padding: 15px;"><%= list.get(i).getUserEmail() %></td>
						<td style="padding: 15px;"><input type="hidden" name = "admintype2" value="<%= list.get(i).getAdmintype()%>">
						<%
							if(list.get(i).getAdmintype().equals("0")) {
						%>
							일반
						<%
							} else {
						%>
							관리자
						<%
							}
						%>
						</td>
						<td style="padding: 15px;">
							<a href="admin_member_mod.jsp?userNum=<%= list.get(i).getUserNum() %>" class="btn btn-primary">수정</a>
							<a onclick="return confirm('삭제하면 다시는 복구할 수 없습니다.')" href="admin_member_deleteAction.jsp?userNum=<%= list.get(i).getUserNum() %>" class="btn btn-primary">삭제</a>
						</td>					
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>