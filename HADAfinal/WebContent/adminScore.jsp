<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="departr.DepartrDTO" %>
<%@ page import="departr.DepartrDAO" %>
<%@ page import="adminScore.adminScoreDTO" %>
<%@ page import="adminScore.adminScoreDAO" %>
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
	           <a class="nav-link dropdown-toggle active" id="dropdown" data-toggle="dropdown">
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
	               <a class="dropdown-item active" href="adminScore.jsp">졸업점수 관리</a>
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
      
      
      <div class="container">
      <div class="row">
       <h4 class="mt-2">컴퓨터공학과</h4>
         <table class="table table-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
               	  <th style="background-color:#eeeeee; text-align: center;">학과</th>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                  <th style="background-color:#eeeeee; text-align: center;">특별과정</th>
                  <th style="background-color:#eeeeee; text-align: center;">총교양점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총교필점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전공점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전필점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총졸업점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총핵심역량점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전공탐색점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">수정</th>
                  <th style="background-color:#eeeeee; text-align: center;">삭제</th>
               </tr>
            </thead>
            <tbody>
            <%
	   			ArrayList<adminScoreDTO> list=new ArrayList<adminScoreDTO>();
    	   			
            	list=new adminScoreDAO().getList();
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					adminScoreDTO dep = list.get(i);
	   		%>
	   			<tr>
	   			<%if(dep.getUserDepart().equals("컴퓨터공학과") ){%>
	   				<td><%= dep.getUserDepart() %></td>
	   				<td><%= dep.getUserAdmission() %></td>
	   				<td><%= dep.getUserProcess() %></td>
	   				<td><%= dep.getTotalCulture() %></td>
	   				<td><%= dep.getTotalCultureNecessary() %></td>
	   				<td><%= dep.getTotalMajor() %></td>
	   				<td><%= dep.getTotalMajorNecessary() %></td>
	   				<td><%= dep.getTotalGraduate() %></td>
	   				<td><%= dep.getTotalAbility() %></td>
	   				<td><%= dep.getTotalFindMajor() %></td><!-- 전탐 -->
	   				
                    <td><button class="checkBtn btn btn-outline-success" type="submit">수정</button></td> 
                    <td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">삭제</button></td> 
	   			</tr>
	   		<%
	   			}
	   				}
	   		%>
            </tbody>
         </table>
         
         
         
          <h4 class="mt-4">타과</h4>
         <table class="table table-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
               	  <th style="background-color:#eeeeee; text-align: center;">학과</th>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                  <th style="background-color:#eeeeee; text-align: center;">특별과정</th>
                  <th style="background-color:#eeeeee; text-align: center;">총교양점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총교필점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전공점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전필점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총졸업점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총역량강화점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">총전공탐색점수</th>
                  <th style="background-color:#eeeeee; text-align: center;">수정</th>
                  <th style="background-color:#eeeeee; text-align: center;">삭제</th>
               </tr>
            </thead>
            <tbody>
            <%
    	   			
            	list=new adminScoreDAO().getList();
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					adminScoreDTO dep = list.get(i);
	   		%>
	   			<tr>
	   			<%if(!dep.getUserDepart().equals("컴퓨터공학과")){%>
	   				<td><%= dep.getUserDepart() %></td>
	   				<td><%= dep.getUserAdmission() %></td>
	   				<td><%= dep.getUserProcess() %></td>
	   				<td><%= dep.getTotalCulture() %></td>
	   				<td><%= dep.getTotalCultureNecessary() %></td>
	   				<td><%= dep.getTotalMajor() %></td>
	   				<td><%= dep.getTotalMajorNecessary() %></td>
	   				<td><%= dep.getTotalGraduate() %></td>
	   				<td><%= dep.getTotalAbility() %></td>
	   				<td><%= dep.getTotalFindMajor() %></td><!-- 전탐 -->
	   				
                    <td><button class="checkBtn btn btn-outline-success" type="submit">수정</button></td> 
                    <td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">삭제</button></td> 
	   			</tr>
	   		<%}
	   				}
	   		%>
            </tbody>
         </table>
      </div>
         <div class="row">
            <div class="col-12"><a class="btn btn-primary float-right" data-toggle="modal" href="#Modal">등록</a></div>
         </div>
      </div>
      
  
	
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
	       
	       var userDepart = td.eq(0).text();
	       var userAdmission = td.eq(1).text();
	       var userProcess = td.eq(2).text();
	       var totalCulture = td.eq(3).text();
	       var totalCultureNecessary = td.eq(4).text();
	       var totalMajor = td.eq(5).text();
	       var totalMajorNecessary = td.eq(6).text();
	       var totalGraduate = td.eq(7).text();
	       var totalAbility = td.eq(8).text();
	       var totalFindMajor = td.eq(9).text();
	       
	      
	       document.getElementById("userdepart").value=userDepart;
	       document.getElementById("useradmission").value=userAdmission;
	       document.getElementById("userprocess").value=userProcess;
	       document.getElementById("totalculture").value=totalCulture;
	       document.getElementById("totalcultureNecessary").value=totalCultureNecessary;
	       document.getElementById("totalmajor").value=totalMajor;
	       document.getElementById("totalmajorNecessary").value=totalMajorNecessary;
	       document.getElementById("totalgraduate").value=totalGraduate;
	       document.getElementById("totalability").value=totalAbility;
	       document.getElementById("totalfindMajor").value=totalFindMajor;
	       
	       
	       
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
	       

	       var userDepart = td.eq(0).text();
	       var userAdmission = td.eq(1).text();
	       var userProcess = td.eq(2).text();

           document.getElementById("checkId").value=userDepart;
           document.getElementById("checkId2").value=userAdmission;
           document.getElementById("checkId3").value=userProcess;
           
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
               <form action="./adminScoreAdd" method="post"><!-- 학과, 학번, 학년, 학기, 과목코드, 강의명, 학점 -->
		               
					<div class="form-group">
						<label>학과</label>
						<select name="userDepart" id="userDepart" class="form-control">
							<option value="" disabled>-- 학과를 선택해주세요. --</option>
							<option value="컴퓨터공학과"selected>컴퓨터공학과</option>
							<option value="타과">타과</option>
						</select>
					</div>
					<div class="form-group">
						<label>학번</label>
						<select name="userAdmission" id="userAdmission" class="form-control">
							<option value="" disabled>-- 학번을 선택해주세요. --</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
						</select>
					</div>
					<div class="form-group">
						<label>특별과정</label>
						<select name="userProcess" id="userProcess" class="form-control">
							<option value="" disabled selected>-- 특별과정을 선택해주세요. --</option>
							<option value="주전공">주전공</option>
							<option value="복수전공">복수전공</option>
							<option value="부전공">부전공</option>
							<option value="전과">전과</option>
							<option value="편입">편입</option>
						</select>
					</div>
					<div class="form-group">
						<label>총교양점수</label>
						<input type="text" name="totalCulture" id="totalCulture" class="form-control" placeholder="총교양점수 입력란">
					</div>
					<div class="form-group">
						<label>총교필점수</label>
						<input type="text" name="totalCultureNecessary" id="totalCultureNecessary" class="form-control" placeholder="총교필점수 입력란">
					</div>
					<div class="form-group">
						<label>총전공점수</label>
						<input type="text" name="totalMajor" id="totalMajor" class="form-control" placeholder="총전공점수 입력란" >
					</div>
					<div class="form-group">
						<label>총전필점수</label>
						<input type="text" name="totalMajorNecessary" id="totalMajorNecessary" class="form-control" placeholder="총전필점수 입력란">
					</div>
					<div class="form-group">
						<label>총졸업점수</label>
						<input type="text" name="totalGraduate" id="totalGraduate" class="form-control" placeholder="총졸업점수 입력란">
					</div>
					<div class="form-group">
						<label>총역량강화점수</label>
						<input type="text" name="totalAbility" id="totalAbility" class="form-control" placeholder="총역량강화점수 입력란"value="0">
					</div>
					<div class="form-group">
						<label>총전공탐색점수</label>
						<input type="text" name="totalFindMajor" id="totalFindMajor" class="form-control" placeholder="총전공탐색점수 입력란"value="0">
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
		<form  action="./adminScoreUpdate" method="post">
		<div class="form-group">
						<label>학과</label>
						<select name="userdepart" id="userdepart" class="form-control" >
							<option value="" disabled>-- 학과를 선택해주세요. --</option> 
							<option value="컴퓨터공학과">컴퓨터공학과</option>
							<option value="타과">타과</option>
						</select>
					</div>
					<div class="form-group">
						<label>학번</label>
						<select name="useradmission" id="useradmission" class="form-control">
							<option value="" disabled>-- 학번을 선택해주세요. --</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
						</select>
					</div>
					<div class="form-group">
						<label>특별과정</label>
						<select name="userprocess" id="userprocess" class="form-control">
							<option value="" disabled>-- 특별과정을 선택해주세요. --</option> 
							<option value="주전공">주전공</option>
							<option value="복수전공">복수전공</option>
							<option value="부전공">부전공</option>
							<option value="전과">전과</option>
							<option value="편입">편입</option>
						</select>
					</div>
					<div class="form-group">
						<label>총교양점수</label>
						<input type="text" name="totalculture" id="totalculture" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>총교필점수</label>
						<input type="text" name="totalcultureNecessary" id="totalcultureNecessary" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>총전공점수</label>
						<input type="text" name="totalmajor" id="totalmajor" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>총전필점수</label>
						<input type="text" name="totalmajorNecessary" id="totalmajorNecessary" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>총졸업점수</label>
						<input type="text" name="totalgraduate" id="totalgraduate" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>총역량강화점수</label>
						<input type="text" name="totalability" id="totalability" class="form-control" placeholder="과목코드 입력란">
					</div>
					
					<div class="form-group">
						<label>총전공탐색점수</label>
						<input type="text" name="totalfindMajor" id="totalfindMajor" class="form-control" placeholder="총전공탐색점수 입력란">
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
					<form  action="./adminScoreDel" method="post">
					<label>삭제를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<input type="hidden" name="checkId2" id="checkId2"class="form-control">
						<input type="hidden" name="checkId3" id="checkId3"class="form-control">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">삭제하기</button></div>
					</form>
					</div>
				</div>
			</div>
		</div>
   

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://googledrive.com/host/0B-QKv6rUoIcGREtrRTljTlQ3OTg"></script><!-- ie10-viewport-bug-workaround.js -->
<script src="http://googledrive.com/host/0B-QKv6rUoIcGeHd6VV9JczlHUjg"></script><!-- holder.js -->

   
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
   
   <!-- 제이쿼리 자바스크립트 추가하기 -->
   <script src="./js/jquery.min.js"></script>
   <!-- 파퍼 자바스크립트 추가하기 -->
   <script src="./js/pooper.js"></script>
   <!-- 부트스트랩 자바스크립트 추가하기 -->
   <script src="./js/bootstrap.min.js"></script>

</body>
</html>