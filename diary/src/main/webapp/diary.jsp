<%@ page import="org.apache.catalina.connector.Response"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
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

		return; //코드진행을 끝내는것 // 메서드끝날때 리턴사용
	}
%>

<%
   // 1. 요청 분석
   // 출력하고자하는 달력의 년, 월 값을 넘겨받음
   
   String targetYear = request.getParameter("targetYear");
   String targetMonth = request.getParameter("targetMonth");
   
   Calendar target = Calendar.getInstance();
   
   if(targetYear != null && targetMonth != null){
      target.set(Calendar.YEAR, Integer.parseInt(targetYear));
      target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
   }
   // 시작 공백의 개수 -> 1일의 요일 필요 -> 타겟 날짜를 1일로 변경
   target.set(Calendar.DATE, 1);
   
   //달력 타이틀로 출력할 변수
   int tYear = target.get(Calendar.YEAR);
   int tMonth = target.get(Calendar.MONTH);
   
   int yoNum = target.get(Calendar.DAY_OF_WEEK); //일요일은 0으로 시작
   //디버깅
   System.out.println("calendar yoNum --> "+yoNum);
   
   // 시작 공백의 개수 : DAY_OF_WEEK - 1
   int startBlank = yoNum-1;
   System.out.println("calendar startBlank --> "+startBlank);
   int lastDate = target.getActualMaximum(Calendar.DATE);
   System.out.println(lastDate + "<<=lastDate");
   int countDiv = startBlank + lastDate; 
   
   //DB에서 tYear 와 tMonth에 해당되는 diary 목록추출
	String sql2 = "select diary_date diaryDate, day(diary_date) day, feeling, left(title,5) title from diary where year(diary_date)=? and month(diary_date)=?";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, tYear);
	stmt2.setInt(2, tMonth+1);
	System.out.println(stmt2 + "<<==stmt2");
	
	rs2 = stmt2.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>

   <style>
   		.cell {
   			float: left;
   			background-color: #B4D6FF;
   			opacity: 0.8;
   			width: 70px; height: 70px;
   			border: 1px solid #355400;
			border-radius: 2px;
			margin: 1px;
			position-absolute : top-50 start-50 translate-middle;
			
   		}
   		
   		.sun {
   			clear: both;
   			color: #FF0000;
   			opacity: 0.8;
   			margin: 1px;
   			position-absolute : top-50 start-50 translate-middle;
   		}
   		.day {
   			float: left;
   			width: 70px; height: 30px;
			text-align: center;
			vertical-align: middle;
   			border: 1px solid #355400;
   			border-radius: 2px;
   			background-color: #7EA0E4;
   			opacity: 0.8;
			margin: 1px;
			color: white;
			position-absolute : top-50 start-50 translate-middle;
			
   		}
   		.sunDay {
   			float: left;
			text-align: center;
			vertical-align: middle;
   			clear: both;
   			color: #FF0000;
   			opacity: 0.8;
   			background-color: #7EA0E4;
   			width: 70px; height: 30px;
   			border: 1px solid #355400;
			border-radius: 2px;
			margin: 1px;
			position-absolute : top-50 start-50 translate-middle;
		}
		.container {
		    background-color: orange;
		    display: flex;
		    justify-content: center; 
		    font-style: 
   		}
   		.none {text-decoration: none;}
   		
   		body {
   			   height: 100vh;
    			background: url(/Web0319/img/gg.png) no-repeat center;
    			background-size: cover;
   		}
 
		table {
			margin-left:auto; 
    		margin-right:auto;
		}
		.rubik-scribble-regular {
		  font-family: "Rubik Scribble", system-ui;
		  font-weight: 400;
		  font-style: normal;
		}
   </style>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Rubik+Scribble&display=swap" rel="stylesheet">
<body class="container  rubik-scribble-regular">
		<a class="none" style="color: black;" href="/diary/logout.jsp"><b>- 로그아웃 -</b></a>
<div>
	<fieldset>
	<legend><h1>[자유로운 일기장]</h1></legend>
   		<table>
   			<div style="text-align: end;">
				<a class="none" style="color: white;" href="/diary/lunchVote.jsp"><b>밥🍚</b></a>
			</div>
		
		
			<div style="text-align: center;">
		   	   <div >
		   	    	<h1 style="color: #7EA0E4;"><%=tYear%>년 <%=tMonth+1%>월</h1>
			   		<a class="none" style="color: white;" href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth-1%>"><b>◀◁◀</b></a>
			   		<a class="none" style="color: white;"href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth+1%>"><b>▷▶▷</b></a>
			   </div>
			   	<div style="text-align: end;">
				<a class="none" style="color: white;" href="/diary/diaryList.jsp"><b>&nbsp;<&nbsp;L i s t&nbsp;>&nbsp;</b></a>
			</div>
			   <div style="text-align: end;">
			   		<b><a class="none" style="color: black;" href="/diary/addDiaryForm.jsp">✍️일기쓰기</a></b>
			   </div>
			  
		   		
		  	 <!-- DATE값이 들어갈 DIV -->
			   <div class="sunDay " ><b>日</b></div>
			   <div class="day"><b>月</b></div>
			   <div class="day"><b>火</b></div>
			   <div class="day"><b>水</b></div>
			   <div class="day"><b>木</b></div>
			   <div class="day"><b>金</b></div>
			   <div class="day"><b>土</b></div>
			</div>
		   <%
		   	for(int i=1; i<=countDiv; i++) {
		   		
		   		if(i%7==1) {
		   %>
		   			<div class="cell sun position-absolute : top-50 start-50 translate-middle;">
		   <%
		   		} else {
		   %>
		   			<div class="cell position-absolute : top-50 start-50 translate-middle;">
		   <%
		   		}
			   			if(i-startBlank > 0) {
			   		%>
						<b><%=i-startBlank%></b><br>	
			   		<%
			   				// 현재날짜(i-startBlank)의 일기가 rs2목록에있는지 비교
			   				while(rs2.next()) {
			   					// 날짜에 일기가 존재한다
			   					if(rs2.getInt("day") == (i-startBlank)) {
			   		%>
			   						<div>
			   							<%=rs2.getString("feeling")%>
			   							<a class="none" style="color: black; font-size: 12px;" 
			   								href='/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>'>
			   								<%=rs2.getString("title")%>...
			   							</a>
			   						</div>
			   		<%				
			   						break;
			   					}
			   				}
			   				rs2.beforeFirst(); // ResultSet의 커스 위치를 처음으로 보내는 코드
			   			} else {
			   		%>
			   				&nbsp;
			   		<%
			   			}
			   		%>
			   	</div>
			   	</div>
		   <%
		    	}   
		   %>
		 </table>
	</fieldset>		 
</div>				

</body>
</html>