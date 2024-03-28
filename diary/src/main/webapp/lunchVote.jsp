<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	// 0. 로그인(인증) 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
	}
%>	
<%
	/*
	SELECT lunch_date lunchDate, menu 
	FROM lunch
	WHERE lunch_date = CURDATE();
	*/
	String lunch = request.getParameter("menu");
	String sql2 = "select lunch_date lunchDate, menu from lunch where lunch_date = curdate()";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	table {
		margin-left:auto; 
    	margin-right:auto;
	}
	.a-sgb {
	color:rgb(92, 209, 229);
	text-decoration: none;
	p-2; mb-2;	
	}
	.a-sgb2 {
	text-align: end;
	}
	.none {text-decoration: none;}
	th { text-align: center; }
</style>
<body  style="background-image: url(/board/img/gaga.png;">
<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
				<span style="color: green;" align="center">
					<h1>점 심 투 표</h1>
				</span>
			<div>
				<%
						if(rs2.next()) {
				%>
						<table class="table table-hover">
						<tr>
							<th class="p-1 mb-1 bg-success text-white"  >
								<h2>이미 참여하셨습니다.</h2>
							</th>
						</tr>
						<tr>
							<th>
								<a class="none" style="color: green;" href="/diary/statsLunch.jsp">
									결과보러가기</a>
							</th>
						</tr>
						</table>
				<%
						} else {
				%>							
							<table class="table table-hover">
						<tr>
							<th class="p-1 mb-1 bg-success text-white"  >
								<h2>오늘은 참여하지 않으셨습니다.</h2>
							</th>
						</tr>
						<tr>
							<th>
								<a class="none" style="color: green;" href="/diary/lunchVoteForm.jsp">
									투표하러가기</a>
							</th>
						</tr>
						</table>
				<%
						}
				%>
			 	
			 </div>
		</div>
	</div>
</div>	
</body>
</html>