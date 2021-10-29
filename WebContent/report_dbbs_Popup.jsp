<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>신고</title>
</head>
<script>
function report() {
	var report_data = $('form[name=report_form]').serialize(); 
	$.ajax({
    	type : "POST",
    	url : "report_dbbs_Action.jsp?dbbsID=" + <%= Integer.parseInt(request.getParameter("dbbsID"))%>,
    	data : report_data,
    	dataType : "text",
    	error : function(){
    		alert("에러 발생");
    	},
    	success : function(data){
   	 		if(data == 0){
   	 			alert("신고 접수가 완료 되었습니다.")
   	 			window.close();
   	 		} else if(data == 1) {
   	 			alert("로그인을 하세요");
   	 		} else if(data == 2)
   	 			alert("선택해주세요");
   	 		  else if(data == 3)
   	 			alert("내용을 입력해 주세요");
   	 		  else
   	 			alert("오류가 발생했습니다");
	    }
    });
}

$(function(){
	$("#close").click(function(){
	   	window.close();
	});
});
</script>
<body>
	<form name="report_form">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 100%">
			<tr>
				<td>
					<h2>신고</h2>
				</td>
			</tr>
			<tr>
				<td>
					<div class="container">
						<select class="form-control" name="report_Title">
		  					<option>부적절한 언어 사용</option>
	  						<option>부적절한 주제</option>
	  						<option>부적절한 내용</option>
	  						<option>기타</option>
						</select>
					</div>
					<div class="container">
						<input type="text" class="form-control" placeholder="자세한 내용을 입력해 주세요." style="margin: 10px 0px 10px 0px;" maxlength="200" name="report_Content">
					</div>
					<div>
						<input type="button" style="margin: 0px 1px 0px 0px" class="btn btn-success" value="확인" onclick="report()">
						<input type="button" style="margin: 0px 0px 0px 1px" class="btn btn-info" value="닫기" id="close">
					</div>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>