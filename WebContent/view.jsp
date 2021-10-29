<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
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
<body class="backgroundimage">
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		Reply reply = new ReplyDAO().getBbs(bbsID);
		if (bbs.getBbsAvailable() == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제된 글 입니다..')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		ReplyDAO replyDAO = new ReplyDAO();
		Reply_reDAO reply_reDAO = new Reply_reDAO();
		int reply_count =  replyDAO.reply_count(bbsID);
		int reply_re_count = reply_reDAO.reply_re_count(bbsID);
		ArrayList<Reply> list = replyDAO.getList(bbsID);
	%>
<script>
	$(document).ready(function (){
		$(".reply_re").click(function () {
			var tr = $(this);
			var td = tr.children();
			var num = td.eq(0).text() - 1;
			var status = $(".reply_re_word" + num).css("display");
			if (status == "none") {
	  			$(".reply_re_word" + num).css("display", "");
  			} else {
	  			$(".reply_re_word" + num).css("display", "none");
  			}
		});
	});
	
	function reply_move(){
		document.reply_form.action = "replyAction.jsp?bbsID=" + <%= bbsID %>;
		document.reply_form.submit();
	}
	
	function reply_re_move(index){
		document.reply_form.action = "reply_re_Action.jsp?replyNum=" + index;
		document.reply_form.submit();
	}
	
	function report(){
		window.open("report_bbs_Popup.jsp?bbsID=" + <%= bbsID%>, "report_popup", "width=600px, height=300px, resizable=no, location=no, top=300px, left=300px;");
	};
</script>
	<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
		<div class="row">
			<form name="reply_form" method="post">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tbody>
					<tr>
						<td colspan="3" style="text-align: left;">
							<div style="margin: 0px 10px 0px 10px;">
								<h3><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></h3>
							</div>
							<div style="margin: 0px 10px 0px 10px;">
								<%= bbs.getUserID() %>
							</div>
							<div style="color: #868789; margin: 0px 10px 0px 10px;">
								<%= bbs.getBbsDate().substring(0, 4)+ "." + bbs.getBbsDate().substring(5, 7) + "." + bbs.getBbsDate().substring(8, 10) + " " + bbs.getBbsDate().substring(11, 13) + ":" + bbs.getBbsDate().substring(14, 16)%>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="text-align: left;">
							<div style="margin: 0px 10px 0px 10px;">
								<%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %>
							</div>
							<div style="margin: 30px 0px 0px 0px; text-align: center;">
								<input type='button' id="ReportButton" class="btn btn-danger" value="신고" onclick="report();">
							</div>
						</td>
					</tr>
					<tr style="font-weight: bold; text-align: left; background-color: #fefefe">
						<td colspan="3">
							 <div style="margin: 0px 0px 0px 10px;">
								<input type="hidden" name = "reply_re_bbsID" value="<%= bbsID%>">전체 댓글 [<%= reply_count + reply_re_count%>]
							</div>
						</td>
					</tr>
					<%
						if(list.size() == 0){
					%>
					<tr>
						<td colspan="3">현재 댓글이 없습니다.</td>
					</tr>
					<%
						} else {
							for(int i = 0; i < list.size(); i++) {
								String reply_word_class = "reply_re_word";
								String reply_ID = "replyID";
								String reply_re_name = "reply_re";
								reply_word_class = reply_word_class + i;
								reply_ID = reply_ID + i;
								reply_re_name = reply_re_name + i;
								ArrayList<Reply_re> list_re = reply_reDAO.getList(bbsID, list.get(i).getID());
								if(list.get(i).getReplyAvailable() == 1){
					%>
					<tr class="reply_re">
						<td style="width: 50px; vertical-align: middle; display: none;"><%= i + 1%></td>
						<td colspan="2">
							<div style="text-align: left;">
								<div style="margin: 0px 0px 0px 10px; font-weight: bold;">
									<%= list.get(i).getUserID()%>
								</div>
								<div style="margin: 5px 0px 5px 10px;">
									<%= list.get(i).getReply() %>
								</div>
								<div style="margin: 0px 0px 0px 10px; color: #868789">
									<%= list.get(i).getDate().substring(0, 4) + "." + list.get(i).getDate().substring(5, 7) + "." + list.get(i).getDate().substring(8, 10) + " " + list.get(i).getDate().substring(11, 13) + ":" + list.get(i).getDate().substring(14, 16)%>
								</div>
							</div>
						</td>
						<td style="width: 18px">
								<div style="text-align:right;">
									<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="replydeleteAction.jsp?ID=<%= list.get(i).getID() %>"><img src="image/delete2.png"></a>
								</div>
						</td>
					</tr>
					<%
								} else if(list.get(i).getReplyAvailable() == 0 && list.get(i).getReCount() != 0) {
					%>
								<tr>
									<td colspan="5" style="color: #868789; font-weight: Bold">삭제된 댓글 입니다.</td>
								</tr>
					<%
								}
					%>
					<tr class="<%= reply_word_class%>" style="display: none;" >
						<td colspan="2">
							<input type="hidden" name = "<%= reply_ID%>" value="<%= list.get(i).getID()%>">
							<input type="text" class="form-control" name="<%= reply_re_name%>" placeholder="답글 달기" maxlength="200">
						</td>
						<td style="width: 110px;">
							<input type='button' class="btn btn-info" onClick="reply_re_move(<%= i%>)" value="확인">
						</td>
					</tr>
					<%
								if(list.get(i).getReCount() != 0){
									for(int j = 0; j < list_re.size(); j++){
					%>
					<tr>
						<td style="width: 40px"></td>
						<td>
							<div style="text-align: left;">
								<div style="font-weight: bold;">
									<%= list_re.get(j).getUserID() %>
								</div>
								<div style="margin: 5px 0px 5px 0px;">
									<%= list_re.get(j).getReply_re() %>
								</div>
								<div style="color: #868789">
									<%= list_re.get(j).getDate().substring(0, 4) + "." + list_re.get(j).getDate().substring(5, 7) + "." + list_re.get(j).getDate().substring(8, 10) + " " + list_re.get(j).getDate().substring(11, 13) + ":" + list_re.get(j).getDate().substring(14, 16)%>
								</div>
							</div>
						</td>
						<td style="width: 18px">
							<div style="text-align:right;">
								<img src="image/delete2.png">
							</div>
						</td>
					</tr>
					<%
									}
								}
							}
						}
					%>
					<tr>
						<td colspan="2">
							<input type="text" class="form-control" name="reply" placeholder="댓글 달기" maxlength="200">
						</td>
						<td style="width: 110px;">
							<input type='button' class="btn btn-info" onClick="reply_move()" value="확인">
						</td>
					</tr>
				</tbody>
			</table>
			</form>
				<a href = "bbs.jsp" class="btn btn-primary pull-right" style="margin: 0px 11px 0px 0px">목록</a>
				<%
					if(userID != null && userID.equals(bbs.getUserID())){
				%>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary pull-right" style="margin: 0px 6px 0px 0px">삭제</a>
						<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary pull-right" style="margin: 0px 6px 0px 0px">수정</a>
				<%
					}
				%>
		</div>
		</div>
	</div>
</body>
</html>