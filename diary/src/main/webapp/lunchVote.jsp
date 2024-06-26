<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
// 로그인 인증 분기
String loginMember = (String)(session.getAttribute("loginMember"));

if(loginMember == null) {
	String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요","utf-8");
	response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기

	return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
}
%>	
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	/*
	SELECT lunch_date lunchDate, menu 
	FROM lunch
	WHERE lunch_date = CURDATE();
	*/
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
							<th class="p-1 mb-1 bg-white text-success"  >
								<h3> <%=rs2.getString("lunchDate")%> 날에 드신 점심은 <%=rs2.getString("menu")%> 입니다.</h3>
							</th>
						</tr>
						
						<tr>
							<th>
								<a class="none" style="color: green;" href="/diary/statsLunch.jsp">
									결과보러가기</a>
							</th>
						</tr>
						<tr>
							<td>
									<a class="none" style="color: black;" href="/diary/diary.jsp">
										<b>뒤로</b>
									</a>
							</td>
							<td>
									<a class="none" style="color: black;" href='/diary/deleteLunchVote.jsp?lunchDate= <%=rs2.getString("lunchDate")%>'>
										<b>삭제</b>
									</a>
							</td>
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
						<tr>
							<td>
									<a class="none" style="color: black;" href="/diary/diary.jsp">
										<b>뒤로</b>
									</a>
							</td>
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