<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // jdbc 라이브러리 사용
    request.setCharacterEncoding("utf-8");
    Class.forName("org.mariadb.jdbc.Driver");
   
    int commentNo = Integer.parseInt(request.getParameter("commentNo"));
    String diaryDate = request.getParameter("diaryDate");
    System.out.println(commentNo + "<<==deleteComment_commentNo");
    System.out.println(diaryDate + "<<==deleteComment_diaryDate");

   
   // DELETE FROM comment WHERE comment_no = '1';
  
    String sql = "DELETE FROM comment WHERE comment_no =  ?";
    Connection conn = null;
    PreparedStatement stmt = null;
    conn = DriverManager.getConnection(
    		"jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
    stmt = conn.prepareStatement(sql);
    stmt.setInt(1, commentNo);
    
    int row = stmt.executeUpdate();
    //System.out.println(row +"<<==row");
    
    										
    response.sendRedirect("./diaryOne.jsp?diaryDate="+diaryDate);
%>