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
<body class="backgroundimage">
<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
		<div class="row">
			<form method="post" action="debatewriteAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="text-align: left; padding-left: 20px;"><h2>게시글 요청 작성</h2></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목 (예 : 안락사는 보장되어야 한다?, 국유사업을 민영화해야 한다? 등..)" name="dbbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="요인1&#13;&#10;&#13;&#10;&#13;&#10;요인2&#13;&#10;&#13;&#10;&#13;&#10;요인3&#13;&#10;&#13;&#10;&#13;&#10;...&#13;&#10;&#13;&#10;&#13;&#10;※게시물 요청 후 관리자를 통해 해당 게시물이 승인 될 경우에만 토론게시판에 게시물이 올라감" name="dbbsContent" maxlength="2048" style="resize: none; height: 350px"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" onclick="return confirm('정말로 보내겠습니까?')" style="margin: 0px 4px 4px 0px" class="btn btn-primary pull-right" value="보내기">
				<input type="button" style="margin: 0px 4px 4px 0px" class="btn btn-primary pull-right" onclick="history.back(-1);" value="취소">
			</form>
		</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>