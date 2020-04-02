<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="departr.DepartrDTO" %>
<%@ page import="departr.DepartrDAO" %>
<%@ page import="subj.SubjDTO" %>
<%@ page import="subj.SubjDAO" %>
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
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<link href="./css/select2.css" rel="stylesheet">
	<script src="./js/select2.js"></script>

<script>
    $(document).ready(function () {
        $("#subjCode").select2();
    });
</script>
</head>
<body>
<%
	String userID=null;
	String search="";
	String userDepart="";
	int pageNumber=0;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(request.getParameter("userDepart")!=null){
		userDepart=request.getParameter("userDepart");
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
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
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
            
            
         <li class="nav-item dropdown"><!-- 눌렀을때 아래쪽으로 목록 나오게 하는 것 -->
            <!-- 한번 눌렀을때 요소가 나오고 다시 누르면 사라진다. -->
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                  회원 관리
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="userModify.jsp">내등록정보</a>
               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            </div>
         </li>
           <li class="nav-item dropdown"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
           <a class="nav-link active dropdown-toggle" id="dropdown" data-toggle="dropdown">
                관리자
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="adminStudent.jsp">관리자 학생 관리</a>
               <a class="dropdown-item" href="adminPlus.jsp">관리자 추가</a>
               <a class="dropdown-item" href="adminDepart.jsp">전공인정 관리</a>
               <a class="dropdown-item" href="InsertInstead.jsp">대체과목 관리</a>
               <a class="dropdown-item active" href="WriteGradu.jsp">필수과목 관리</a>
               <a class="dropdown-item" href="WriteCulture.jsp">핵심역량 교양 관리</a>
            </div>
      </li>
      </ul>
   </div>
   </nav><!-- 상단바 -->
   
   <section class="container"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
      <form method="get" action="./WriteGradu.jsp" class="form-inline mt-3"> 
		<select name="userDepart" class="form-control mx-1 mt-2">
            <option value="전체">전체학과</option>
					<option value="인문융합 자율학부" <% if(userDepart.equals("인문융합 자율학부")) out.println("selected"); %>>인문융합 자율학부</option>
					<option value="사회융합 자율학부" <% if(userDepart.equals("사회융합 자율학부")) out.println("selected"); %>>사회융합 자율학부</option>
					<option value="미디어컨텐츠융합 자율학부" <% if(userDepart.equals("미디어컨텐츠융합 자율학부")) out.println("selected"); %>>미디어컨텐츠융합 자율학부</option>
					<option value="IT융합 자율학부" <% if(userDepart.equals("IT융합 자율학부")) out.println("selected"); %>>IT융합 자율학부</option>
					<option value="신학과" <% if(userDepart.equals("신학과")) out.println("selected"); %>>신학과</option>
					<option value="영어학과" <% if(userDepart.equals("영어학과")) out.println("selected"); %>>영어학과</option>
					<option value="일어일본학과" <% if(userDepart.equals("일어일본학과")) out.println("selected"); %>>일어일본학과</option>
					<option value="중어중국학과" <% if(userDepart.equals("중어중국학과")) out.println("selected"); %>>중어중국학과</option>
					<option value="사회복지학과" <% if(userDepart.equals("사회복지학과")) out.println("selected"); %>>사회복지학과</option>
					<option value="사회과학부" <% if(userDepart.equals("사회과학부")) out.println("selected"); %>>사회과학부</option>
					<option value="신문방송학과" <% if(userDepart.equals("신문방송학과")) out.println("selected"); %>>신문방송학과</option>
					<option value="경영학부" <% if(userDepart.equals("경영학부")) out.println("selected"); %>>경영학부</option>
					<option value="디지털컨텐츠학과" <% if(userDepart.equals("디지털컨텐츠학과")) out.println("selected"); %>>디지털컨텐츠학과</option>
					<option value="컴퓨터공학과" <% if(userDepart.equals("컴퓨터공학과")) out.println("selected"); %>>컴퓨터공학과</option>
					<option value="소프트웨어공학과" <% if(userDepart.equals("소프트웨어공학과")) out.println("selected"); %>>소프트웨어공학과</option>
					<option value="정보통신공학과" <% if(userDepart.equals("정보통신공학과")) out.println("selected"); %>>정보통신공학과</option>
					<option value="글로컬IT학과" <% if(userDepart.equals("글로컬IT학과")) out.println("selected"); %>>글로컬IT학과</option>
         </select>
         <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="과목코드를 입력하세요.">
         <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      </form>
      
      <div class="container">
      <div class="row">
         <table class="table table-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color:#eeeeee; text-align: center;">강의명</th>
                  <th style="background-color:#eeeeee; text-align: center;">과목코드</th>
                  <th style="background-color:#eeeeee; text-align: center;">학과</th>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                  <th style="background-color:#eeeeee; text-align: center;">학년</th>
                  <th style="background-color:#eeeeee; text-align: center;">학기</th>
                  <th style="background-color:#eeeeee; text-align: center;">분류</th>
                  <th style="background-color:#eeeeee; text-align: center;">수정</th>
                  <th style="background-color:#eeeeee; text-align: center;">등록 취소</th>
               </tr>
            </thead>
            <tbody>
            <%
	   			ArrayList<DepartrDTO> list=new ArrayList<DepartrDTO>();
    	   			
            	list=new DepartrDAO().getListDepartr(userDepart, search, pageNumber);
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					DepartrDTO dep = list.get(i);
	   		%>
	   			<tr>
	   				<td><%= dep.getSubjName() %></td>
	   				<td><%= dep.getSubjCode() %></td>
	   				<td><%= dep.getUserDepart() %></td>
	   				<td><%= dep.getUserAdmission() %></td>
	   				<td><%= dep.getSubjGrade() %></td>
	   				<td><%= dep.getSubjSemester() %></td>
	   				<td><%= dep.getSubjDivision() %></td>
	   				
                    <td><button class="checkBtn btn btn-outline-success" type="submit">수정</button></td> 
                    <td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">삭제</button></td> 
	   			</tr>
	   		<%
	   				}
	   		%>
            </tbody>
         </table>
      </div>
         <div class="row">
            <div class="col-12"><a class="btn btn-primary float-right" data-toggle="modal" href="#Modal">등록</a></div>
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
	<a class="page-link" href="./WriteGradu.jsp?userDepart=<%= URLEncoder.encode(userDepart, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>	
		<li>
<%
	if(list.size()<5) { //강의평가가 6개 이상 존재한다면 다음 페이지가 존재한다는 것이기 때문에(한 페이지에 5개까지 보임)
%>
	<a class="page-link disabled">다음</a>
<%
	} else {
%>
	<a class="page-link" href="./WriteGradu.jsp?userDepart=<%= URLEncoder.encode(userDepart, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
<%
	}
%>

		</li>
	</ul>
	
	<script>
		// 버튼 클릭시 Row 값 가져오기
	   $(".checkBtn").click(function(){ 
		   var str = "";
	       var tdArr = new Array();    // 배열 선언
	       var checkBtn = $(this);
	       
	        //checkBtn.parent() : checkBtn의 부모는 <td>이다.
	        //checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
	       var tr = checkBtn.parent().parent();
	       var td = tr.children();
	       
	       console.log("클릭한 Row의 모든 데이터 : "+tr.text());
	       
	       var subjName = td.eq(0).text();
	       var subjCode = td.eq(1).text();
	       var userDepart = td.eq(2).text();
	       var userAdmission = td.eq(3).text();
	       var subjGrade = td.eq(4).text();
	       var subjSemester = td.eq(5).text();
	       var subjDivision = td.eq(6).text();
	       
	       
	      
	       document.getElementById("subjname").value=subjName;
	       document.getElementById("subjcode").value=subjCode;
	       document.getElementById("userdepart").value=userDepart;
	       document.getElementById("useradmission").value=userAdmission;
	       document.getElementById("subjgrade").value=subjGrade;
	       document.getElementById("subjsemester").value=subjSemester;
	       document.getElementById("subjdivision").value=subjDivision;
	       
	       
	       
  			$('#exampleModal').modal("show");
  			    
	       
	   });
   </script>  
	
   
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
	       
	//       var subjName = td.eq(0).text();
	       var subjCode = td.eq(1).text();
	       var userAdmission = td.eq(3).text();
/*	       var userDepart = td.eq(2).text();
	       var userAdmission = td.eq(3).text();
	       var subjGrade = td.eq(4).text();
	       var subjSemester = td.eq(5).text();*/

           document.getElementById("checkId").value=subjCode;
           document.getElementById("checkId2").value=userAdmission;
	       $('#checkModal').modal("show");
	    
	   });
   </script>  
	
	
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
               <form action="./departrAdd" method="post"><!-- 학과, 학번, 학년, 학기, 과목코드, 강의명, 학점 -->
		               
					<div class="form-group">
						<label>학과</label>
						<select name="userDepart" id="userDepart" class="form-control">
							<option value="" disabled>-- 학과를 선택해주세요. --</option>
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
							<option value="컴퓨터공학과"selected>컴퓨터공학과</option>
							<option value="소프트웨어공학과">소프트웨어공학과</option>
							<option value="정보통신공학과">정보통신공학과</option>
							<option value="글로컬IT학과">글로컬IT학과</option>
						</select>
					</div>
					<div class="form-group">
						<label>학번</label>
						<select name="userAdmission" id="userAdmission" class="form-control mx-1 mt-2">
								<option value="" disabled selected>-- 학번을 선택해주세요. --</option>
		                        <option value="2013">13학번</option>
		                        <option value="2014">14학번</option>
		                        <option value="2015">15학번</option>
		                        <option value="2016">16학번</option>
		                        <option value="2017">17학번</option>
		                        <option value="2018">18학번</option>
		                </select>
					</div>
					<div class="form-group">
						<label>학년</label>
						<select name="subjGrade" id="subjGrade" class="form-control">
							<option value="" disabled selected>-- 학년을 선택해주세요. --</option>
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
							<option value="4">4학년</option>
						</select>
					</div>
					<div class="form-group">
						<label>이수학기</label>
						<select name="subjSemester" id="subjSemester" class="form-control">
							<option value="" disabled selected>-- 학기를 선택해주세요. --</option>
							<option value="1학기">1학기</option>
							<option value="2학기">2학기</option>
						</select>
					</div>
					<div class="form-group">
						<label>과목코드</label>
						<select  name="subjCode" id="subjCode">
				            <%
				   				ArrayList<SubjDTO> list2=new ArrayList<SubjDTO>();
				            	list2=new SubjDAO().getListSubj2();
					   			if(list2 != null)
					   				for(int i=0; i < list2.size(); i++){
					   					SubjDTO dep = list2.get(i);
					   		%>
					   			<option value="<%=dep.getSubjCode()%>"><%=dep.getSubjName() %>(<%=dep.getSubjCode() %>)</option>
					   		<%
					   				}
					   		%>
						</select>
					<!-- 	<input type="text" name="subjCode" id="subjCode" class="form-control" placeholder="과목코드 입력란"> -->
					</div>
					
					<div class="form-group">
						
						<label>분류</label>
						<div class="radio">
						  <label>
						    <input type="radio" name="subjDivision" id="subjDivision" value="전필" checked>전필
						  </label>
						</div>
						<div class="radio">
						  <label>
						    <input type="radio" name="subjDivision" id="subjDivision" value="교필">교필
						  </label>
						</div>
					</div>	
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-danger">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
    
   </section>


	
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	      <h5 class="modal-title" id="exampleModalLabel">수정하기</h5>
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
		
	      </div>
	      <div class="modal-body">
		<form  action="./departrUpdate" method="post">
		<div class="form-group">
		
					<div class="form-group">
						<label>강의명</label>
						<input type="text" name="subjname" id="subjname"class="form-control">
					</div>
		</div>
			<div class="form-group">
			
						<label>학과</label>
						<select name="userdepart" id="userdepart" class="form-control">
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
						<label>학번</label>
						<select name="useradmission" id="useradmission" class="form-control mx-1 mt-2">
								<option value="" disabled selected>-- 학번을 선택해주세요. --</option>
		                        <option value="2013">13학번</option>
		                        <option value="2014">14학번</option>
		                        <option value="2015">15학번</option>
		                        <option value="2016">16학번</option>
		                        <option value="2017">17학번</option>
		                        <option value="2018">18학번</option>
		                </select>
					</div>
					<div class="form-group">
						<label>학년</label>
						<select name="subjgrade" id="subjgrade" class="form-control">
							<option value="" disabled selected>-- 학년을 선택해주세요. --</option>
							<option value="1">1학년</option>
							<option value="2">2학년</option>
							<option value="3">3학년</option>
							<option value="4">4학년</option>
						</select>
					</div>
					<div class="form-group">
						<label>이수학기</label>
						<select name="subjsemester" id="subjsemester" class="form-control">
							<option value="" disabled selected>-- 학기를 선택해주세요. --</option>
							<option value="1학기">1학기</option>
							<option value="2학기">2학기</option>
						</select>
					</div>
					<div class="form-group">
						<label>과목코드</label>
						<input type="text" name="subjcode" id="subjcode" class="form-control" placeholder="과목코드 입력란">
					</div>
					
					<div class="form-group">
						<label>이수학기</label>
						<select name="subjdivision" id="subjdivision" class="form-control">
							<option value="" disabled selected>-- 학기를 선택해주세요. --</option>
							<option value="전필">전필</option>
							<option value="교필">교필</option>
						</select>
					</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary">수정하기</button>
	      </div>
		</form>
	      </div>
	     
	    </div>
	  </div>
	</div>


  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content panel-info" id="checkType"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header panel-heading"> <!-- 모달의 제목 -->
               <h5 class="modla-title">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
					<div class="modal-body" id="checkMessage">
					<form  action="./departrDel" method="post">
					<label>삭제를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<input type="hidden" name="checkId2" id="checkId2"class="form-control">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">삭제하기</button></div>
					</form>
					</div>
				</div>
			</div>
		</div>
   

   
   <!-- 
<script>
$(document).ready(function() {
	$('#exampleModal').on('show.bs.modal', function (event) {
		  var button = $(event.relatedTarget); // Button that triggered the modal
		  var recipient = button.data('whatever'); // Extract info from data-* attributes
		  var modal = $(this);
		  modal.find('.modal-body input').val(recipient);
	});
});
</script>  -->

   <!-- 가장 아래쪽에 들어가는 내용 -->
	<footer class="bg-dark mt-4 p-3 text-center fixed-bottom" style="color: #FFFFFF;">
   <!-- 저작권 표시 -->
      Copyright &copy; 2018 HADA All Rights Reserved.
   </footer>
   
   <!-- 파퍼 자바스크립트 추가하기 -->
   <script src="./js/pooper.js"></script>
   <!-- 부트스트랩 자바스크립트 추가하기 -->
   <script src="./js/bootstrap.min.js"></script>

</body>
</html>