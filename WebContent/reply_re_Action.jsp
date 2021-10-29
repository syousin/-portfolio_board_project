<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply_re.Reply_reDAO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<title>토론 웹사이트</title>
</head>
<body>
	<%
		int replyNum = Integer.parseInt(request.getParameter("replyNum"));
		String reply_re = request.getParameter("reply_re" + replyNum);
		int replyID = Integer.parseInt(request.getParameter("replyID" + replyNum));
		int bbsID = Integer.parseInt(request.getParameter("reply_re_bbsID"));

		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if (reply_re == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				Reply_reDAO reply_reDAO = new Reply_reDAO();
				int result = reply_reDAO.write(bbsID, replyID, userID, reply_re);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					ReplyDAO replyDAO = new ReplyDAO();
					replyDAO.setreCount(replyID);
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
					script.println("</script>");
				}
			}
		}
	%>
</body>