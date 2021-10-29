<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
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
		int userNum = 0;
		if (request.getParameter("userNum") != null) {
			userNum = Integer.parseInt(request.getParameter("userNum"));
		}
		if(admintype == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 할 수 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(userNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효한 계정이 아닙니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		User user = new UserDAO().getuser(userNum);
		
		if(user.getAdmintype().equals(admintype)){
			if(!user.getUserID().equals(userID)){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('다른 관리자 계정은 수정 할 수 없습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
	<jsp:include page="nav_admin.jsp" flush="false"/>
	<div class="container">
		<div class="col-Lg-4"></div>
		<div class="col-Lg-4">
			<div class="jumbotron" style="padding-top: 20px">
				<form method="post" action="admin_member_modAction.jsp?userNum=<%= userNum %>">
					<h3 style="text-align: center">회원 정보 수정</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" value="<%= user.getUserID()%>">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%= user.getUserPassword()%>">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%= user.getUserName()%>">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
						<%
							if(user.getUserGender().equals("남자")){
						%>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자">여자
							</label>
						<%
							} else if(user.getUserGender().equals("여자")){
						%>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="남자">남자
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						<%
							}
						%>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50" value="<%= user.getUserEmail()%>">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="수정하기">
				</form>
			</div>
		</div>
		<div class="col-Lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>