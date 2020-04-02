<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="departr.DepartrDTO" %>
<%@ page import="departr.DepartrDAO" %>
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
   
</head>
<body>
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
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
         <a class="nav-link dropdown-toggle active" href="Board.jsp" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        	  학과별 졸업요건
         </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle active" href="GraduITNecessary.jsp">IT자율 융합학부</a>
                  <ul class="dropdown-menu">
            		<li><a class="dropdown-item active"  href="GraduITNecessary.jsp">졸업 조건</a></li> 
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
       
      <div class="row">
      <h3 class="mt-2">IT융합 자율학부 졸업요건</h3>
         <table class="table table-hover mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th  colspan="5" style="background-color:#eeeeee; text-align: center;">졸업조건</th>
               </tr>
            </thead>
            <tbody>
                <tr>
                   <td colspan="5" style="text-align: left"> 
                   1. 졸업학점 130학점 이상을 이수한 자<br>
                   <small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-교양학점(34학점 이상)과 전공학점(60학점이상~63학점 이상), 전공탐색(18학점 	이상)으로 구성 됩니다.</small> <br>
                   2. 비아메디아 채플 이수기준을 충족한 자<br>
                   3. 사회봉사 이수 기준을 충족한 자<br>
                   <small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-다만, 장애학생의 경우 사회봉사 이수가 곤란하다고 판단될 시 총장은 이에 대한 이수를 면제할 수 있다.</small> <br>
                   4. 필수(교양, 전공) 과목을 모두 이수한 자<br>
                   5. 다음 전공 이수방식 중 하나를 선택하여 각 전공에서 요구하는 졸업자격을 충족한 자<br>
                   <small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄱ. 주전공(40)과 부전공(20)</small><br>
                   <small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ. 복수 1전공(30)과 복수 2전공(30)</small><br>
                   <small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄷ. 혁신 융합전공(60)</small><br> 
                   6. 학생이 특별과정을 신청한 경우, 그 이수기준을 충족한 자<br>
                   7. 전공탐색 이수학점을 충족한 자<br>
                   </td>
                </tr>
                
                <tr>
                   <td rowspan="2"><h6>교양이수학점<br><small>(34점 이상)</small></h6></td> 
                   <td><h6><small>교양필수 - 16학점 이수 (각 2학점)</small></h6></td>
                   <td><h6><small>영역필수 - 18학점 이상</small></h6></td> 
                   <td><h6><small>전공탐색 - 19학점 이상</small></h6></td>
                   <td><h6><small>비고</small></h6></td>
                </tr>
                <tr>
	               <td style="text-align: left"><small>
	                   - 대학생활세미나 I <br>
	                   - 대학생활세미나 II <br>
	                   - 인권과평화<br>
	                   - 말과글<br>
	                   - 과학기술과에콜로지<br>
	                   - 데이터 활용 및 분석<br>
	                   - 비아메디아 채플 (1학점x2회)<br>
	                   - 사회봉사<br></small>
                   </td>
                   <td style="text-align: left"><small>
                   		· 가치역량 - 세영역 중 두 영역에서 각 1과목 총 6학점 이상<br>
                   		· 대안역량 - 세 영역 중 두 영역에서 각 1과목 총 6학점 이상<br>
                   		· 실천역량 - 두 영역에서 각 1과목 총 6학점 이상<br></small>
                   </td>
                   <td style="text-align: left"><small>
                   		- 소속 학부 1과목 이상<br>
                   		- 타 학부 1과목 이상<br>
                   		- 전공탐색세미나 1과목(1학점)<br>
                   		- 총 7개 과목(19학점) 이상 이수<br></small>
				   </td>
				   <td style="text-align: left"><small> 
				   		- "전공탐색세미나", "사회봉사"는 3학기부터 신청 가능합니다.<br>
				   		- 최소 졸업 이수학점은 130학점입니다.<br></small> 
				   </td>
                </tr>
                <tr>
                   <td><h6>가치역량<br><small>(6학점 이상)</small></h6></td>
                   <td><small>인간·인권<br> 
                   			생명·평화<br>
                   			민주·시민<br></small></td> 
                   <td  style="text-align: left" rowspan="4" colspan="3"><small>  
						1) 교양필수 과목인<br>
						"대학생활세미나 I·II", "인권과평화", "말과글", "과학기술과에콜로지", "데이터 활용 및 분석",<br>
						"사회봉사I", "비아메디아 채플"은 영역필수 이수학점에서 제외됩니다.<br>
						2) 3학기까지 핵심역량 이수학점은 다음과 같습니다.<br>
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) 가치역량 「인간∙인권」, 「생명∙평화」, 「민주시민」 세 영역 중  최소 두 영역에서 1과목(3학점)씩 총 2과목(6학점)이수   <br>
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) 대안역량 「융∙복합적 사고」, 「조사∙분석∙정보활용」, [대안제시·문제해결] 세 영역 중 최소 두 영역에서 1과목(3학점)씩 총 2과목(6학점)이수 「대안제시∙문제해결」 영역은 4학기 이후 수강을 권장함.<br>   
						   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(3) 실천역량 「민주적 소통」, [연대와 공동체적 실천] 두 영역 중 한 영역에서 1과목(3학점)씩 총 2과목(6학점)이수 「연대와 공동체적 실천」 영역은 4학기부터 수강을 권장함.<br> 
						3) 3학기까지 전공탐색 과목 이수 학점은 다음과 같습니다.    <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) 1학기(1과목) - 소속 학부 내에서 1과목 이상 이수   <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) 2학기 ~ 3학기(5과목) - 반드시 타 학부 전탐 1과목 포함 총 5과목 이상 이수   <br>
							3학기 개설되는 전공탐색과목이 난이도가 다소 높을 수 있는 점을 고려 2학기 때 타학부 전공탐색 과목 1과목 수강 권장
						
					</small></td>
                </tr>
                <tr>
                   <td><h6>대안역량<br><small>(6학점 이상)</small></h6></td>
                   <td><small>융·복합적 사고<br> 
                   			조사·분석·정보활용<br>
                   			대안제시·문제해결<br></small></td>  
                </tr>
                <tr>
                   <td><h6>실천역량<br><small>(6학점 이상)</small></h6></td>
                   <td><small>민주적 소통<br> 
                   			연대와 공동체적 실천<br></small></td>  
                </tr>
            </tbody>
             
         </table>
         
     
        
         
  
      </div>
   </div>
   
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script> 
   
   
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