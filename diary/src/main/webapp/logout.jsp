<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	// 로그인 인증 분기
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	// 디비이름.테이블.
	
	String sql1 = "select my_session mySession from login";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);	
	rs1 = stmt1.executeQuery();
	String mySession = null; 
	if(rs1.next()) {
		mySession = rs1.getString("mySession");
	}
	if(mySession.equals("OFF")) {
		
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요","utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		//자원반납
		rs1.close();
		stmt1.close();
		conn.close();
		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
		//현재값이 OFF아니고 ON이다 ==> OFF변경후 loginForm으로 리다이렉트
		String sql2 = "UPDATE login set my_session='OFF', off_date=now()";
		PreparedStatement stmt2 = null;
		stmt2 = conn.prepareStatement(sql2);	
		int row = stmt2.executeUpdate();
		System.out.println(row + "<<==row");
		
		response.sendRedirect("/diary/loginForm.jsp");
		
	
		//if문에 안걸릴때..
		rs1.close();
		stmt1.close();
		conn.close();
%>