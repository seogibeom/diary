<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 0. post 인코딩 설정
	request.setCharacterEncoding("utf-8");                                      

	// 1. 입력값 받는다
	String diaryDate = request.getParameter("diaryDate");
	String feeling = request.getParameter("feeling");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	
	System.out.println(diaryDate + "<<== diaryDate");
	System.out.println(feeling + "<<== feeling");
	System.out.println(title + "<<== title");
	System.out.println(weather + "<<== weather");
	System.out.println(content + "<<== content");
	
	// 2. DB접속해서 입력값 입력한다
		
	String sql = "INSERT INTO diary(diary_date, feeling, title, weather, content, update_date, create_date) VALUES (?, ?, ?, ?, ?,NOW(), NOW())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, diaryDate);
	stmt.setString(2, feeling);
	stmt.setString(3, title);
	stmt.setString(4, weather);
	stmt.setString(5, content);
	System.out.println(stmt + "<<==stmt");
	

	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	// 3. 목록(diary.jsp) 을 재요청(redirect)하게 한다
	response.sendRedirect("/diary/diary.jsp");
	
%>
