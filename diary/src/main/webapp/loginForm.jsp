<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/*
	// 0. 로그인 인증 분기
	// diary.login.my_session => 'ON' => redirect("diary.jsp")
	// 디비이름.테이블.
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);	
	rs1 = stmt1.executeQuery();
	String mySesion = null; 
	if(rs1.next()) {
		mySesion = rs1.getString("mySession");
	}
	if(mySesion.equals("ON")) {
		
		response.sendRedirect("/diary/diary.jsp"); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기

		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
	*/
	// 0-1 로그인 인증분기 session으로 사용변경 
	// 로그인성공시 세션에 loginMember라는 변수를 만들고 값으로 로그인아이디를 저장
	
	String loginMember = (String)(session.getAttribute("loginMember"));
	// session.getAttribute()는 찾는변수가없으면 null값을 반환한다
	// null이면 로그아웃상태이고, null이아니면 로그인상태
	System.out.println(loginMember + "<<==loginMember");
	
	//loginForm페이지는 로그아웃상태에서만 출력되는 페이지
	if(loginMember != null) {
		response.sendRedirect("/diary/diary.jsp"); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
	
	//1. 요청값 분석
	String errMsg = request.getParameter("errMsg");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<style>
	table {
		margin-left:auto; 
    	margin-right:auto;
	}
</style>
<body style="background-image: url(/board/img/rara.png;">
	<div class="container">
		<div class="row">
			<div class="col"></div>
			<div class="mt-5 bg-success border shadow p-3 mb-5 bg-body-tertiary rounded">
				<div>
					<%
						if(errMsg != null) {
					%>
						<%=errMsg%>
					<%
						}
					%>
				</div>
				
	<fieldset>	
		<legend style="color: green;" align="center"><h1>로그인</h1></legend>
			<form method="post" action="./loginAction.jsp">
				<table style="color: green">
					<tr>
						<th>id : </th>
						<td><input type="text" class="rounded" name="memberId"></td>
					</tr>
					<tr>
						<th>pw : </th>
						<td><input type="password" class="rounded" name="memberPw">
							<button type="submit" class="btn btn-success inline-block">로그인</button>
						</td>
					</tr>
				</table>
			</form>	
	</fieldset>
			</div>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>