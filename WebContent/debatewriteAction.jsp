<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbbs.DBbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dbbs" class="dbbs.DBbs" scope="page" />
<jsp:setProperty name="dbbs" property="dbbsTitle" />
<jsp:setProperty name="dbbs" property="dbbsContent" />
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else if (dbbs.getDbbsTitle() == null || dbbs.getDbbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
		}  else {
				DBbsDAO dbbsDAO = new DBbsDAO();
				int result = dbbsDAO.write(dbbs.getDbbsTitle(), userID, dbbs.getDbbsContent());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시글 요청이 완료되었습니다.')");
					script.println("location.href = 'debatebbs.jsp'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>