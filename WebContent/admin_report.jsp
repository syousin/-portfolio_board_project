<%@ page contentType="text/html; charset=UTF-8"
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
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>토론 웹사이트</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
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
		<h2>신고 접수 내역</h2>
		<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="width: 10%"><h4>번호</h4></th>
						<th style="text-align: left; width: 50%;"><h4>제목</h4></th>
						<th style="text-align: left; width: 10%;"><h4>작성자</h4></th>
						<th style="width: 20%"><h4>작성일</h4></th>
						<th style="width: 10%"><h4>신고횟수</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList_report();
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= list.get(i).getBbsID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="report_bbs_view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td style="text-align: left; padding: 15px;"><%= list.get(i).getUserID() %></td>
						<td style="padding: 15px"><%=list.get(i).getBbsDate().substring(0, 4)+ "." + list.get(i).getBbsDate().substring(5, 7) + "." + list.get(i).getBbsDate().substring(8, 10) + " " + list.get(i).getBbsDate().substring(11, 13) + ":" + list.get(i).getBbsDate().substring(14, 16)%></td>
						<td style="padding: 15px"><%=list.get(i).getReportCount() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>