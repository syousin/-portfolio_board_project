<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
	window.onload = function(){
		var userPassword = $('input[name=userPassword]').val();
		var userPasswordlength = userPassword.toString().length;
		var userPasswordok = $('input[name=userPasswordok]').val();
		var userPasswordoklength = userPasswordok.toString().length;
		
		if(userPasswordlength < 8) {
			$('#passwordCheckN').html('비밀번호는 8자리 이상 입니다.');
			$('#passwordCheckY').html('');
		} else {
			$('#passwordCheckN').html('');
			$('#passwordCheckY').html('사용가능한 비밀번호 입니다.');
		}
		
		if(userPasswordoklength < 8) {
			$('#passwordCheckokN').html('비밀번호는 8자리 이상 입니다.');
			$('#passwordCheckokY').html('');
		} else {
			$('#passwordCheckokN').html('');
			$('#passwordCheckokY').html('비밀번호가 서로 일치 합니다.');
		}
	}

	function passwordCheck() {
		var userPassword = $('input[name=userPassword]').val();
		var userPasswordlength = userPassword.toString().length;
		var userPasswordok = $('input[name=userPasswordok]').val();
		var userPasswordoklength = userPasswordok.toString().length;
		
		if(userPasswordlength == 0) {
			$('#passwordCheckN').html('비밀번호를 입력해주세요.');
			$('#passwordCheckY').html('');
		} else if(userPasswordlength < 8) {
			$('#passwordCheckN').html('비밀번호는 8자리 이상 입니다.');
			$('#passwordCheckY').html('');
		} else {
			$('#passwordCheckN').html('');
			$('#passwordCheckY').html('사용가능한 비밀번호 입니다.');
		}
		
		if(userPasswordoklength == 0) {
			$('#passwordCheckokN').html('비밀번호 확인을 입력해주세요.');
			$('#passwordCheckokY').html('');
		} else if(userPasswordlength == 0 && userPasswordoklength > 0) {
			$('#passwordCheckokN').html('비밀번호를 먼저 입력해주세요.');
			$('#passwordCheckokY').html('');
		} else if(userPasswordoklength < 8) {
			$('#passwordCheckokN').html('비밀번호는 8자리 이상 입니다.');
			$('#passwordCheckokY').html('');
		} else if(userPasswordok != userPassword) {
			$('#passwordCheckokN').html('비밀번호가 서로 일치하지 않습니다.');
			$('#passwordCheckokY').html('');
		} else if(userPasswordok == userPassword) {
			$('#passwordCheckokN').html('');
			$('#passwordCheckokY').html('비밀번호가 서로 일치 합니다.');
		}
	}
	
	function mypage_updateAction() {
		var updatedata = $('form[name=mypage_update_form]').serialize();
		var form_userID = $('#form_userID').text();
		$.ajax({
            type : "POST",
            url : "mypage_updateAction.jsp?userID=" + form_userID,
            data : updatedata,
            dataType : "text",
            error : function(){
            	alert("에러 발생");
            },
            success : function(data){
            	if(data == 1) {
            		alert("입력이 안 된 사항이 있습니다.");
            	} else if(data == 2){
            		alert("비밀번호는 8자 이상입니다.");
            	} else if(data == 3){
            		alert("비밀번호를 확인해주세요.");
            	} else if(data == 4){
            		alert("오류가 발생했습니다.");
            	} else if(data == 5){
            		alert("회원 정보 수정에 성공하셨습니다.");
            		location.href = 'mypage.jsp?userID=' + form_userID;
            	} else {
            		alert("오류가 발생 했습니다.");
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
	
	String IDoverlap = request.getParameter("userID");
	
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근할 수 없습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	} else if(!userID.equals(IDoverlap)){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근할 수 없습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	User userProfile = new UserDAO().getuserProfile(userID);
	
%>
<body class="backgroundimage">
	<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
			<div class="row">
			<form name="mypage_update_form">
			<h2>회원 정보 수정</h2>
			<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tbody>
					<tr>
						<td>
							<div style="text-align: left" id="form_userID">
								<br>
								<h2><%= userProfile.getUserID() %></h2>
								<br>
							</div>
							<div>
							<table class="table table-striped" style="text-align: left;">
								<tr>
									<td style="width: 30%">
										<h5>이름</h5>
									</td>
									<td>
										<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%= userProfile.getUserName() %>">
									</td>
								</tr>
								<tr>
									<td>
										<h5>비밀번호</h5>
									</td>
									<td>
										<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" value="<%= userProfile.getUserPassword()%>" onkeyup="passwordCheck()">
										<h5 style="color: red; text-align: left;" id="passwordCheckN"></h5>
										<h5 style="color: blue; text-align: left;" id="passwordCheckY"></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5>비밀먼호 확인</h5>
									</td>
									<td>
										<input type="password" class="form-control" placeholder="비밀번호 확인" name="userPasswordok" maxlength="20" value="<%= userProfile.getUserPassword()%>" onkeyup="passwordCheck()">
										<h5 style="color: red; text-align: left;" id="passwordCheckokN"></h5>
										<h5 style="color: blue; text-align: left;" id="passwordCheckokY"></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5>성별</h5>
									</td>
									<td>
										<div class="btn-group" data-toggle="buttons">
										<%
											if(userProfile.getUserGender().equals("남자")) {
										%>
											<label class="btn btn-primary active">
												<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
											</label>
											<label class="btn btn-primary">
												<input type="radio" name="userGender" autocomplete="off" value="여자">여자
											</label>
										</div>
										<%
											} else { 
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
									</td>
								</tr>
								<tr>
									<td>
										<h5>이메일</h5>
									</td>
									<td>
										<input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" value="<%= userProfile.getUserEmail() %>">
									</td>
								</tr>
								<tr>
									<td>
										<h5>남깃말</h5>
									</td>
									<td>
										<textarea class="form-control" style="resize: none; height: 100px" name="profile_Content" placeholder="내용을 입력해 주세요." maxlength="2048"><%= userProfile.getProfile_Content() %></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;">
										<br>
										<input type="button" class="btn btn-info" value="확인" onclick="mypage_updateAction();">
									</td>
								</tr>
							</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			</div>
		</div>
	</div>
</body>
</html>