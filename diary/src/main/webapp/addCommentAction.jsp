<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%	
	// post 인코딩 설정
	request.setCharacterEncoding("utf-8");

	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");
	
	System.out.println(diaryDate + "<<==diaryDate");
	System.out.println(memo + "<<==memo");


	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	/*
			INSERT INTO COMMENT(
			diary_date, memo, update_date, CREATE_date
			) VALUES (
			'2024-03-25','댓글6', NOW(), NOW());
	*/

	String sql = "INSERT INTO comment(diary_date, memo, update_date, CREATE_date) VALUES (?, ?, NOW(), NOW())";
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, diaryDate);
	stmt.setString(2, memo);
	System.out.println(stmt+"<<==stmt");
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("댓글입력성공");
	} else {
		System.out.println("댓글입력실패");
	}
	
	
	response.sendRedirect("/diary/diaryOne.jsp?diaryDate=" + diaryDate);
	
%>