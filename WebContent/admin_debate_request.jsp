<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dbbs.DBbsDAO"%>
<%@ page import="dbbs.DBbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>토론 웹사이트</title>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<h2>요청 게시글</h2>
			<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="width: 10%"><h4>번호</h4></th>
						<th style="text-align: left; width: 60%;"><h4>제목</h4></th>
						<th style="text-align: left; width: 10%;"><h4>작성자</h4></th>
						<th style="width: 20%"><h4>작성일</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						DBbsDAO dbbsDAO = new DBbsDAO();
						ArrayList<DBbs> list = dbbsDAO.admin_getList(pageNumber);
						if(list.size() == 0){
					%>
								<tr>
									<td colspan="4" style="padding: 15px;"><%= "현재 요청한 게시글이 없습니다." %></td>
								</tr>
					<%
						} else {
							for(int i = 0; i < list.size(); i++) {
					%>
								<tr>
									<td style="padding: 15px;"><%= list.get(i).getDbbsID() %></td>
									<td style="text-align: left; padding: 15px;"><a href="admin_debate_requestveiw.jsp?dbbsID=<%= list.get(i).getDbbsID() %>"><%= list.get(i).getDbbsTitle() %></a></td>
									<td style="text-align: left; padding: 15px;"><%= list.get(i).getUserID() %></td>
									<td style="padding: 15px;"><%= list.get(i).getDbbsDate().substring(0, 4)+ "." + list.get(i).getDbbsDate().substring(5, 7) + "." + list.get(i).getDbbsDate().substring(8, 10) + " " + list.get(i).getDbbsDate().substring(11, 13) + ":" + list.get(i).getDbbsDate().substring(14, 16) %></td>
								</tr>
					<%
							}
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="debatedbbs.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success btn-arraw-Left">이전</a>
			<%
				} if(dbbsDAO.admin_nextPage(pageNumber + 1)){
			%>
				<a href="debatebbs.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success btn-arraw-Left">다음</a>
			<%
				}
			%>
		</div>
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>