<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String diaryDate = request.getParameter("diaryDate");
	System.out.println(diaryDate + "<<==diaryDate");
	
	String sql = "SELECT diary_date diaryDate, feeling, title, weather, content, update_date, create_date from diary where diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	
	//System.out.println(stmt);
	
	rs = stmt.executeQuery();
	
	if(rs.next()) {

%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
	th { text-align: center; }
</style>

<body style="background-image: url(/board/img/gaga.png;">
	<form method="post"
		action="/diary/updateDiaryAction.jsp">
		<div class="container" style="opacity: 0.8;">
			<div class="row">
				<div class="col"></div>
				<div class="mt-5 bg-white border shadow p-3 mb-5 bg-body-tertiary rounded">
			<!-- 보드원 내용 //리저트셋필요-->
					<span style="color: green;" align="center"><h1>일기 수정</h1></span>
				<table  class="table table-hover">
					<tr>
						<th class="p-1 mb-1 bg-success text-white">날짜</th>
						<td class="p-1 mb-1 bg-white text-success">
							<input type="text" name="diaryDate" value='<%=rs.getString("diaryDate")%>' readonly="readonly"></td>
						<th class="p-1 mb-1 bg-success text-white">날씨</th>
						<td class="p-1 mb-1 bg-white text-success">
							<select name="weather" value='<%=rs.getString("weather")%>'>
								<option value="맑음">맑음☀️</option>
								<option value="흐림">흐림☁️</option>
								<option value="비">비🌧️</option>
								<option value="눈">눈🌨️</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="p-1 mb-1 bg-success text-white">제목</th>
						<td class="p-1 mb-1 bg-white text-success">
							<input type="text" name="title" value='<%=rs.getString("title")%>'></td>
						<th class="p-1 mb-1 bg-success text-white">기분 : </th>
					<td>
							<input type="radio" name="feeling" value="&#128512;">&#128512;
							<input type="radio" name="feeling" value="&#129322;">&#129322;
							<input type="radio" name="feeling" value="&#128545;">&#128545;
							<input type="radio" name="feeling" value="&#128557;">&#128557;
					</td>
					</tr>
					<tr>
						<th class="p-1 mb-1 bg-success text-white">내용</th>
					</tr>
					<tr>
						<td class="p-1 mb-1 bg-white text-success" colspan="4">
							<textarea rows="8" cols="90" name="content" value='<%=rs.getString("content")%>'></textarea>
					</tr>
					<tr>
						<th colspan="4" width="70%" align="right">
						 	<button type="submit" class="btn btn-primary">수정</button>
						 </th>
					</tr>
				</table>		
					
				</div>
				<div class="col"></div>
			</div>
		</div>
		
	</form>

</body>
</html>
<%		
	}

%>