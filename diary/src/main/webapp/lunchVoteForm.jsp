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

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<h1>투표하기</h1>
	<form method="post" action="/diary/lunchVoteAction.jsp">
			<table>
				<tr>
					<td>
							<input type="radio" name="menu" value="한식">한식
							<input type="radio" name="menu" value="중식">중식
							<input type="radio" name="menu" value="일식">일식
							<input type="radio" name="menu" value="양식">양식
							<input type="radio" name="menu" value="기타">기타
					</td>
				</tr>
				<tr>
					<td>
						<a class="none" style="color: black;" href="/diary/lunchVote.jsp">
							<b>뒤로</b>
						</a>
					<button style="float: right; type="submit" class="btn btn-primary inline-block">입력</button>
					</td>
				</tr>
			</table>
	</form>
</body>
</html>