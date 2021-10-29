<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbbs.DBbs"%>
<%@ page import="dbbs.DBbsDAO" %>
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
	int dbbsID = 0;
	if (request.getParameter("dbbsID") != null) {
		dbbsID = Integer.parseInt(request.getParameter("dbbsID"));
	}
	if (dbbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'admin_debate_request.jsp'");
		script.println("</script>");
	}
	DBbsDAO dbbsDAO = new DBbsDAO();
	int result = dbbsDAO.request(dbbsID);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글 승인이 완료되었습니다.')");
		script.println("location.href = 'admin_debate_request.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>