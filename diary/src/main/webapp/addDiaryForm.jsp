<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	// 0. 로그인 인증분기
	//diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/diary","root","java1234");
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	String mySession = null;
	if(rs1.next()){
		mySession = rs1.getString("mySession");
	}
	// diary.login.my_session => 'OFF'	=> redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저 해주세요","utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
		return; //코드진행을 끝내는문법 예) 메서드끝낼때 리턴사용
	}
%>



<%
	String checkDate = request.getParameter("checkDate");
	if(checkDate == null) {
		checkDate = "";
	}
	String ck = request.getParameter("ck");
	if(ck == null) {
		ck = "";
	}
	
	String msg = "";
	if(ck.equals("T")) {
		msg = "입력이 가능한 날짜입니다";
	} else if(ck.equals("F")) {
		msg = "일기가 이미 존재하는 날짜입니다";
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<style>
	table {
		margin-left:auto; 
    	margin-right:auto;
	}
	.none {text-decoration: none;}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<body style="background-image: url(/board/img/rara.png;">
	checkDate : <%=checkDate %><br>
	ck : <%=ck %>
<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 bg-success border shadow p-3 mb-5 bg-body-tertiary rounded">	
<fieldset>	
	<legend style="color: green;" align="center"><h2>D I A R Y - W R I T E</h2></legend>
		<form method="post" action="/diary/checkDateAction.jsp">
		<table style="color: green">
			<tr>
				<th>날짜확인 : </th>
				<td><input type="date" class="rounded" name="checkDate" value="<%=checkDate%>">
					<span><%=msg%></span></td>
				<td><button type="submit"  class="btn btn-success inline-block">날짜가능확인</button></td>
			</tr>
		</form>

<hr>	
	
		<form method="post" action="/diary/addDiaryAction.jsp">
				<tr>
					<th>날짜 : </th>
					<%
						if(ck.equals("T")) {
					%>
					 <td><input class="rounded" value="<%=checkDate%>" type="text" name="diaryDate" readonly="readonly"></td>
					 <%
						} else {
					 %>
					 <td><input class="rounded" value="" type="text" name="diaryDate" readonly="readonly"></td>
					 <%
						}
					 %>
				</tr>
				<tr>
					<th>기분 : </th>
					<td>
							<input type="radio" name="feeling" value="&#128512;">&#128512;
							<input type="radio" name="feeling" value="&#129322;">&#129322;
							<input type="radio" name="feeling" value="&#128545;">&#128545;
							<input type="radio" name="feeling" value="&#128557;">&#128557;
					</td>
				</tr>
				<tr>
					<th>제목 : </th>
					<td> <input class="rounded" type="text" name="title"></td>
				</tr>
				
				<tr>
				 	<td>
						<select name="weather">
							<option value="맑음">맑음☀️</option>
							<option value="흐림">흐림☁️</option>
							<option value="비">비🌧️</option>
							<option value="눈">눈🌨️</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan ="3">
					<textarea class="rounded" rows="7" cols="50" name="content"></textarea>
					<td>
				</tr>
				<tr>
					<td colspan ="3">
					<a class="none" style="color: black;" href="/diary/diary.jsp"><b>뒤로</b></a>
					<button style="float: right; type="submit" class="btn btn-primary inline-block">입력</button>
					</td>
				</tr>

			</div>
		<div class="col"></div>
	</div>
</div>
		</table>
		</form>
</body>
</html>