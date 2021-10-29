<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
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
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근할 수 없습니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	User userProfile = new UserDAO().getuserProfile(userID);
	ArrayList<Bbs> mypage_bbs = new BbsDAO().getList_mypage(userID);
	ArrayList<Reply> mypage_reply = new ReplyDAO().getList_reply(userID);
	ArrayList<Reply_re> mypage_reply_re = new Reply_reDAO().getList_reply_re(userID);
%>
<body class="backgroundimage">
	<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
			<div class="row">
			<h2>마이 페이지</h2>
			<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tbody>
					<tr>
						<td>
							<div style="text-align: left">
								<br>
								<h2><%= userProfile.getUserID() %></h2>
								<br>
							</div>
							<div>
							<table class="table table-striped" style="text-align: left;">
								<tr>
									<td>
										<h5>이름</h5>
									</td>
									<td>
										<%= userProfile.getUserName() %>
									</td>
								</tr>
								<tr>
									<td>
										<h5>성별</h5>
									</td>
									<td>
										<%= userProfile.getUserGender() %>
									</td>
								</tr>
								<tr>
									<td>
										<h5>이메일</h5>
									</td>
									<td>
										<%= userProfile.getUserEmail() %>
									</td>
								</tr>
								<tr>
									<td>
										<h5>남깃말</h5>
									</td>
									<td>
										<%= userProfile.getProfile_Content() %>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;">
										<br>
										<a href="mypage_update.jsp?userID=<%= userProfile.getUserID() %>"><input type="button" class="btn btn-info" value="회원 정보 수정"></a>
									</td>
								</tr>
							</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			<h2>작성한 게시글</h2>
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
						for(int i = 0; i < mypage_bbs.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= mypage_bbs.get(i).getBbsID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="view.jsp?bbsID=<%= mypage_bbs.get(i).getBbsID()%>"><%= mypage_bbs.get(i).getBbsTitle() %></a></td>
						<td style="text-align: left; padding: 15px;"><%= mypage_bbs.get(i).getUserID() %></td>
						<td style="padding: 15px;"><%= mypage_bbs.get(i).getBbsDate().substring(0, 4)+ "." + mypage_bbs.get(i).getBbsDate().substring(5, 7) + "." + mypage_bbs.get(i).getBbsDate().substring(8, 10) + " " + mypage_bbs.get(i).getBbsDate().substring(11, 13) + ":" + mypage_bbs.get(i).getBbsDate().substring(14, 16) %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<br>
			<h2>작성한 댓글</h2>
			<br>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="width: 10%;"><h4>작성자</h4></th>
						<th style="text-align: left; width: 70%;"><h4>내용</h4></th>
						<th style="width: 20%"><h4>작성일</h4></th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < mypage_reply.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= mypage_reply.get(i).getUserID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="view.jsp?bbsID=<%= mypage_reply.get(i).getBbsID()%>"><%= mypage_reply.get(i).getReply() %></a></td>
						<td style="padding: 15px;"><%=  mypage_reply.get(i).getDate().substring(0, 4)+ "." + mypage_reply.get(i).getDate().substring(5, 7) + "." +  mypage_reply.get(i).getDate().substring(8, 10) + " " +  mypage_reply.get(i).getDate().substring(11, 13) + ":" +  mypage_reply.get(i).getDate().substring(14, 16) %></td>
					</tr>
					<%
						}
						for(int i = 0; i < mypage_reply_re.size(); i++) {
					%>
					<tr>
						<td style="padding: 15px;"><%= mypage_reply_re.get(i).getUserID() %></td>
						<td style="text-align: left; padding: 15px;"><a href="view.jsp?bbsID=<%= mypage_reply_re.get(i).getBbsID()%>"><%= mypage_reply_re.get(i).getReply_re() %></a></td>
						<td style="padding: 15px;"><%= mypage_reply_re.get(i).getDate().substring(0, 4)+ "." + mypage_reply_re.get(i).getDate().substring(5, 7) + "." +  mypage_reply_re.get(i).getDate().substring(8, 10) + " " +  mypage_reply_re.get(i).getDate().substring(11, 13) + ":" + mypage_reply_re.get(i).getDate().substring(14, 16) %></td>
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