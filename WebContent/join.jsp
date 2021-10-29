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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
	function IDChecked() {
		var userID = $('input[name=userID]').val(); 
		$.ajax({
            type : "GET",
            url : "IDoverlapAction.jsp?userID=" + userID,
            dataType : "text",
            error : function(){
            	$('#IDCheckN').html('오류가 발생했습니다.');
            },
            success : function(data){
            	if(data == 1) {
            		$('#IDCheckN').html('아이디를 입력해주세요.');
            		$('#IDCheckY').html('');
            	} else if(data == 2) {
            		$('#IDCheckN').html('아이디는 4자 이상입니다.');
            		$('#IDCheckY').html('');
            	} else if(data == 3){
            		$('#IDCheckN').html('이미 존재하는 아이디 입니다.');
            		$('#IDCheckY').html('');
            	} else {
            		$('#IDCheckN').html('');
            		$('#IDCheckY').html('사용가능한 아이디 입니다.');
            	}
            }             
        });
	}
	
	function join() {
		var joindata = $('form[name=join_form]').serialize(); 
		$.ajax({
            type : "POST",
            url : "joinAction.jsp",
            data : joindata,
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
            		alert("아이디는 4자 이상 입니다.");
            	} else if(data == 5){
            		alert("이미 존재하는 아이디 입니다.");
            	} else if(data == 6){
            		alert("회원가입을 축하드립니다.");
            		location.href = 'main.jsp';
            	} else {
            		alert("오류가 발생 했습니다.");
            	}
            }
        });
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
		<form name="join_form">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 가입</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td>
							<input class="form-control" type="text" style="IME-MODE: disabled" placeholder="아이디를 입력해주세요." name="userID" maxLength="20" onkeyup="IDChecked()">
							<h5 style="color: red; text-align: left;" id="IDCheckN">아이디를 입력해주세요.</h5>
							<h5 style="color: blue; text-align: left;" id="IDCheckY"></h5>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2">
							<input class="form-control" type="password" placeholder="비밀먼호를 입력해주세요." name="userPassword" maxLength="20" onkeyup="passwordCheck()">
							<h5 style="color: red; text-align: left;" id="passwordCheckN">비밀번호를 입력해주세요.</h5>
							<h5 style="color: blue; text-align: left;" id="passwordCheckY"></h5>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
						<td colspan="2">
							<input class="form-control" type="password" placeholder="비밀번호 확인을 입력해주세요." name="userPasswordok" maxLength="20" onkeyup="passwordCheck()">
							<h5 style="color: red; text-align: left;" id="passwordCheckokN">비밀번호 확인을 입력해주세요.</h5>
							<h5 style="color: blue; text-align: left;" id="passwordCheckokY"></h5>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2">
							<input class="form-control" type="text" style="IME-MODE: active" placeholder="이름을 입력해주세요." name="userName" maxLength="20">
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="userGender" autocomplete="off" value="여자">여자
								</label>
							</div>
						</td>	
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2">
							<input type="email" class="form-control" placeholder="이메일을 입력해주세요." name="userEmail" maxlength="50">
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<input type="button" class="btn btn-info pull-right" value="확인" onclick="join()">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	</div>
</body>
</html>