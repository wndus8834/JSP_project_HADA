<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	<script type="text/javascript">

	function passwordCheckFunction(){
		console.log(';;;');
		var userPassword1 = $('#userPassword').val();
		var userPassword2 = $('#userPassword1').val();
		if(userPassword1 != userPassword2){
			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		}else{
			$('#passwordCheckMessage').html('');
		}
	}
	</script>
	</head>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	boolean adminChecked = new UserDAO().getAdminChecked(userID);
	

	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
		UserDTO user = new UserDAO().getUser(userID);
		
		String adminCheck=null;
		if(user.isAdminChecked()==true){
			adminCheck="관리자";
		}else{
			adminCheck="일반";
		}
	%>

	   <%if(userID!=null){%>
	   <div class="float-right mx-3 mt-3"><h5><small>(<%=adminCheck %>)&nbsp;<%=user.getUserDepart() %>&nbsp;<%=user.getUserID() %><br><%=user.getUserName() %>님이 로그인했습니다.</small></h5></div><br><br>
	   <%}%>
	   
	   <div class="container-fluid">
	      <br>
	     <h1 class="text-center display-4">HADA</h1>
	     <h5 class="text-center"><small>SKHU WEB</small></h5>
	     <br>
	   </div>
	   
	  

	   <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
	   <a class="navbar-brand" href="index.jsp">HADA</a> 
	   <!-- 버튼을 누르면 navbar를 가진 요소가 보였다 안 보였다 함. 아래 div id에 정의함 -->
	   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
	      <span class="navbar-toggler-icon"></span> <!-- navbar-toggler-icon; 작대기가 세줄 그어진 아이콘 -->
	   </button>
	   <div id="navbar" class="collapse navbar-collapse">
	      <ul class="navbar-nav mr-auto nav-tabs">
	      <li class="nav-item"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
	            <a class="nav-link " href="index.jsp">메인</a>
	         </li>
	         
	         <li class="nav-item">
	            <a class="nav-link" href="boardView.jsp">게시판</a>
	         </li>
	          <li class="nav-item dropdown">
	         <a class="nav-link dropdown-toggle" href="Board.jsp" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        	  학과별 졸업요건
	         </a>
	            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
	                <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduITNecessary.jsp">IT자율 융합학부</a>
	                  <ul class="dropdown-menu">
	            		<li><a class="dropdown-item" href="GraduITNecessary.jsp">졸업 조건</a></li> 
	                     <li><a class="dropdown-item" href="GraduIT18.jsp">18학번</a></li>
	                  </ul>
	               </li>
	               <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduComNecessary.jsp">컴퓨터공학과</a>
	                  <ul class="dropdown-menu">
	                     <li><a class="dropdown-item" href="GraduComNecessary.jsp">졸업 조건</a></li>  
	                     <li><a class="dropdown-item" href="GraduCom13_15.jsp">13~16학번</a></li>
	                     <li><a class="dropdown-item" href="GraduCom17.jsp">17학번</a></li>
	                  </ul>
	               </li>
	               <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduSofNecessary.jsp">소프트웨어공학과</a>
	                  <ul class="dropdown-menu">
	                     <li><a class="dropdown-item" href="GraduSofNecessary.jsp">졸업 조건</a></li>  
	                     <li><a class="dropdown-item" href="GraduSof08_17.jsp">08~17학번</a></li>
	                  </ul>
	               </li>
	               <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduInfoNecessary.jsp">정보통신공학과</a>
	                  <ul class="dropdown-menu">
	                     <li><a class="dropdown-item" href="GraduInfoNecessary.jsp">졸업 조건</a></li>  
	                     <li><a class="dropdown-item" href="GraduInfo13_14.jsp">13~14학번</a></li> 
	                     <li><a class="dropdown-item" href="GraduInfo15_17.jsp">15~17학번</a></li>
	                  </ul>
	               </li>
	               <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="GraduGlocalNecessary.jsp">글로컬IT학과</a>
	                  <ul class="dropdown-menu">
	                     <li><a class="dropdown-item" href="GraduGlocalNecessary.jsp">졸업 조건</a></li>  
	                     <li><a class="dropdown-item" href="GraduGlocal13_15.jsp">13~15학번</a></li>
	                     <li><a class="dropdown-item" href="GraduGlocal16.jsp">16학번</a></li>
	                     <li><a class="dropdown-item" href="GraduGlocal17.jsp">17학번</a></li>
	                  </ul>
	               </li>
	            </ul>
	      </li>
	      

	<%
	   if(userID!=null) {
	%>
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

	<%
	   if(adminChecked==true){
	%>

	          <li class="nav-item dropdown"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
	           <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
	                관리자
	            </a>
	            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
	            <div class="dropdown-menu" aria-labelledby="dropdown">
	               <a class="dropdown-item" href="adminStudent.jsp">학생 관리</a>
	               <a class="dropdown-item" href="adminStudentGradu.jsp">졸업조건 미충족 학생 관리</a>
	               <a class="dropdown-item" href="adminPlus.jsp">관리자 추가</a>
	               <a class="dropdown-item" href="adminDepart.jsp">전공인정 관리</a>
	               <a class="dropdown-item" href="InsertInstead.jsp">대체과목 관리</a>
	               <a class="dropdown-item" href="WriteGradu.jsp">필수과목 관리</a>
	               <a class="dropdown-item" href="WriteCulture.jsp">핵심역량 교양 관리</a>
	               <a class="dropdown-item" href="adminScore.jsp">졸업점수 관리</a>
	            </div>
	      </li>

	<%      
	   }
	%>
	         </ul>
	         <ul class="navbar-nav float-rigth nav-tabs">
	         <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle active " id="dropdown" data-toggle="dropdown">
	                  회원 관리
	            </a>
	            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown">
	               <a class="dropdown-item active" href="userModify.jsp">내등록정보</a>
	               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
	            </div>
	         </li>
	         </ul>
	          
	<% 
	   } else {%>
	         
	         </ul>
	         <ul class="navbar-nav float-rigth nav-tabs">
		   		<li class="nav-item dropdown"  >
	            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
	                 	접속하기
	            </a>
	            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown"> 
	               <a class="dropdown-item" href="userJoin.jsp">사용자 회원가입</a>
	               <a class="dropdown-item" href="adminJoin.jsp">교수 회원가입</a>
	               <a class="dropdown-item" href="userLogin.jsp">로그인</a>
	            </div>
	            
	         	</li>
	         </ul>
	   <%}
	%>
	   </div>
	   </nav><!-- 상단바 -->
	<section class="container mt-3" style="max-width: 560px;">
		<h4><회원정보 수정></h4><br>
		<form method="post" action="./userUpdate">
			<div class="form-group">
				<label>아이디</label>
				<h5><%= user.getUserID() %></h5>
				<input type="hidden" name="userID" value="<%= user.getUserID() %>">
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword"  id="userPassword"onkeyup="passwordCheckFunction();" maxLength="20" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label>
				<input type="password" name="userPassword1" id="userPassword1" onkeyup="passwordCheckFunction();"  maxLength="20" class="form-control">
			</div>
			<h5 style="color: red;" id="passwordCheckMessage"></h5>
			
			<div class="form-group">
				<label>이메일</label>
				<input type="text" name="userEmail" class="form-control" value="<%= user.getUserEmail() %>">
			</div>
			<div class="form-group">
				<label>학과</label>
				<select name="userDepart" id="userDepart" class="form-control">
					<option value="" disabled  <% if((user.getUserDepart()).equals("")) out.println("selected"); %>>-- 학과를 선택해주세요. --</option>
					<option value="인문융합 자율학부" <% if((user.getUserDepart()).equals("인문융합 자율학부")) out.println("selected"); %>>인문융합 자율학부</option>
					<option value="1" <% if((user.getUserDepart()).equals("사회융합 자율학부")) out.println("selected"); %>>사회융합 자율학부</option>
					<option value="사회융합 자율학부" <% if((user.getUserDepart()).equals("미디어컨텐츠융합 자율학부")) out.println("selected"); %>>미디어컨텐츠융합 자율학부</option>
					<option value="IT융합 자율학부" <% if((user.getUserDepart()).equals("IT융합 자율학부")) out.println("selected"); %>>IT융합 자율학부</option>
					<option value="신학과" <% if((user.getUserDepart()).equals("신학과")) out.println("selected"); %>>신학과</option>
					<option value="영어학과" <% if((user.getUserDepart()).equals("영어학과")) out.println("selected"); %>>영어학과</option>
					<option value="일어일본학과" <% if((user.getUserDepart()).equals("일어일본학과")) out.println("selected"); %>>일어일본학과</option>
					<option value="중어중국학과" <% if((user.getUserDepart()).equals("중어중국학과")) out.println("selected"); %>>중어중국학과</option>
					<option value="사회복지학과" <% if((user.getUserDepart()).equals("사회복지학과")) out.println("selected"); %>>사회복지학과</option>
					<option value="사회과학부" <% if((user.getUserDepart()).equals("사회과학부")) out.println("selected"); %>>사회과학부</option>
					<option value="신문방송학과" <% if((user.getUserDepart()).equals("신문방송학과")) out.println("selected"); %>>신문방송학과</option>
					<option value="경영학부" <% if((user.getUserDepart()).equals("경영학부")) out.println("selected"); %>>경영학부</option>
					<option value="디지털컨텐츠학과" <% if((user.getUserDepart()).equals("디지털컨텐츠학과")) out.println("selected"); %>>디지털컨텐츠학과</option>
					<option value="컴퓨터공학과" <% if((user.getUserDepart()).equals("컴퓨터공학과")) out.println("selected"); %>>컴퓨터공학과</option>
					<option value="소프트웨어공학과" <% if((user.getUserDepart()).equals("소프트웨어공학과")) out.println("selected"); %>>소프트웨어공학과</option>
					<option value="정보통신공학과" <% if((user.getUserDepart()).equals("정보통신공학과")) out.println("selected"); %>>정보통신공학과</option>
					<option value="글로컬IT학과" <% if((user.getUserDepart()).equals("글로컬IT학과")) out.println("selected"); %>>글로컬IT학과</option>
				</select>
			</div>
			<div class="form-group">
				<label>이름</label>
				<input type="text" name="userName" class="form-control" value="<%= user.getUserName() %>">
			</div>
			<div class="form-group">
				<label>질문</label>
				<select name="userQuestion" id="userQuestion" class="form-control">
				<option value="" disabled <% if((user.getUserDepart()).equals("")) out.println("selected"); %>>-- 질문을 선택해주세요. --</option>
				<option value="0" <% if((user.getUserQuestion()).equals("0")) out.println("selected"); %>>기억에 남는 추억의 장소는?</option>
				<option value="1" <% if((user.getUserQuestion()).equals("1")) out.println("selected"); %>>자신의 인생 좌우명은?</option>
				<option value="2" <% if((user.getUserQuestion()).equals("2")) out.println("selected"); %>>자신의 보물 제1호는?</option>
				<option value="3" <% if((user.getUserQuestion()).equals("3")) out.println("selected"); %>>가장 기억에 남는 선생님 성함은?</option>
				<option value="4" <% if((user.getUserQuestion()).equals("4")) out.println("selected"); %>>추억하고 싶은 날짜가 있다면?</option>
				<option value="5" <% if((user.getUserQuestion()).equals("5")) out.println("selected"); %>>내가 좋아하는 캐릭터는?</option>
				</select>
			</div>
			<div class="form-group">
				<label>답</label>
				<input type="text" name="userAnswer" class="form-control" value="<%= user.getUserAnswer() %>">
			</div>
			<div class="row">
				<div class="col-12"><input type="submit" class="btn btn-primary float-right" value="회원정보 수정"></div>
			</div>
			
		</form>
	</section>




	
	<br>
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