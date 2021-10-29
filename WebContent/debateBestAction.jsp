<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbbs.DBbsDAO" %>
<%@ page import="recommendCheck.RecommendCheckDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int dbbsID = Integer.parseInt(request.getParameter("dbbsID"));
	DBbsDAO dbbsDAO = new DBbsDAO();
	RecommendCheckDAO recommendCheckDAO = new RecommendCheckDAO();
	int overlap = recommendCheckDAO.BestCheck(userID, dbbsID);
	int data = 0;
	if(userID == null)
		data = 1;
	else if(overlap == 1)
		data = 2;
	else if(overlap == 0){
		recommendCheckDAO.recommendBest(userID, dbbsID);
		dbbsDAO.BestNext(dbbsID);
		data = 3;
	} else {
		data = 4;
	}
	out.print(data);
%>