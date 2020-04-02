<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<style type="text/css">
	
   red{
      color:red;
   }
	</style>
	</head>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	boolean adminChecked=new UserDAO().getAdminChecked(userID);
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
            <a class="nav-link" href="index.jsp">메인</a>
         </li>
         
         <li class="nav-item">
            <a class="nav-link  active" href="boardView.jsp">게시판</a>
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
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                  회원 관리
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown">
               <a class="dropdown-item" href="userModify.jsp">내등록정보</a>
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
   
  
	<div class="container">
	<%if(user.isAdminChecked()==true) {%>
	 <h5 class=" mx-5 ">공지를 게시할 경우, 제목에 <red>'공지'</red>를 포함해주세요.</h5>
	 <%} %>
		<form method="post" action="./boardWriteServlet" enctype="multipart/form-data">
			<table class="table table-borderd talbe-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;"><h5>게시물 작성 양식</h5></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><h5><small>아이디</small></h5></td>
						<td><h5><%=user.getUserID() %></h5>
						<input type="hidden" name="userID" value="<%=user.getUserID()%>"></td>
					</tr>
					<tr>
						<td><h5><small>글 제목</small></h5></td>
						<td><input class="form-control" type="text" maxlength="50" name="boardTitle" placeholder="글 제목을 입력하세요."></td>
					</tr>
					<tr>
						<td><h5><small>글 내용</small></h5></td>
						<td><textarea class="form-control" rows="10" name="boardContent" maxlength="2048" placeholder="글 내용을 입력하세요."></textarea></td>
					</tr>
					<tr>
						<td><h5><small>파일 업로드</small></h5></td>
						<td colspan="2">
							<input type="file" name="boardFile" class="file">
							<div class="input-group col-xs-12">
								<span class="input-group-addon"><i class="glyphicon glyphicon-pricture"></i></span>
								<input type="text" class="form-control input-lg" disabled placeholder="파일을 업로드하세요.">
								<span class="input-group-btn">
									<button class="browse btn btn-primary input-lg" type="button"><i class="glyphicon glyphicon-search"></i>파일 찾기</button>
									
								</span>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
				<div class="row">
					<div class="col-12"><input type="submit" class="btn btn-primary float-right" value="등록"></div>
				</div>
		</form>
	</div>
	
	<!-- 이미지 업로드 버튼 script -->
	<script type="text/javascript">
		$(document).on('click', ".browse", function() {
			var file = $(this).parent().parent().parent().find('.file');
			file.trigger('click');
		});
		$(document).on('change', '.file', function(){
			$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
		});
	</script>
	
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