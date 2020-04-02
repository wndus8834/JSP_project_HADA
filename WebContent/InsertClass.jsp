<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="userClass.userClassDTO" %>
<%@ page import="userClass.userClassDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="userScore.userScoreDTO" %>
<%@ page import="userScore.userScoreDAO" %>
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
</head>
<body>
<%
	String userID=null;
	String subjYear="전체";
	String subjSemester="전체";
	String subjMain="전체";
	String search="";
	int pageNumber=0;
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
	if(request.getParameter("subjYear")!=null){
		subjYear=request.getParameter("subjYear");
	}
	if(request.getParameter("subjSemester")!=null){
		subjSemester=request.getParameter("subjSemester");
	}
	if(request.getParameter("subjMain")!=null){
		subjMain=request.getParameter("subjMain");
	}
	if(request.getParameter("search")!=null){
		search=request.getParameter("search");
	}
	if(request.getParameter("pageNumber")!=null){
		try{//정수형으로 입력 안 했을 시에는 오류가 나기 때문에
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
		} catch(Exception e){
			System.out.println("검색 페이지 번호 오류");
		}
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
	            <a class="nav-link active" href="InsertClass.jsp">수강 과목 등록</a>
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
	   
	
	<section class="container"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
		<!-- get방식; 사용자가 서버에 데이터 전달하도록, mt-3;위쪽으로 3만큼 마진을 준다. -->
		<form method="get" action="./InsertClass.jsp" class="form-inline mt-3">
			<select name="subjYear" class="form-control mx-1 mt-2">
				<option value="전체" >전체년도</option>
				<option value="2011"<% if(subjYear.equals("2011")) out.println("selected"); %>>2011</option>
				<option value="2012"<% if(subjYear.equals("2012")) out.println("selected"); %>>2012</option>
				<option value="2013"<% if(subjYear.equals("2013")) out.println("selected"); %>>2013</option>
				<option value="2014"<% if(subjYear.equals("2014")) out.println("selected"); %>>2014</option>
				<option value="2015"<% if(subjYear.equals("2015")) out.println("selected"); %>>2015</option>
				<option value="2016"<% if(subjYear.equals("2016")) out.println("selected"); %>>2016</option>
				<option value="2017"<% if(subjYear.equals("2017")) out.println("selected"); %>>2017</option>
				<option value="2018"<% if(subjYear.equals("2018")) out.println("selected"); %>>2018</option>
				<option value="2019"<% if(subjYear.equals("2019")) out.println("selected"); %>>2019</option>
				<option value="2020"<% if(subjYear.equals("2020")) out.println("selected"); %>>2020</option>
				<option value="2021"<% if(subjYear.equals("2021")) out.println("selected"); %>>2021</option>
				<option value="2022"<% if(subjYear.equals("2022")) out.println("selected"); %>>2022</option>
				<option value="2023"<% if(subjYear.equals("2023")) out.println("selected"); %>>2023</option>
			</select>
			<select name="subjSemester" class="form-control mx-1 mt-2">
				<option value="전체" >전체학기</option>
				<option value="1학기"<% if(subjSemester.equals("1학기")) out.println("selected"); %>>1학기</option>
				<option value="여름학기"<% if(subjSemester.equals("여름학기")) out.println("selected"); %>>여름학기</option>
				<option value="2학기"<% if(subjSemester.equals("2학기")) out.println("selected"); %>>2학기</option>
				<option value="겨울학기"<% if(subjSemester.equals("겨울학기")) out.println("selected"); %>>겨울학기</option>
			</select>
			<select name="subjMain"class="form-control mx-1 mt-2">
				<option value="전체" >이수구분</option>
				<option value="전필" <% if(subjMain.equals("전필")) out.println("selected"); %>>전필</option>
				<option value="전선" <% if(subjMain.equals("전선")) out.println("selected"); %>>전선</option>
				<option value="전탐" <% if(subjMain.equals("전탐")) out.println("selected"); %>>전탐</option>
				<option value="교필" <% if(subjMain.equals("교필")) out.println("selected"); %>>교필</option>
				<option value="교선" <% if(subjMain.equals("교선")) out.println("selected"); %>>교선</option>
				<option value="부전필" <% if(subjMain.equals("부전필")) out.println("selected"); %>>부전필</option>
				<option value="부전선" <% if(subjMain.equals("부전선")) out.println("selected"); %>>부전선</option>
				<option value="복필" <% if(subjMain.equals("복필")) out.println("selected"); %>>복필</option>
				<option value="복선" <% if(subjMain.equals("복선")) out.println("selected"); %>>복선</option>
				<option value="기타" <% if(subjMain.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<input name="search" type="text" class="form-control mx-1 mt-2" placeholder="과목명을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
		</form>
		
		            
		
		<div class="container">
		<div class="row">
			<table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align: center;">년도</th>
						<th style="background-color:#eeeeee; text-align: center;">학기</th>
						<th style="background-color:#eeeeee; text-align: center;">과목 코드</th>
						<th style="background-color:#eeeeee; text-align: center;">대분류</th>
						<th style="background-color:#eeeeee; text-align: center;">담당학과</th>
						<th style="background-color:#eeeeee; text-align: center;">과목명</th>
						<th style="background-color:#eeeeee; text-align: center;">이수 구분</th>
						<th style="background-color:#eeeeee; text-align: center;">학점</th>
						<th style="background-color:#eeeeee; text-align: center;">이수 등급</th>
						<th style="background-color:#eeeeee; text-align: center;">등록 취소</th>
					</tr>
				</thead>
				<tbody>
             <%
	   			ArrayList<userClassDTO> list=new ArrayList<userClassDTO>();
    	   			
            	list=new userClassDAO().getListClassUser(subjYear, subjSemester, subjMain, search, pageNumber, user.getUserID()); 
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					userClassDTO sub = list.get(i);
	   		%>
				 	<tr>
				 		<td><%= sub.getSubjYear()%></td>
				 		<td><%= sub.getSubjSemester()%></td>
				 		<td><%= sub.getSubjCode()%></td>
			<!--  -->	 		<td><%= sub.getBigDepartName()%></td>
				 		<td><%= sub.getUserDepart()%></td>
				 		<td><%= sub.getSubjName()%></td>
				 		<td><%= sub.getSubjMain()%></td>
				 		<td><%= sub.getSubjScore()%></td>
				 		<td><%= sub.getScore()%></td>
				 		<td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">삭제</button></td>
				 	</tr>
	        <%			
	   				}
	   		%>
				</tbody>
			</table>
		</div>
		<div class="row">
            <div class="col-12">
       
			   
            <a class="btn btn-primary float-right ml-2" href="http://54.180.90.56:8080/excel/excelSample.xlsx">Excel 샘플 다운로드</a>
            <a class="btn btn-primary float-right ml-2" data-toggle="modal" href="#Modal_upload">Excel 업로드</a>
            <a class="btn btn-primary float-right ml-2" data-toggle="modal" href="#Modal">등록</a>
            
            		<script language="javascript">  
		
					function openWin(){  
					    window.open("InsertClassInfo.png", "info새창", "width=800, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
					}   
					</script>  
	               <a class="btn btn-warning float-right ml-2"  onClick="javascript:openWin();">등록 방법</a>
            
            
            </div>
         </div>
		</div>
		
		  
   
   <ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <=0) {
%>
	<a class="page-link disabled">이전</a>
<%
	} else {
%>
	<a class="page-link" href="./InsertClass.jsp?subjYear=<%= URLEncoder.encode(subjYear, "UTF-8") %>&subjSemester=<%= URLEncoder.encode(subjSemester, "UTF-8") %>&subjMain=<%= URLEncoder.encode(subjMain, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>	
		<li>
<%
	if(list.size()<10) {  
%>
	<a class="page-link disabled">다음</a>
<%
	} else {
%>
	<a class="page-link" href="./InsertClass.jsp?subjYear=<%= URLEncoder.encode(subjYear, "UTF-8") %>&subjSemester=<%= URLEncoder.encode(subjSemester, "UTF-8") %>&subjMain=<%= URLEncoder.encode(subjMain, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
<%
	}
%>

		</li>
	</ul>   
	</section>
	


 <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="modal">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./userClassAdd" method="post">
               		<div class="form-group">
						<label>개설년도</label>
						<select name="subjYear" id="subjYear" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 년도를 선택해주세요. --</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
							<option value="2023">2023</option>
						</select>
					</div>
               		<div class="form-group">
						<label>개설학기</label>
						<select  name="subjSemester" id="subjSemester" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 학기를 선택해주세요. --</option>
							<option value="1학기">1학기</option>
							<option value="여름학기">여름학기</option>
							<option value="2학기">2학기</option>
							<option value="겨울학기">겨울학기</option>
						</select>
					</div>
               		<div class="form-group">
						<label>이수구분</label>
						<select  name="subjMain" id="subjMain" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 이수구분을 선택해주세요. --</option>
							<option value="전필">전필</option>
							<option value="전선">전선</option>
							<option value="전탐">전탐</option>
							<option value="교필">교필</option>
							<option value="교선">교선</option>
							<option value="부전필">부전필</option>
							<option value="부전선">부전선</option>
							<option value="복필">복필</option>
							<option value="복선">복선</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div class="form-group">
						<label>과목코드</label>
						<input type="text" name="subjCode" id="subjCode" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>과목명</label>
						<input type="text" name="subjName" id="subjName" class="form-control" placeholder="과목명 입력란">
					</div>
					
					<div class="form-group">
						<label>점수</label>
						<select  name="grade" id="grade" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 점수을 선택해주세요. --</option>
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="P">9</option>
							<option value="10">10</option>
						</select>
					</div>
                     
               		<div class="form-group">
						<label>이수학점</label>
						<select  name="score" id="score" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 이수학점을 선택해주세요. --</option>
							<option value="A+">A+</option>
							<option value="A0">A0</option>
							<option value="B+">B+</option>
							<option value="B0">B0</option>
							<option value="C+">C+</option>
							<option value="C0">C0</option>
							<option value="D+">D+</option>
							<option value="D0">D0</option>
							<option value="F">F</option>
							<option value="P">P</option>
							<option value="N">N</option>
						</select>
					</div>
						<input type="hidden" name="userID" value="<%= user.getUserID() %>">
						<input type="hidden" name="grade" value=null>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
   
   <div class="modal fade" id="Modal_upload" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="modal">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./userClassAdd?userID=<%= user.getUserID() %>" method="post" enctype="multipart/form-data">
                     <div class="form-group">
                        <input type="file" name="file" />
               </div>
               <%-- <input type="hidden" name="userID" value="<%= user.getUserID() %>"> --%>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
	
   <script>
		// 버튼 클릭시 Row 값 가져오기
	   $(".checkBtn1").click(function(){ 
	       
	       var str = ""
	       var tdArr = new Array();    // 배열 선언
	       var checkBtn = $(this);
	       
	       // checkBtn.parent() : checkBtn의 부모는 <td>이다.
	       // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
	       var tr = checkBtn.parent().parent();
	       var td = tr.children();

	       var subjYear = td.eq(0).text();
	       var subjSemester = td.eq(1).text();
	       var subjCode = td.eq(2).text();

           document.getElementById("checkId").value=subjYear;
           document.getElementById("checkId2").value=subjSemester;
           document.getElementById("checkId3").value=subjCode;
	       $('#checkModal').modal("show");
	    
	   });
   </script>  
       
  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content panel-info" id="checkType"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header panel-heading"> <!-- 모달의 제목 -->
               <h5 class="modla-title">알림</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
					<div class="modal-body" id="checkMessage">
					<form  action="./userClassDel" method="post">
					<label>삭제를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<input type="hidden" name="checkId2" id="checkId2"class="form-control">
						<input type="hidden" name="checkId3" id="checkId3"class="form-control">
						<input type="hidden" name="checkId4" value="<%= user.getUserID() %>">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">삭제하기</button></div>
					</form>
					</div>
				</div>
			</div>
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