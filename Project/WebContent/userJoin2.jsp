<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
		</ul>
		
		<ul class="navbar-nav float-rigth nav-tabs">
	   		<li class="nav-item dropdown float-right"  >
            <a class="nav-link active dropdown-toggle" id="dropdown" data-toggle="dropdown">
                 	접속하기
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown"> 
               <a class="dropdown-item" href="userJoin.jsp">사용자 회원가입</a>
               <a class="dropdown-item active" href="adminJoin.jsp">교수 회원가입</a>
               <a class="dropdown-item" href="userLogin.jsp">로그인</a>
            </div>
            
         	</li>
         </ul>

	</div>
	</nav><!-- 상단바 -->
	<!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
	<!-- mt-3; 위쪽으로 3만큼 마진을 준다.(네비게이션과 폼의 거리; 맨 윗 창과 로그인 형식의 거리) -->
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userJoin">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" id="userID" class="form-control" placeholder="학번을 입력해주세요."><!-- form control; 입력 양식이 들어갈 수 있도록 -->
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
				<input type="email" name="userEmail" id="userEmail" class="form-control">
			</div>
			<div class="form-group">
				<label>학년</label>
				<select name="userGrade" id="userGrade" class="form-control">
					<option value="" disabled selected>-- 학년을 선택해주세요. --</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
					<option value="4">4학년</option>
				</select>
			</div>
			<div class="form-group">
				<label>이수학기</label>
				<select name="userSemester" id="userSemester" class="form-control">
					<option value="" disabled selected>-- 이수학기를 선택해주세요. --</option>
					<option value="1">1학기</option>
					<option value="2">2학기</option>
					<option value="3">3학기</option>
					<option value="4">4학기</option>
					<option value="5">5학기</option>
					<option value="6">6학기</option>
					<option value="7">7학기</option>
					<option value="8">8학기</option>
					<option value="9">초과 학기</option>
				</select>
			</div>
			<div class="form-group">
				<label>학과</label>
				<select name="userDepart" id="userDepart" class="form-control">
					<option value="" disabled selected>-- 학과를 선택해주세요. --</option>
							<option value="인문융합 자율학부">인문융합 자율학부</option>
							<option value="사회융합 자율학부">사회융합 자율학부</option>
							<option value="미디어컨텐츠융합 자율학부">미디어컨텐츠융합 자율학부</option>
							<option value="IT융합 자율학부">IT융합 자율학부</option>
							<option value="신학과">신학과</option>
							<option value="영어학과">영어학과</option>
							<option value="일어일본학과">일어일본학과</option>
							<option value="중어중국학과">중어중국학과</option>
							<option value="사회복지학과">사회복지학과</option>
							<option value="사회과학부">사회과학부</option>
							<option value="신문방송학과">신문방송학과</option>
							<option value="경영학부">경영학부</option>
							<option value="디지털컨텐츠학과">디지털컨텐츠학과</option>
							<option value="컴퓨터공학과">컴퓨터공학과</option>
							<option value="소프트웨어공학과">소프트웨어공학과</option>
							<option value="정보통신공학과">정보통신공학과</option>
							<option value="글로컬IT학과">글로컬IT학과</option>
				</select>
			</div>
			<div class="form-group">
				<label>이름</label>
				<input type="text" name="userName" id="userName" class="form-control" placeholder="실명을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>질문</label>
				<select name="userQuestion" id="userQuestion" class="form-control">
					<option value="" disabled selected>-- 질문을 선택해주세요. --</option>
					<option value="0">기억에 남는 추억의 장소는?</option>
					<option value="1">자신의 인생 좌우명은?</option>
					<option value="2">자신의 보물 제1호는?</option>
					<option value="3">가장 기억에 남는 선생님 성함은?</option>
					<option value="4">추억하고 싶은 날짜가 있다면?</option>
					<option value="5">내가 좋아하는 캐릭터는?</option>
				</select>
			</div>
			<div class="form-group">
				<label>답</label>
				<input type="text" name="userAnswer" id="userAnswer" class="form-control" placeholder="질문에 대한 답을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>권한</label><br>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="adminApply" id="adminApply" value="0" checked>
				  <label class="form-check-label" for="inlineRadio1">일반</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="adminApply" id="adminApply" value="1">
				  <label class="form-check-label" for="inlineRadio2">관리자</label>
				</div>
			</div>

			<div class="row">
				<div class="col-12"><input type="submit" class="btn btn-primary float-right" value="회원가입"></div>
			</div>
			
		</form>
	</section>
	
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