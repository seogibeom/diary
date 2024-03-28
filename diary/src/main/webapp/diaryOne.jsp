<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<<==diaryDate");

	String sql1 = "SELECT diary_date diaryDate, feeling, title, weather, content, update_date, create_date from diary where diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, diaryDate);
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
<div class="container" style="opacity: 0.8;">
	<div class="row">
		<div class="col"></div>
		<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
	<!-- 보드원 내용 //리저트셋필요-->
	<%
		if(rs1.next()) {
	%>
			<span style="color: green;" align="center"><h1>D I A R Y</h1></span>
		<table class="table table-hover">
			<tr>
				<th class="p-1 mb-1 bg-success text-white">날짜</th>
				<td class="p-1 mb-1 bg-white text-success" name="diaryDate"><%=rs1.getString("diaryDate")%></td>
				<th class="p-1 mb-1 bg-success text-white">날씨</th>
				<td class="p-1 mb-1 bg-white text-success" name="weather"><%=rs1.getString("weather")%></td>
			</tr>
			<tr>
				<th class="p-1 mb-1 bg-success text-white">제목</th>
				<td class="p-1 mb-1 bg-white text-success" name="title" ><%=rs1.getString("title")%></td>
				<th class="p-1 mb-1 bg-success text-white">기분</th>
				<td class="p-1 mb-1 bg-white text-success" name="feeling" ><%=rs1.getString("feeling")%></td>
			</tr>
			<tr>
				<th class="p-1 mb-1 bg-success text-white" colspan="4" >내용</th>
			</tr>
			<tr>
				<td class="p-1 mb-1 bg-white text-success" name="content" colspan="4"><%=rs1.getString("content")%></td>
			</tr>
			<tr>
				<th colspan="4"><a class="none" style="color: green;" href="/diary/diary.jsp">📅CALENDAR📅</a></th>
			</tr>
			<tr>
				<th colspan="4"><a class="none" style="color: green;" href="/diary/diaryList.jsp"> 📋L I S T📋 </a></th>
			</tr>
				
				<a  class="page-link link-primary btn btn-outline-primary a-sgb2" 
						href='./updateDiaryForm.jsp?diaryDate=<%=diaryDate%>'>
					 수정
				</a>
				<a  class="page-link link-danger btn btn-outline-danger a-sgb2" 
						href='./deleteDiary.jsp?diaryDate=<%=diaryDate%>'>
					 삭제
				</a>
		</table>		
		
	<%
		}
	%>	
		</div>
		<div class="col"></div>
	</div>
</div>	
</body>
</html>