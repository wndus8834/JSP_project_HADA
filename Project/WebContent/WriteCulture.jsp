<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
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
	String coreCapaName="";
	int pageNumber=0;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(request.getParameter("coreCapaName")!=null){
		coreCapaName=request.getParameter("coreCapaName");
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
	               <a class="dropdown-item active" href="WriteCulture.jsp">핵심역량 교양 관리</a>
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
   
      
      <form method="get" action="./WriteCulture.jsp" class="form-inline mt-3">
      
		<select name="coreCapaName" class="form-control mx-1 mt-2">
            <option value="전체">전체 과정</option>
					<option value="가치역량" <% if(coreCapaName.equals("가치역량")) out.println("selected"); %>>가치역량</option>
					<option value="대안역량" <% if(coreCapaName.equals("대안역량")) out.println("selected"); %>>대안역량</option>
					<option value="실천역량" <% if(coreCapaName.equals("실천역량")) out.println("selected"); %>>실천역량</option>

         </select>
         <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="강의명을 입력하세요.">
         <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      </form>
      
      <div class="container">
      <div class="row">
         <table class="table table-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color:#eeeeee; text-align: center;">년도</th>
                  <th style="background-color:#eeeeee; text-align: center;">학기</th>
                  <th style="background-color:#eeeeee; text-align: center;">과목코드</th>
                  <th style="background-color:#eeeeee; text-align: center;">핵심역량</th>
                  <th style="background-color:#eeeeee; text-align: center;">세부영역</th>
                  <th style="background-color:#eeeeee; text-align: center;">강의명</th>
                  <th style="background-color:#eeeeee; text-align: center;">학점</th>
                  <th style="background-color:#eeeeee; text-align: center;">수정</th>
                  <th style="background-color:#eeeeee; text-align: center;">등록 취소</th>
               </tr>
            </thead>
            <tbody>
            
            <%
	   			ArrayList<SubjDTO> list=new ArrayList<SubjDTO>();
    	   			
            	list=new SubjDAO().getListCapa(coreCapaName, search, pageNumber);
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					SubjDTO dep = list.get(i);
	   		%>
	   			<tr> 
	   				<td><%= dep.getSubjYear() %></td>
	   				<td><%= dep.getSubjSemester() %></td>
	   				<td><%= dep.getSubjCode() %></td>
	   				<td><%= dep.getCoreCapaName() %></td>
	   				<td><%= dep.getDetailAreaName() %></td>
	   				<td><%= dep.getSubjName() %></td>
	   				<td><%= dep.getSubjScore() %></td>
	   				
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
            <div class="col-12">
            <a class="btn btn-primary float-right" data-toggle="modal" href="#Modal">등록</a>
            
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
	<a class="page-link" href="./WriteCulture.jsp?coreCapaName=<%= URLEncoder.encode(coreCapaName, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
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
	<a class="page-link" href="./WriteCulture.jsp?coreCapaName=<%= URLEncoder.encode(coreCapaName, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
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
	       
	       var subjCode = td.eq(2).text();
	       var coreCapaName = td.eq(3).text();
	       var detailAreaName = td.eq(4).text();
	       var subjName = td.eq(5).text();
	       
	       
	      
	       document.getElementById("subjcode").value=subjCode;
	       document.getElementById("corecapaName").value=coreCapaName;
	       document.getElementById("detailareaName").value=detailAreaName;
	       document.getElementById("subjname").value=subjName;
	       
	       
	       
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
	       
	       var subjCode = td.eq(2).text();
	       var coreCapaName = td.eq(3).text();
	       var detailAreaName = td.eq(4).text();
	     //  var subjName = td.eq(3).text();
	     //  var subjScore = td.eq(4).text();

	       document.getElementById("checkId").value=subjCode;
           document.getElementById("checkId2").value=coreCapaName;
           document.getElementById("checkId3").value=detailAreaName;
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
               <form action="./cultureAdd" method="post">
               		<div class="form-group">
               			<label>핵심역량</label>
               			<select id="coreCapaName" name="coreCapaName" class="form-control mx-1 mt-2">
                        <option value="전체" disabled selected>전체 핵심역량</option>
                        <option value="가치역량">가치역량</option>
                        <option value="대안역량">대안역량</option>
                        <option value="실천역량">실천역량</option>
                        </select>
               		</div>
               		<div class="form-group">
               			<label>세부영역</label>
               			<select id="detailAreaName" name="detailAreaName" class="form-control mx-1 mt-2">
                        <option value="전체" disabled selected>전체 세부영역</option>
                        <option value="인간인권">인간인권</option>
                        <option value="생명평화">생평∙평화</option>
                        <option value="민주시민">민주시민</option>
                        <option value="융복합적사고">융∙복학적사고</option>
                        <option value="조사분석정보활용">조사분석∙정보활용</option>
                        <option value="대안제시문제해결">대안제시∙문제해결</option>
                        <option value="민주적소통">민주적소통</option>
                        <option value="연대와공동체">연대와 공동체적 실천</option>
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
					   					if(dep.getSubjYear().equals("2018")){
					   		%>
					   			<option value="<%=dep.getSubjCode()%>"><%=dep.getSubjName() %>(<%=dep.getSubjCode() %>)</option>
					   		<%
					   				}
					   			}
					   		%>
						</select>
               		</div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
   
      
   <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="exampleModalLabel">수정하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./cultureUpdate" method="post">
               		<div class="form-group">
               			<label>핵심역량</label>
               			<select id="corecapaName" name="corecapaName" class="form-control mx-1 mt-2">
                        <option value="전체" disabled selected>전체 핵심역량</option>
                        <option value="가치역량">가치역량</option>
                        <option value="대안역량">대안역량</option>
                        <option value="실천역량">실천역량</option>
                        </select>
               		</div>
               		<div class="form-group">
               			<label>세부영역</label>
               			<select id="detailareaName" name="detailareaName" class="form-control mx-1 mt-2">
                        <option value="전체" disabled selected>전체 세부영역</option>
                        <option value="인간인권">인간인권</option>
                        <option value="생명평화">생평_평화</option>
                        <option value="민주시민">민주시민</option>
                        <option value="융복합적사고">융_복학적사고</option>
                        <option value="조사분석정보활용">조사분석_정보활용</option>
                        <option value="대안제시문제해결">대안제시_문제해결</option>
                        <option value="민주적소통">민주적소통</option>
                        <option value="연대와공체적실천">연대와_공동체적_실천</option>
                        </select>
               			
               		</div>
               		<div class="form-group">
               			<label>과목코드</label>
               			<input type="text" id="subjcode" name="subjcode" class="form-control"placeholder="과목코드 입력란" readonly>
               		</div>
               		<div class="form-group">
               			<label>강의명</label>
               			<input type="text" id="subjname" name="subjname" class="form-control" placeholder="강의명 입력란"readonly>
               		</div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
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
               <h5 class="modla-title">알림</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
					<div class="modal-body" id="checkMessage">
					<form  action="./cultureDel" method="post">
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
   </section>

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