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
	// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
	if(mySession.equals("OFF")) {
		
		String errMsg = URLEncoder.encode("※잘못된 접근입니다. 로그인 먼저해주세요※","utf-8");
		response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg); //돌아가서 다시요청하는것 //sendRedirect는 겟방식 ? 쓰기

		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
		//현재값이 OFF아니고 ON이다 ==> OFF변경후 loginForm으로 리다이렉트
		
		String checkDate = request.getParameter("checkDate");
				
		String sql2 = "select diary_date diaryDate from diary where diary_date=?";
		// 결과가 있으면 이미 이날짜에 일기가있다 ==>> 이날짜로는 입력하면안된다
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, checkDate);
		rs2 = stmt2.executeQuery();
		if(rs2.next()) {
			// 이날짜 일기기록 불가능 이미존재함
			response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=F");
		} else {
			// 이날짜 일기기록 가능
			response.sendRedirect("/diary/addDiaryForm.jsp?checkDate="+checkDate+"&ck=T");
		}
		
%>