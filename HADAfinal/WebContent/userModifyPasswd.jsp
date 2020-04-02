<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content_Type" content="text/html" charset="UTF-8">
	<!-- 반응형 웹, 자동형 웹 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>HADA - SKHU WEB</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">   
	</head>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	
	boolean adminChecked=new UserDAO().getAdminChecked(userID);
%>
	
	<div class="container-fluid">
		<br>
	  <h1 class="text-center display-4">HADA</h1>
	  <h5 class="text-center"><small>SKHU WEB</small></h5>
	  <br>
	</div>


<div class="container-fluid">
</div>

   <!-- bootstrap에서 제공하는 api - navbar -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top"> <!-- bg-light;배경이 하얗게 보인다. -->
	<!-- navbar-brand는 부트스틀랩 안에서 로고같은거 출력할때 사용하는거 -->
	<a class="navbar-brand" href="index.jsp">HADA</a> 
	<!-- 버튼을 누르면 navbar를 가진 요소가 보였다 안 보였다 함. 아래 div id에 정의함 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon"></span> <!-- navbar-toggler-icon; 작대기가 세줄 그어진 아이콘 -->
	</button>
	<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto nav-tabs">
			 <li class="nav-item"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
            <a class="nav-link" href="index.jsp">메인</a>
         </li>
         <li class="nav-item">
            <a class="nav-link" href="boardView.jsp">게시판</a>
         </li>
<%
	if(adminChecked==false){
%>
			 <li class="nav-item">
				<a class="nav-link" href="InsertClass.jsp">수강 과목 등록</a>
		</li>
		<li class="nav-item">
            <a class="nav-link" href="Graduate.jsp">졸업요건 조회</a>
         </li>
<%		
	}
%>
         <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="Board.jsp" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			 학과별 졸업요건
			</a>
				<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				
					<li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#">it자율 융합학부</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">18학번</a></li>
						</ul>
					</li>
					<li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduCom13_15.jsp">컴퓨터 공학과</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="GraduCom13_15.jsp">13~15학번</a></li>
							<li><a class="dropdown-item" href="#">16학번</a></li>
							<li><a class="dropdown-item" href="#">17학번</a></li>
						</ul>
					</li>
					<li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#">소프트웨어공학과</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">13~15학번</a></li>
							<li><a class="dropdown-item" href="#">16학번</a></li>
							<li><a class="dropdown-item" href="#">17학번</a></li>
						</ul>
					</li>
				</ul>
		</li>
          
<%
	if(adminChecked==true){
%>
			 <li class="nav-item dropdown"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
           <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                관리자
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="adminStudent.jsp">관리자 학생 관리</a>
               <a class="dropdown-item" href="adminPlus.jsp">관리자 추가</a>
               <a class="dropdown-item" href="adminDepart.jsp">전공인정 관리</a>
               <a class="dropdown-item" href="InsertInstead.jsp">대체과목 관리</a>
               <a class="dropdown-item" href="WriteGradu.jsp">필수과목 관리</a>
               <a class="dropdown-item" href="WriteCulture.jsp">핵심역량 교양 관리</a>
            </div>
      </li>

<%		
	}
%>
         
		</ul>
	
         <ul class="navbar-nav float-rigth nav-tabs">
         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                  회원 관리
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown">
               <a class="dropdown-item" href="userModify.jsp">내등록정보</a>
               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            </div>
         </li>
         </ul> 
	</div>
	</nav><!-- 상단바 -->
	
	
	<div class="container">
		
			<form method="post" action="userLogout.jsp"><!-- action 바꿔야함 -->
				<table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">비밀번호 변경</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>기존 비밀번호</td>
							<td><input type="text" name="userID" class="form-control"></td>
						</tr>
						<tr>
							<td>새 비밀번호</td>
							<td><input type="text" name="userID" class="form-control"></td>
						</tr>
						<tr>
							<td>새 비밀번호 확인</td>
							<td><input type="text" name="userName" class="form-control"></td>
						</tr>
					</tbody>
				</table>
				<div>
	               <a href="userModify.jsp" class="btn btn-primary float-right mx-2">취소하기</a>
	               <input type="submit" class="btn btn-primary float-right mx-2" value="저장하기">
         		</div><br>
			</form>
			
		
	</div>
	
	
	<!-- 가장 아래쪽에 들어가는 내용 -->
	<footer class="bg-dark mt-4 p-3 text-center fixed-bottom" style="color: #FFFFFF;">
	<!-- 저작권 표시 -->
		Copyright &copy; 2018 HADA All Rights Reserved.
	</footer>
	
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>