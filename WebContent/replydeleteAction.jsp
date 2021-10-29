<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="reply.Reply"%>
<%@ page import="reply.ReplyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>토론 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int ID = 0;
		if(request.getParameter("ID") != null){
			ID = Integer.parseInt(request.getParameter("ID"));
		}
		if(ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글 입니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Reply reply = new ReplyDAO().getID(ID);
		if(!reply.getUserID().equals(userID)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='view.jsp?bbsID=" + reply.getBbsID() + "'");
			script.println("</script>");			
		} else {
			ReplyDAO replyDAO = new ReplyDAO();
			int result = replyDAO.delete(ID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='view.jsp?bbsID=" + reply.getBbsID() + "'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>