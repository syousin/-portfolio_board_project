<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script>
	function login() {
		var logindata = $('form[name=login_form]').serialize(); 
		$.ajax({
        	type : "POST",
        	url : "loginAction.jsp",
        	data : logindata,
        	dataType : "text",
        	error : function(){
        		alert("에러 발생");
        	},
        	success : function(data){
       	 		if(data == 1) {
       	 			location.href = 'main.jsp';
        		} else if(data == 2){
        			alert("비밀번호가 틀립니다.");
        		} else if(data == 3){
        			alert("존재하지 않는 아이디입니다.");
        		} else if(data == 4){
        			alert("데이터베이스 오류가 발생했습니다.");
        		} else {
        			alert("오류가 발생 했습니다." + data);
        		}
    	    }
	    });
	}
</script>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('현재 로그인된 상태 입니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
%>
<body class="backgroundimage">
	<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
	<div class="jumbotron" style="width: 75%; margin: auto;">
		<form name="login_form">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2"><h4>로그인</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td>
							<input class="form-control" type="text" name="userID" maxLength="20">
						</td>
					</tr>
					<tr style="background-color: #f9f9f9;">
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2">
							<input class="form-control" type="password" name="userPassword" maxLength="20">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="hidden" name="admintype" value="1">
							<input type="button" class="btn btn-info" value="로그인" onclick="login()">
							<input type="button" class="btn btn-danger" onclick="history.back();" value="돌아가기">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>