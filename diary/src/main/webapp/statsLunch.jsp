<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
//로그인 인증 분기
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
	SELECT menu,COUNT(*) 
	FROM lunch
	GROUP BY menu
	ORDER BY COUNT(*) DESC;
	*/
	String sql2 = "select menu, count(*) cnt from lunch group by menu";
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<body  style="background-image: url(/board/img/gaga.png;">
<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
	<span style="color: green;" align="center"><h1>점심 통계</h1></span>
	
	<%
				double maxHeight = 500;
				double totalCnt = 0; //
				while(rs2.next()) {
					totalCnt = totalCnt + rs2.getInt("cnt");
				}
				
				rs2.beforeFirst();
	%>
	<div>
		전체 투표수 : <%=(int)totalCnt%>
	</div>
	<table class="table table-hover"  border="1" style="width: 400px;">
		<tr>
			<%	
				String[] c = {"#DF4D4D", "#FFA873", "#D3C64A", "#58AA52", "#5587ED"};
				int i = 0;
				while(rs2.next()) {
					int h = (int)(maxHeight * (rs2.getInt("cnt")/totalCnt));
			%>
					<td style="vertical-align: bottom;">
						<div style="height: <%=h%>px; 
									background-color:<%=c[i]%>;
									text-align: center">
							<%=rs2.getInt("cnt")%>
						</div>
					</td>
			<%		
					i = i+1;
				}
			%>
		</tr>
		<tr>
			<%
				// 커스 위치를 다시 처음으로
				rs2.beforeFirst();
							
				while(rs2.next()) {
			%>
					<td><%=rs2.getString("menu")%></td>
			<%		
				}
			%>
		</tr>
		<tr>
				<th colspan="6"><a class="none" style="color: green;" href="/diary/statsLunchOne.jsp"> 상세보기 </a></th>
		</tr>
		<tr>
				<td>
						<a class="none" style="color: black;" href="/diary/lunchVote.jsp">
								<b>뒤로</b>
						</a>
				</td>
		</tr>
		
	</table>
			</div>
		</div>
	</div>
</div>	
	
	
</body>
</html>