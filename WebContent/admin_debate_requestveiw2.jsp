<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dbbs.DBbs"%>
<%@ page import="dbbs.DBbsDAO"%>
<%@ page import="java.util.ArrayList"%>
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
		int dbbsID = 0;
		if (request.getParameter("dbbsID") != null) {
			dbbsID = Integer.parseInt(request.getParameter("dbbsID"));
		}
		if (dbbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'debatebbs.jsp'");
			script.println("</script>");
		}
		DBbs dbbs = new DBbsDAO().getDBbs(dbbsID);
	%>
	<jsp:include page="nav_admin.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
		<div class="row">
			<form name = "aoreplymove" method="post">
			<input type="hidden" name = "dbbsID" value="<%= dbbsID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"	style="text-align: left;"><%= "제목 : " + dbbs.getDbbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></th>
						</tr>
						<tr>
							<td colspan="2" style="width: 110px; text-align: left; font-weight: bold;"><%= "작성자 : " + dbbs.getUserID() %></td>
						</tr>
						<tr>
							<td colspan="2" style="width: 110px; text-align: left; font-weight: bold;"><%= "작성일 : " + dbbs.getDbbsDate().substring(0, 4)+ "." + dbbs.getDbbsDate().substring(5, 7) + "." + dbbs.getDbbsDate().substring(8, 10) + " " + dbbs.getDbbsDate().substring(11, 13) + ":" + dbbs.getDbbsDate().substring(14, 16) %></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" style="min-height: 200px; text-align: left; border: 1px solid #dddddd"><%= dbbs.getDbbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
						</tr>
					</tbody>
				</table>
			</form>
				<a style="margin: 0px 2px 2px 0px" onclick="return confirm('정말로 올리시겠습니까?')" href="admin_debate_requestAction.jsp?dbbsID=<%= dbbsID %>" class="btn btn-primary  pull-right">올리기</a>
				<a style="margin: 0px 2px 2px 0px" onclick="return confirm('정말로 삭제하겠습니까?')" href="admin_debate_requestdeleteAction.jsp?dbbsID=<%= dbbsID %>" class="btn btn-primary  pull-right">삭제</a>
				<a href="admin_debate_request.jsp" class="btn btn-primary">목록</a>
		</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>