<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="reply.Reply"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="reply_re.Reply_re"%>
<%@ page import="reply_re.Reply_reDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
<jsp:include page="nav.jsp" flush="false"/>
<div class="container">
	<div class="jumbotron">
		<div class="row">
		<h2>자유 게시판</h2>
		<h4 style="color: #868789;">정해진 주제없이 자유롭게 이야기를 나누는 게시판</h4>
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
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= list.get(i).getBbsID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td style="text-align: left; padding: 15px;"><%= list.get(i).getUserID() %></td>
						<td style="padding: 15px"><%=list.get(i).getBbsDate().substring(0, 4)+ "." + list.get(i).getBbsDate().substring(5, 7) + "." + list.get(i).getBbsDate().substring(8, 10) + " " + list.get(i).getBbsDate().substring(11, 13) + ":" + list.get(i).getBbsDate().substring(14, 16)%></td>
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
				<a href="bbs.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success">다음</a>
			<%
				}
			%>
			</div>
			<div>
				<a href="write.jsp" class="btn btn-primary pull-right" style="margin: 10px 0px 0px 0px">글작성</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>