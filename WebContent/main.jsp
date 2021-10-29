<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dbbs.DBbsDAO"%>
<%@ page import="dbbs.DBbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="image/main_slide_1.png">
				</div>
				<div class="item">
					<img src="image/main_slide_2.png">
				</div>
				<div class="item">
					<img src="image/main_slide_3.png">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<div class="container" style = "padding: 20px 0px 0px 0px;">
	<div class="jumbotron">
		<div class="row">
			<h2>인기 토론 게시글&nbsp;<img src="image/hot_main_icon.png"></h2>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th><h4>번호</h4></th>
						<th style="text-align: left;"><h4>제목</h4></th>
						<th style="text-align: left;"><h4>작성자</h4></th>
						<th><h4>추천</h4></th>
						<th><h4>작성일</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						DBbsDAO dbbsDAO = new DBbsDAO();
						ArrayList<DBbs> list = dbbsDAO.getBestList(pageNumber);
						if(list.size() == 0) {
					%>
						<tr>
							<td colspan="5"><%= "현재 인기 게시글이 없습니다." %></td>
						</tr>
					<%
						} else {
							for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= list.get(i).getDbbsID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="debateview.jsp?dbbsID=<%= list.get(i).getDbbsID() %>"><%= list.get(i).getDbbsTitle() %></a></td>
						<td style="text-align: left; padding: 15px;"><%= list.get(i).getUserID() %></td>
						<td style="padding: 15px;"><%= list.get(i).getDbbsBest() %></td>
						<td style="padding: 15px;"><%= list.get(i).getDbbsDate().substring(0, 4)+ "." + list.get(i).getDbbsDate().substring(5, 7) + "." + list.get(i).getDbbsDate().substring(8, 10) + " " + list.get(i).getDbbsDate().substring(11, 13) + ":" + list.get(i).getDbbsDate().substring(14, 16)%></td>
					</tr>
					<%
							}
						}
					%>
				</tbody>
			</table>
			<div style="width: 48%; float:left;">
			<h2>토론 게시판&nbsp;<img src="image/dbbs_icon.png"></h2>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; table-layout:fixed; word-break:break-all;">
					<%
						ArrayList<DBbs> list_dbbs = dbbsDAO.getList_main(pageNumber);
						int dbbs_count = 0;
						for(int i = 0; i < list_dbbs.size(); i++) {
					%>
					<tr>
						<td>
							<div style="text-align: left;"><a href="debateview.jsp?dbbsID=<%= list_dbbs.get(i).getDbbsID() %>"><%= list_dbbs.get(i).getDbbsTitle() %></a></div>
							<div style="text-align: right;">
							<span><%= list_dbbs.get(i).getUserID() %></span>
							<span style="color: #868789"><%= list_dbbs.get(i).getDbbsDate().substring(0, 4)+ "." + list_dbbs.get(i).getDbbsDate().substring(5, 7) + "." + list_dbbs.get(i).getDbbsDate().substring(8, 10) + " " + list_dbbs.get(i).getDbbsDate().substring(11, 13) + ":" + list_dbbs.get(i).getDbbsDate().substring(14, 16)%></span>
							</div>
						</td>
					</tr>
					<%
							dbbs_count = i;
						}
						if(dbbs_count == 0){
							dbbs_count = 0;	
						} else {
							dbbs_count += 1;
						}
						if(dbbs_count < 5) {
							for(int i = dbbs_count; i < 5; i++) {
					%>
					<tr>
						<td>
							<div>&nbsp;</div>
							<div>&nbsp;</div>
						</td>
					</tr>
					<%
							}
						}
					%>
				</table>
			</div>
			<div style="width:48%; float: right;">
			<h2>자유 게시판&nbsp;<img src="image/bbs_icon.png"></h2>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; table-layout:fixed; word-break:break-all;">
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list_bbs = bbsDAO.getList_main(pageNumber);
						int bbs_count = 0;
						for(int i = 0; i < list_bbs.size(); i++) {
					%>
					<tr>
						<td>
							<div style="text-align: left;"><a href="view.jsp?bbsID=<%= list_bbs.get(i).getBbsID() %>"><%= list_bbs.get(i).getBbsTitle() %></a></div>
							<div style="text-align: right;">
							<span><%= list_bbs.get(i).getUserID() %></span>
							<span style="color: #868789"><%= list_bbs.get(i).getBbsDate().substring(0, 4)+ "." + list_bbs.get(i).getBbsDate().substring(5, 7) + "." + list_bbs.get(i).getBbsDate().substring(8, 10) + " " + list_bbs.get(i).getBbsDate().substring(11, 13) + ":" + list_bbs.get(i).getBbsDate().substring(14, 16)%></span>
							</div>
						</td>
					</tr>
					<%
							bbs_count = i;
						}
						if(bbs_count == 0){
							bbs_count = 0;
						} else {
							bbs_count += 1;
						}
						if(bbs_count < 5) {
							for(int i = bbs_count; i < 5; i++) {
					%>
					<tr>
						<td>
							<div>&nbsp;</div>
							<div>&nbsp;</div>
						</td>
					</tr>
					<%
							}
						}
					%>
				</table>
			</div><div style="clear:both:"></div>
		</div>
	</div>
	</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>