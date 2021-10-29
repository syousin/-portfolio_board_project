<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String userID = request.getParameter("userID");
	UserDAO userDAO = new UserDAO();
	int result = userDAO.IDoverlap(userID);
	int data = 0;
	if(userID.length() == 0)
		data = 1;
	else if(userID.length() <= 3)
		data = 2;
	else if(result == 1)
		data = 3;
	out.print(data);
%>