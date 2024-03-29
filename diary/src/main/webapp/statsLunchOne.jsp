<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	/*SELECT *
		FROM lunch
		ORDER BY lunch_date DESC
		LIMIT 0, 10;                          
	*/
	String sql1 = "SELECT * FROM lunch ORDER BY lunch_date DESC LIMIT 0, 20";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);

	rs1 = stmt1.executeQuery();
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

<body style="background-image: url(/board/img/gaga.png;">
<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
	<!-- 보드원 내용 //리저트셋필요-->

			<span style="color: green;" align="center"><h1>점심 통계</h1></span>
			<span><h3>최근 20일</h3></span>
		<table class="table table-hover">
			<%
				while(rs1.next()) {
			%>
			
				<tr>
					<th class="p-1 mb-1 bg-success text-white">날짜</th>
					<td class="p-1 mb-1 bg-white text-success" name="lunchDate"><%=rs1.getString("lunch_date")%></td>
					<th class="p-1 mb-1 bg-success text-white">메뉴</th>
					<td class="p-1 mb-1 bg-white text-success" name="menu"><%=rs1.getString("menu")%></td>
				</tr>
			<%
				}
			%>
				<tr>
					<th colspan="5"><a class="none" style="color: green;" href="/diary/statsLunch.jsp"> 통계📊 </a></th>
				</tr>

		</table>		

		</div>
	</div>
</div>	
</body>
</html>