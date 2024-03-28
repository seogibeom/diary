<%@page import="org.mariadb.jdbc.export.Prepare"%>
<%@ page import="org.apache.catalina.connector.Response"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<!-- ======================================== 로그인 인증 ========================================== -->
<%
	// 로그인 인증 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	// 디비이름.테이블.
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);	
	rs1 = stmt1.executeQuery();
	String mySession = null; 
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("OFF")) {
		
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요","utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기

		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
%>
<!-- ======================================== 로그인 인증 ========================================== -->
<!-- ======================================== 페이징 ========================================== -->
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	/*
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	*/
	
	int startRow = (currentPage-1)*rowPerPage;
	
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	
	String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+searchWord+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	rs2 = stmt2.executeQuery();
%>
<!-- ======================================== 페이징 ========================================== -->
<!-- ======================================== 목록 ========================================== -->
<%
	
	String sql3 = "select count(*) cnt from diary where title like ?";
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setString(1, "%"+searchWord+"%");
	rs3 = stmt3.executeQuery();
	int totalRow = 0;
	if(rs3.next()){
		totalRow = rs3.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	
%>
<!-- ======================================== 목록 ========================================== -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>
	.none {text-decoration: none;}
	.inner-div {margin: auto;}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<body style="background-image: url(/board/img/gaga.png;">

<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		
	<span style="color: green;" align="center"><h2>D I A R Y - L I S T</h2></span>
	
			<div>
				<span class="badge bg-success-subtle" style="color: green">
					<%=currentPage%>페이지
				</span>
			</div>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="p-1 mb-1 bg-success text-white">날짜</th>
				<th class="p-1 mb-1 bg-white text-success">제목</th>
			</tr>
		</thead>
			<tbody>
			<%
				while(rs2.next()) {
			%>
				<tr>
					<td class="p-1 mb-1 bg-success text-white" width="50">
						<%=rs2.getString("diaryDate")%>
					</td>
					<td class="p-1 mb-1 bg-white text-success" width="50">
						<a class="none"  style="color: green" href='/diary/diaryOne.jsp?diaryDate=
							<%=rs2.getString("diaryDate")%>'><%=rs2.getString("title")%></a>
					</td>
				</tr>
			<%
				}
			%>
			</tbody>
	</table>
	<!-- ======================================== 페이징 ========================================== -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
		
		<%
			if(currentPage > 1) {
		%>
		
			<li class="page-item">
				<a class="page-link link-success btn btn-outline-success" 
					href="./diaryList.jsp?currentPage=<%=currentPage-1%>">
						◀◁◀
				</a>
			</li>
		<%
			}
			if(currentPage < lastPage) {
		%>
		
			<li class="page-item">
				<a class="page-link link-success btn btn-outline-success" 
					href="./diaryList.jsp?currentPage=<%=currentPage+1%>">
						▷▶▷
				</a>
			</li>
			
		<%
			}
			
		%>
	 </ul>
	</nav>
		<div>
			<a class="none" style="color: black;" href="/diary/diary.jsp"><b>뒤로</b></a>
		</div>
	<!-- ======================================== 페이징 ========================================== -->
	<!-- ======================================== 검색 ========================================== -->
	<form method="get" action="/diary/diaryList.jsp">
		<div class="page-item page-link link-success btn btn-outline-success" ">
			<b>제목검색 : </b>
			<input type="text" name="searchWord">
			<button type="submit">검색</button>
		</div>
	</form>
	<!-- ======================================== 검색 ========================================== -->
	
			</div>
		<div class="col"></div>
	</div>
</div>
</body>
</html>