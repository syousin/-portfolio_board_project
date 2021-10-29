<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="aoreply.AOreply"%>
<%@ page import="aoreply.AOreplyDAO"%>
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
		int aoID = 0;
		if(request.getParameter("aoID") != null){
			aoID = Integer.parseInt(request.getParameter("aoID"));
		}
		if(aoID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 작업 입니다')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		AOreply aoreply = new AOreplyDAO().get_aoreply_UserID(aoID);
		if(!aoreply.getUserID().equals(userID)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='debateview.jsp?dbbsID=" + aoreply.getDbbsID() + "'");
			script.println("</script>");			
		} else {
			AOreplyDAO aoreplyDAO = new AOreplyDAO();
			int result = aoreplyDAO.delete(aoID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='debateview.jsp?dbbsID=" + aoreply.getDbbsID() + "'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>