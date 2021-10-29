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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
<jsp:include page="nav.jsp" flush="false"/>
<div class="container">
	<div class="jumbotron">
		<div class="row">
		<h2>토론 게시판</h2>
		<h4 style="color: #868789;">하나의 논제를 가지고 다양한 토론을 나누는 게시판</h4>
		<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="width: 10%"><h4>번호</h4></th>
						<th style="text-align: left; width: 50%;"><h4>제목</h4></th>
						<th style="text-align: left; width: 10%;"><h4>작성자</h4></th>
						<th style="width: 10%"><h4>추천</h4></th>
						<th style="width: 20%"><h4>작성일</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						DBbsDAO dbbsDAO = new DBbsDAO();
						ArrayList<DBbs> list = dbbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= list.get(i).getDbbsID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="debateview.jsp?dbbsID=<%= list.get(i).getDbbsID() %>">
							<%
								if(list.get(i).getDbbsBest() >= 10) {
							%>
								<span><img src="image/hot.png"></span>
							<%
								}
							%>
							<%= list.get(i).getDbbsTitle() %>
						</a></td>
						<td style="text-align: left; padding: 15px;"><%= list.get(i).getUserID() %></td>
						<td style="padding: 15px;"><%= list.get(i).getDbbsBest() %></td>
						<td style="padding: 15px;"><%= list.get(i).getDbbsDate().substring(0, 4)+ "." + list.get(i).getDbbsDate().substring(5, 7) + "." + list.get(i).getDbbsDate().substring(8, 10) + " " + list.get(i).getDbbsDate().substring(11, 13) + ":" + list.get(i).getDbbsDate().substring(14, 16) %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div style="text-align: right">
			<%
				if(pageNumber != 1) {
			%>
				<a href="debatebbs.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success">이전</a>
			<%
				} if(dbbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="debatebbs.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success">다음</a>
			<%
				}
			%>
			</div>
			<div>
				<a href="debatewrite.jsp" class="btn btn-primary pull-right" style="margin: 10px 0px 0px 0px">글작성</a>
			</div>
		</div>
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>