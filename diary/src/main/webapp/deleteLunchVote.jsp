<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8"); //한글안깨지게
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; //커넥션 값초기화
	//데이터베이스 연결 conn에 값 대입
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	// boardOne페이지에있는 no값 가져와서 정수화
	String lunchDate = request.getParameter("lunchDate");

	//디버깅
	System.out.println(lunchDate + "<<==deleteLunchVote");
	
	// sql변수에 sql쿼리 대입 //대입하기전 쿼리 테스트하기
	String sql1 = "DELETE from lunch WHERE  lunch_date = ?";
	// PreparedStatement 쿼리 실행하기전에 컴파일하고 실행시에만 파라미터를 전달함 //걍 쿼리 //값초기화
	PreparedStatement stmt= null;// <<이건 빈값
	
	stmt = conn.prepareStatement(sql1); //<<이게 실행하는거
	stmt.setString(1, lunchDate); //이것도 실행되는거 어느부분이 실행될지 //위치
	
	int row = stmt.executeUpdate();
	 	
	if(row == 0) {
		System.out.println("점심투표 삭제실패");
	} else {
		System.out.println("점심투표 삭제");
		row = stmt.executeUpdate();
			 response.sendRedirect("/diary/lunchVote.jsp");
			 return;
	 	 }
	
%>