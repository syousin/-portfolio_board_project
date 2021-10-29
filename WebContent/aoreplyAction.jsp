<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="aoreply.AOreplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="aoreply" class="aoreply.AOreply" scope="page" />
<jsp:setProperty name="aoreply" property="aoreply_ao" />
<jsp:setProperty name="aoreply" property="aoreply_Title" />
<jsp:setProperty name="aoreply" property="aoreply_Content" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<title>토론 웹사이트</title>
</head>
<body>
	<%
		int dbbsID = Integer.parseInt(request.getParameter("dbbsID"));
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
			if (aoreply.getAoreply_Title() == null || aoreply.getAoreply_Content() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					AOreplyDAO aoreplyDAO = new AOreplyDAO();
					int result = aoreplyDAO.write(dbbsID, userID, aoreply.getAoreply_ao(), aoreply.getAoreply_Title(), aoreply.getAoreply_Content());
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'debateview.jsp?dbbsID=" + dbbsID + "'");
						script.println("</script>");
					}
				}	
		}
	%>
</body>
</html>