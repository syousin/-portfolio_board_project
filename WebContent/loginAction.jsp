<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="admintype" />
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		int admintype = userDAO.admin_login(user.getUserID(), user.getAdmintype());
		if (result == 1) {
				if(admintype == 1){
					session.setAttribute("admintype", user.getAdmintype());
				}
				session.setAttribute("userID", user.getUserID());
				out.print("1");
		}
		else if (result == 0) {
			out.print("2");
		}
		else if (result == -1) {
			out.print("3");
		}
		else if (result == -2) {
			out.print("4");
		}
	%>