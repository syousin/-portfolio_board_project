<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="profile_Content" />

<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	String form_userID = request.getParameter("userID");
	String userPasswordok = request.getParameter("userPasswordok");
	
	if(!form_userID.equals(userID)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근할 수 없습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	if (user.getUserName() == null || user.getUserPassword() == null || user.getUserGender() == null || user.getUserEmail() == null || user.getProfile_Content() == null) {
			out.print("1");
	} else if (user.getUserPassword().length() < 8){
			out.print("2");
	} else if (!userPasswordok.equals(user.getUserPassword()) ){
			out.print("3");
	} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.mypage_update(userID, user.getUserName(), user.getUserPassword(), user.getUserGender(), user.getUserEmail(), user.getProfile_Content());
			if (result == -1) {
				out.print("4");
			} else {
				out.print("5");
			}
	}
%>