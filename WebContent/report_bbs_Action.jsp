<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="report.ReportDAO" %>
<%@ page import="bbs.BbsDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="report" class="report.Report" scope="page" />
<jsp:setProperty name="report" property="report_Title" />
<jsp:setProperty name="report" property="report_Content" />
<%
	String bbs_Type = null;
	int bbs_Type_ID = 0;
	if (request.getParameter("bbsID") != null) {
		bbs_Type_ID = Integer.parseInt(request.getParameter("bbsID"));
		bbs_Type = "bbs";
	}
	
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null)
		out.print("1");
	else if(report.getReport_Title() == null)
		out.print("2");
	else if(report.getReport_Content() == null)
		out.print("3");
	else {
		ReportDAO reportDAO = new ReportDAO();
		int check = reportDAO.reportCheck(userID, bbs_Type, bbs_Type_ID);
		if(check == 1) {
			out.print("4");
		} else {
			int result = reportDAO.report_write(userID, bbs_Type, bbs_Type_ID, report.getReport_Content(), report.getReport_Title());
			if(result == -1) {
				out.print("5");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				bbsDAO.reportNext(bbs_Type_ID);
				out.print("0");
			}
		}
		
	}
%>