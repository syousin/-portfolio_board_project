<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dbbs.DBbs"%>
<%@ page import="dbbs.DBbsDAO"%>
<%@ page import="aoreply.AOreply"%>
<%@ page import="aoreply.AOreplyDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text html; charset=UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/customs.css">
<title>토론 웹사이트</title>
</head>
<style type="text/css">
	.backgroundimage { 
  		background: url(image/mainback.jpg) no-repeat center center fixed; 
		-webkit-background-size: cover;
  		-moz-background-size: cover;
  		-o-background-size: cover;
		background-size: cover;
	}
</style>
<body class="backgroundimage">
	<%
		int dbbsID = 0;
		if (request.getParameter("dbbsID") != null) {
			dbbsID = Integer.parseInt(request.getParameter("dbbsID"));
		}
		if (dbbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'debatebbs.jsp'");
			script.println("</script>");
		}
		DBbs dbbs = new DBbsDAO().getDBbs(dbbsID);
		AOreply aoreply = new AOreplyDAO().getDBbs(dbbsID);
		AOreplyDAO aoreplyDAO = new AOreplyDAO();
		int aoreply_acount = aoreplyDAO.aoreply_count("찬성", dbbsID);
		int aoreply_ocount = aoreplyDAO.aoreply_count("반대", dbbsID);
		ArrayList<AOreply> aolist = aoreplyDAO.getList(dbbsID);
%>
<script>
	function Best() {
		$.ajax({
            type : "GET",
            url : "debateBestAction.jsp?dbbsID=" + <%= dbbsID%>,
            dataType : "text",
            error : function(){
            	alert("오류가 발생했습니다");
            },
            success : function(data){
            	if(data == 1)
            		alert("로그인을 하세요");
            	else if(data == 2)
            		alert("이미 추천했습니다");
            	else if(data == 3){
					<%
            			int Bestvalue = dbbs.getDbbsBest() + 1;
            		%>
            		alert("추천했습니다");
            		$('#BestButton').val('<% out.print("추천 " + Bestvalue);	%>');
            	} else {
            		alert("오류가 발생했습니다");
            	}
            }
        });
	}
	
	function aomove(index){
		if(index == 1){
			document.aoreplymove.action = 'areplyAction.jsp';
		}
		if(index == 0){
			document.aoreplymove.action = 'oreplyAction.jsp';
		}
		document.aoreplymove.submit();
	}
	
	function report(){
		window.open("report_dbbs_Popup.jsp?dbbsID=" + <%= dbbsID%>, "report_popup", "width=600px, height=300px, resizable=no, location=no, top=300px, left=300px;");
	};
</script>
<jsp:include page="nav.jsp" flush="false"/>
	<div class="container">
		<div class="jumbotron">
		<div class="row">
			<form method="post" action="aoreplyAction.jsp">
			<input type="hidden" name = "dbbsID" value="<%= dbbsID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; width: 100%">
					<tbody>
						<tr>
							<td colspan="2" style="width: 110px; text-align: left;">
								<div style="margin: 0px 10px 0px 10px;">
									<h2><%= dbbs.getDbbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></h2>
								</div>
								<div style="margin: 0px 10px 0px 10px;">
									<%= dbbs.getUserID()%>
								</div>
								<div style="color: #868789; margin: 0px 10px 0px 10px;">
									<%= dbbs.getDbbsDate().substring(0, 4)+ "." + dbbs.getDbbsDate().substring(5, 7) + "." + dbbs.getDbbsDate().substring(8, 10) + " " + dbbs.getDbbsDate().substring(11, 13) + ":" + dbbs.getDbbsDate().substring(14, 16) %>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="min-height: 200px; text-align: left; border: 1px solid #dddddd;">
								<div style="margin: 0px 10px 0px 10px;">
									<%= dbbs.getDbbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %>
								</div>
								<div style="margin: 30px 0px 0px 0px; text-align: center;">
									<input type='button' id="BestButton" style="margin: 0px 1px 0px 0px" class="btn btn-info" onClick='Best()' value="<% out.print("추천 " + dbbs.getDbbsBest()); %>">
									<input type='button' id="ReportButton" style="margin: 0px 0px 0px 1px" class="btn btn-danger" value="신고" onclick="report()">
								</div>
							</td>
						</tr>
						<tr style="font-weight: bold; text-align: left; background-color: #fefefe">
							<td colspan="2">
								<span style="margin: 0px 0px 0px 10px;">전체 댓글 [<%= aoreply_acount + aoreply_ocount%>]</span>
								<span style="color: #286bf6;">[찬성 <%= aoreply_acount%>]</span>
								<span style="color: #d9534f;">[반대 <%= aoreply_ocount%>]</span>
							</td>
						</tr>
						<%
							for(int i = 0; i < aolist.size(); i++) {
						%>
						<tr style="text-align: left;">
							<td>
								<div>
									<div style="margin: 0px 0px 0px 10px;">
									<%
										if(aolist.get(i).getAoreply_ao().equals("찬성")) {
									%>
										<h2 style="color: #286bf6;"><%= aolist.get(i).getAoreply_Title() %></h2>
									<%
										} else if(aolist.get(i).getAoreply_ao().equals("반대")) {
									%>
										<h2 style="color: #d9534f;"><%= aolist.get(i).getAoreply_Title() %></h2>
									<%
										}
									%>
									</div>
									<div style="margin: 10px 0px 10px 10px; font-weight: bold;">
										<%= aolist.get(i).getUserID() %>
									</div>
									<div style="margin: 0px 0px 10px 10px;">
										<%= aolist.get(i).getAoreply_Content() %>
									</div>
									<div style="color: #868789; margin: 0px 0px 0px 10px;">
										<%= aolist.get(i).getAoDate().substring(0, 4)+ "." + aolist.get(i).getAoDate().substring(5, 7) + "." + aolist.get(i).getAoDate().substring(8, 10) + " " + aolist.get(i).getAoDate().substring(11, 13) + ":" + aolist.get(i).getAoDate().substring(14, 16)%>
									</div>
								</div>
							</td>
							<td style="width: 18px">
								<div style="text-align:right;">
									<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="aoreplydeleteAction.jsp?aoID=<%= aolist.get(i).getAoID()%>"><img src="image/delete2.png"></a>
								</div>
							</td>
						</tr>
						<%
							}
						%>
						<tr style="text-align: left">
							<td colspan="2">
								<div>
									<div>
										<div>
											<input type="text" class="form-control" style="margin: 0px 0px 10px 0px;" name="aoreply_Title" placeholder="제목을 입력해 주세요." maxlength="200">
										</div>
										<div class="btn-group" data-toggle="buttons">
											<label class="btn btn-primary active">
												<input type="radio" name="aoreply_ao" autocomplete="off" value="찬성" checked>찬성
											</label>
											<label class="btn btn-primary">
												<input type="radio" name="aoreply_ao" autocomplete="off" value="반대">반대
											</label>
										</div>
										<div>
											<textarea class="form-control" style="margin: 10px 0px 10px 0px; resize: none; height: 100px" name="aoreply_Content" placeholder="내용을 입력해 주세요." maxlength="2048"></textarea>
										</div>
										<div style="text-align: right">
											<input type='submit' style="margin: 2px 2px 2px 2px" class="btn btn-info"value="확인">
										</div>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div>
				<a href = "debatebbs.jsp" class="btn btn-primary pull-right" style="margin: 0px 11px 0px 0px">목록</a>
			</div>
		</div>
		</div>
	</div>
</body>
</html>