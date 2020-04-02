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
<style>
.navbar-nav li:hover > ul.dropdown-menu {
    display: block;
}
.dropdown-submenu {
    position:relative;
}
.dropdown-submenu>.dropdown-menu {
    top:0;
    left:100%;
    margin-top:-6px;
}

/* rotate caret on hover */
.dropdown-menu > li > a:hover:after {
    text-decoration: underline;
    transform: rotate(-90deg);
} 
</style>
<script type="text/javascript">
   function delFunction(){
      UserDAO.delUser(request.getParmeter("userID"));
      //UserDAO.delUsesr("userID");
      String message="삭제되지 않았습니다.";
      if(result>0){
         message="삭제되었습니다.";
      }
   }
</script>
</head>
<body>
<%
   String search="";    //검색 학번  
	String userGrade="전체";  //검색 학년
   String userSemester="전체";  //검색 이수학기
   String userDepart="전체"; //검색 학과
   
   int pageNumber =0;
   String userID=null;
   
   if(session.getAttribute("userID")!=null){             //세션 userID
	      userID=(String)session.getAttribute("userID");
	   }
	   if(request.getParameter("search")!=null){             //검색으로 받아오는 학번
	      search=request.getParameter("search");
	   }
	   if(request.getParameter("userGrade")!=null){             //검색으로 받아오는 학년
	      userGrade=request.getParameter("userGrade");
	   }
	   if(request.getParameter("userSemester")!=null){             //검색으로 받아오는 이수학기
	      userSemester=request.getParameter("userSemester");
	   }
	   if(request.getParameter("userDepart")!=null){             //검색으로 받아오는 학과
	      userDepart=request.getParameter("userDepart");
	   }
   
   
   if(request.getParameter("pageNumber")!=null){         //페이징 처리
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
               <a class="dropdown-item active" href="adminStudent.jsp">학생 관리</a>
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
      <form method="get" action="./adminStudent.jsp" class="form-inline mt-3">
         <select name="userGrade" class="form-control mx-1 mt-2">
            <option value="전체">학년</option>
              <option value="1">1학년</option>
         <option value="2">2학년</option>
         <option value="3">3학년</option>
         <option value="4">4학년</option>
         </select>
         <select name="userSemester" class="form-control mx-1 mt-2">
            <option value="전체" selected>이수학기</option>
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
         <select name="userDepart" class="form-control mx-1 mt-2">
            <option value="전체">학과</option>
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
         
         <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="이름을 입력하세요.">
         <button type="submit" class="btn btn-primary mx-1 mt-2">조회</button>
      </form>
      
      <div class="container">
      <div class="row">
         <table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                  <th style="background-color:#eeeeee; text-align: center;">이름</th>
                  <th style="background-color:#eeeeee; text-align: center;">학년</th>
                  <th style="background-color:#eeeeee; text-align: center;">이수학기</th>
                  <th style="background-color:#eeeeee; text-align: center;">학과</th> 
                  <th style="background-color:#eeeeee; text-align: center;">이메일</th>
                  <th style="background-color:#eeeeee; text-align: center;">회원 탈퇴</th>
                  <th style="background-color:#eeeeee; text-align: center;">메모</th>
                  
               </tr>
            </thead>
            <tbody>
            <%
               ArrayList<UserDTO> userList=new ArrayList<UserDTO>();
            	userList=new UserDAO().getListUser(search, pageNumber ,userGrade, userSemester, userDepart);
               if(userList != null)
                  for(int i=0; i < userList.size(); i++){
                     UserDTO user1 = userList.get(i);
            %>
               <tr>
                  <td><%= user1.getUserID() %></td>
                  <td><%= user1.getUserName() %></td>
                  <td><%= user1.getUserGrade() %></td>
                  <td><%= user1.getUserSemester() %></td>
                  <td><%= user1.getUserDepart() %></td>
                  <td><%= user1.getUserEmail() %></td>
                  <td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">탈퇴</button></td>
                    <td><button class="checkBtn btn btn-outline-success">메모</button></td>
               </tr>
                 
            <%
                  }
            %>
            </tbody>
         </table>
      </div>
      </div>
   </section>
   
   <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
<%
   if(pageNumber <=0) {
%>
   <a class="page-link disabled">이전</a>
<%
   } else {
%>
   <a class="page-link" href="./adminStudent.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
<%
   }
%>
      </li>   
      <li>
<%
   if(userList.size()<10) { //강의평가가 6개 이상 존재한다면 다음 페이지가 존재한다는 것이기 때문에(한 페이지에 5개까지 보임) 
%>
   <a class="page-link disabled">다음</a>
<%
   } else {
%>
   <a class="page-link" href="./adminStudent.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
<%
   }
%>
      </li>
   </ul>
   
   <!-- 메모 이벤트 처리 -->
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
          
          
          
          var userID_ss = td.eq(0).text();
          var userName_s = td.eq(1).text();
       
         //document.getElementById("userID_ss").value=userID_ss;
          //$('#userID_s').html(userID_ss);
          //$('#userName_s').html(userName_s);
          
           //$('#adminMemo').modal("show");
           var ajadminID=<%= userID%>
           var myData ={ajaxuserID: userID_ss, ajaxuseradminID: ajadminID}
           
           $.ajax({
              type: "POST",
              url: './studentMContentServlet',
              async:false,
              data: myData,
              success: function(result){
                 if(result==null){
                    alert("실패...");
                 }else{
                    $('#userID_s').html(userID_ss);
                       $('#userName_s').html(userName_s);
                    document.getElementById("userID_ss").value=userID_ss;
                    document.getElementById("studentMemoContent").value=result;
                     
                  }              
                 $('#adminMemo').modal("show");
              }
           });
           
          
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
	       var userID = td.eq(0).text();
/*	       var userDepart = td.eq(2).text();
	       var userAdmission = td.eq(3).text();
	       var subjGrade = td.eq(4).text();
	       var subjSemester = td.eq(5).text();*/

           document.getElementById("checkId").value=userID;
	       $('#checkModal').modal("show");
	    
	   });
   </script>  
	
   <!-- modal 양식 -->
   <!-- 일반적으로 class는 modal fade를 쓴다. dialog는 모달 다이얼로그창 -->
   <!-- 위의 등록하기 버튼을 누르면 나온다. -->
  
<div class="modal fade" id="adminMemo" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5><a id="userID_s" style="padding-right:10px"></a></h5> 
               <h5><a id="userName_s" style="padding-right:10px"></a></h5> 
               <h5 class="modla-title" id="modal">학생상담</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./studentMemoServlet" method="post">
                  <input type="hidden" name="adminID" value="<%= userID %>">      <!-- 관리자 ID -->   
                  <input type="hidden" name="userID_s" id="userID_ss" class="form-control">                                 
                  <div class="form-group">
                  
                  
                     <label>내용</label>
                     <textarea name="studentMemoContent" id="studentMemoContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
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
					<form  action="./userDel" method="post">
					<label>탈퇴를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">탈퇴</button></div>
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