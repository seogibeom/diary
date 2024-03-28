<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
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
	//자원반납
	rs1.close();
	stmt1.close();
	conn.close();
		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
	
	
	//1. 요청값 분석
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	String sql2 = "select member_id memberId from member where member_id=? and member_pw=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, memberId);
	stmt2.setString(2, memberPw);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()) {
		//로그인 성공
		// diary.login.my_session -> "ON" 으로변경
		System.out.println("로그인성공");
		String sql3 = "update login set my_session ='ON', on_date = NOW()";
		PreparedStatement stmt3 = conn.prepareStatement(sql3);
		int row = stmt3.executeUpdate();
		System.out.println(row+"<<<==row");
		response.sendRedirect("/diary/diary.jsp");
	} else {
		//로그인 실패
		String errMsg = URLEncoder.encode("※아이디 또는 비밀번호를 확인해주세요※","utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기
		System.out.println("로그인실패");
	}		
		
	rs1.close();
	rs2.close();
	stmt1.close();
	stmt2.close();
	conn.close();

%>