<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");    
	/*
	INSERT INTO lunch(lunch_date,menu,update_date,create_date)
	VALUES(CURDATE(), ?, NOW(), NOW());
	*/

	String menu = request.getParameter("menu");
	System.out.println(menu + "<<==menu");
	
	String sql = "insert into lunch(lunch_date, menu, update_date, create_date) values(curdate(), ?, now(), now())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, menu);
	System.out.println(stmt + "<<==stmt");
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	//  목록을 재요청(redirect)하게 한다
	response.sendRedirect("/diary/statsLunch.jsp");
%>
