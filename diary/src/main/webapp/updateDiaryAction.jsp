<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	//1 요청분석  diary_date diaryDate, title, weather, content, update_date
	
	String weather = request.getParameter("weather");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String diaryDate = request.getParameter("diaryDate");
	//디버깅
	System.out.println(weather + "<<=weather");
	System.out.println(feeling + "<<=feeling");
	System.out.println(title + "<<=title");
	System.out.println(content + "<<=content");
	System.out.println(diaryDate + "<<=diaryDate");
	
	//2 디비 데이터 수정
	String sql = "UPDATE diary SET weather = ?, feeling = ?, title = ?, content = ? WHERE diary_date = ?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	int row = 0;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, weather);
	stmt.setString(2, feeling);
	stmt.setString(3, title);
	stmt.setString(4, content);
	stmt.setString(5, diaryDate);
	System.out.println(stmt+"<<==stmt");
	
	row = stmt.executeUpdate();

	//3 결과분기
	// 성공시 cityboardOne.jsp 로 이동
	// 실패시 updateCityboardForm.jsp 로 이동
	
	if(row==1) {
		response.sendRedirect("/diary/diaryOne.jsp?diaryDate="+diaryDate);
	} else {
		response.sendRedirect("/diary/updateDiaryForm.jsp?diaryDate="+diaryDate);
	}
	stmt.close();
	conn.close();
%>