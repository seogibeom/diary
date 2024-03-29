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
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
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
<body style="background-image: url(/board/img/gaga.png;">

	<form method="post" action="/diary/lunchVoteAction.jsp">
	<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
		
			<span style="color: green;" align="center"><h1>투표하기</h1></span>
			<table  class="table table-hover">
				<tr>
					<th class="p-1 mb-1 bg-success text-white">
							<input type="radio" name="menu" value="한식">한식
							<input type="radio" name="menu" value="중식">중식
							<input type="radio" name="menu" value="일식">일식
							<input type="radio" name="menu" value="양식">양식
							<input type="radio" name="menu" value="기타">기타
					</th>
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
			</div>
	</div>
</div>	
	</form>
</body>
</html>