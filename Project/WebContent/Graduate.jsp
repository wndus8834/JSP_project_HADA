<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="adminScore.adminScoreDTO" %>
<%@ page import="adminScore.adminScoreDAO" %>
<%@ page import="departr.DepartrDTO" %>
<%@ page import="departr.DepartrDAO" %>
<%@ page import="userClass.userClassDTO" %>
<%@ page import="userClass.userClassDAO" %>
<%@ page import="userScore.userScoreDTO" %>
<%@ page import="userScore.userScoreDAO" %>
<%@ page import="subj.SubjDTO" %>
<%@ page import="subj.SubjDAO" %>
<%@ page import="insteadSubj.InsteadSubjDTO" %>
<%@ page import="insteadSubj.InsteadSubjDAO" %>
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
   
   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
   
   <style>
   gray{
      color:gray;
   }
   red{
      color:red;
   }
   
   .jb-th-1{
      width: 70px;
   }
   
   
   @media (min-width: 400px) {
     .container {
       width: 400px;
     }
   }
   
   /*사실 이 블럭은 없어도 된다*/
   @media (min-width: 550px) {
     .container {
       width: 500px;
     }
   }
   
   @media (min-width: 700px) {
     .container {
       width: 650px;
     }
   }
   
   @media (min-width: 850px) {
     .container {
       width: 700px;
     }
   }
   
   .insteadOption{
         color:red;
   }
   
   </style>
   
</head>
<body>
<%

	int Majorcount=0;
	int Majorcount2=0;
	int semina=0;
	boolean bool44 = true;
	
	int []kind={0,0,0};//핵심역량
	int []kind2={0,0,0};
	int []kind3={0,0};
	int []check={0,0,0};
    boolean area[]={false, false, false};
	
	int count_chapel=0;
	int count_volunteer=0;

    int count_chapel1=0;
	int count_volunteer1=0;
	
	double neceCultur=0.0;//필수 교양 퍼센트
	double allCultural=0.0;//전체 교양 퍼센트
	double neceMajor=0.0;//전공 필수 퍼센트
	double allMajor=0.0;//전체 전공 퍼센트
	double Capa=0.0;//역량강화 퍼센트
	double findMajor=0.0;//전공 탐색 퍼센트
	double allGradu=0.0;//졸업 현황 퍼센트
	
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
   
   UserDTO user = new UserDAO().getUser(userID);
   userScoreDTO score = new userScoreDAO().getUserScore(userID);
   
   Integer totalCulture=(Integer)request.getAttribute("totalCulture");
   Integer totalCultureNecessary=(Integer)request.getAttribute("totalCultureNecessary");
   Integer totalMajor = (Integer)request.getAttribute("totalMajor");
   Integer totalMajorNecessary=(Integer)request.getAttribute("totalMajorNecessary");
   Integer totalGraduate=(Integer)request.getAttribute("totalGraduate");
   Integer totalAbility=(Integer)request.getAttribute("totalAbility");
   Integer totalFindMajor=(Integer)request.getAttribute("totalFindMajor");
   
   double refinementScore=0.0;//교양점수
   double culturalReqScore=0.0;//교필점수
   double majorSelectScore=0.0;//전선점수
   double majorReqScore=0.0;//전필점수
   double capaReinforceScore=0.0;//역량강화점수
   double majorFind=0.0;//전공탐색 점수
   double []cRScore={0.0, 0.0, 0.0};//역량 강화 영역별 점수
   
   double pluralMajorSelect=0.0;//복선 점수
   double pluralMajorNece=0.0;//복필 점수
   double minorSelect=0.0;//부전선 점수
   double minorNece=0.0;//부전필 점수
   double etcScore=0.0;//기타 항목 점수
   
   
  
  /* if(score.getRefinementScore()==null && score.getCulturalReqScore()==null && score.getMajorSelectScore()==null && score.getMajorReqScore()==null && score.getCapaReinforceScore()==null){
	   int result66= new userScoreDAO().search(user.getUserID()); 
			
			if(result66==1){
  			int result1 = new userScoreDAO().update(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore),String.valueOf(capaReinforceScore),String.valueOf(majorFind));
			} else{
				int result2 = new userScoreDAO().Add(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore),String.valueOf(capaReinforceScore),String.valueOf(majorFind));
			} 
   }else{*/
	   
		
	      ArrayList<userClassDTO> list68=new ArrayList<userClassDTO>();
	            
	         list68=new userClassDAO().getListClassUser2(user.getUserID());
	         if(list68 != null)
	            for(int i=0; i < list68.size(); i++){
	               userClassDTO sub = list68.get(i);
	               if((user.getUserID()).equals(sub.getUserID())){
	            	   	if(!sub.getScore().equals("F") && !sub.getScore().equals("N")){
			                  	if(sub.getSubjMain().equals("전필")){
			                      majorReqScore += Double.parseDouble(sub.getSubjScore());
			                      }
			                    else if(sub.getSubjMain().equals("전선")){
			                       majorSelectScore += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("전탐")){
			                    	majorFind += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("부전필")){
			                    	minorNece += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("부전선")){
			                    	minorSelect += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("복필")){
			                    	pluralMajorNece += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("복선")){
			                    	pluralMajorSelect += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("교필")){
						        	if(sub.getCoreCapaName()!=null && user.getUserID().indexOf("2018")!=-1&& sub.getSubjName().indexOf("인권과평화")==-1 && sub.getSubjName().indexOf("말과글")==-1 && sub.getSubjName().indexOf("과학기술과 에콜로지")==-1
					   						 && sub.getSubjName().indexOf("데이터 활용 및 분석")==-1 && !sub.getSubjName().equals("사회봉사I") && sub.getSubjName().indexOf("대학생활세미나")==-1 && sub.getSubjName().indexOf("채플")==-1){
					                    capaReinforceScore += Double.parseDouble(sub.getSubjScore());
						        	}
							        	culturalReqScore += Double.parseDouble(sub.getSubjScore());
			                    }
			                    else if(sub.getSubjMain().equals("교선")){
						        	if(sub.getCoreCapaName()!=null && user.getUserID().indexOf("2018")!=-1&& sub.getSubjName().indexOf("인권과평화")==-1 && sub.getSubjName().indexOf("말과글")==-1 && sub.getSubjName().indexOf("과학기술과 에콜로지")==-1
					   						 && sub.getSubjName().indexOf("데이터 활용 및 분석")==-1 && !sub.getSubjName().equals("사회봉사I") && sub.getSubjName().indexOf("대학생활세미나")==-1 && sub.getSubjName().indexOf("채플")==-1){
					                    capaReinforceScore += Double.parseDouble(sub.getSubjScore());
						        	}
							        	refinementScore += Double.parseDouble(sub.getSubjScore());
			                    }else {
			                    	etcScore += Double.parseDouble(sub.getSubjScore());
			                    }
	        			}
	               }
	            }
	         
        	int result68= new userScoreDAO().search(user.getUserID()); 
   
   			if(result68==1){
				int result1 = new userScoreDAO().update(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore),String.valueOf(capaReinforceScore),String.valueOf(majorFind));
			} else{
				int result2 = new userScoreDAO().Add(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore),String.valueOf(capaReinforceScore),String.valueOf(majorFind));
			} 
 /*  }*/

   		   boolean adminChecked=new UserDAO().getAdminChecked(userID);
   			
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
   		            <a class="nav-link active" href="Graduate.jsp">졸업요건 조회</a>
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
   <section class="container  mt-2"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
      
      <form method="post" action="./adminGetScore" class="form-inline"> 
         <input name="userDepart" type="hidden" value="<%=user.getUserDepart() %>">
         <input name="userID" type="hidden" value="<%=user.getUserID() %>">
         <select class="form-control mx-1 mt-2" name="userProcess">
            <option value="특별과정" disabled selected>본인이 이수하는 특별과정을 선택하세요</option> 
            <option value="주전공"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>주전공</option>
            <option value="복수전공">복수전공과정</option>
            <option value="부전공">부전공과정</option>
            <option value="전과">전과</option>
            <option value="편입">편입</option>
            <option value="연계전공과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>연계전공과정</option>
            <option value="해외창과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>해외창과정</option>
            <option value="평생교육사교육과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>평생교육사교육과정</option>
            <option value="교직과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>교직과정</option>
            <option value="자기설계과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>자기설계과정</option>
            <option value="기타 교과과정운영위원회의 승인을 얻은 과정"<% if(!(user.getUserDepart()).equals("컴퓨터공학과") && !(user.getUserDepart()).equals("IT융합 자율학부")) out.println("disabled"); %>>기타 교과과정운영위원회의 승인을 얻은 과정</option>
         </select>
         <button type="submit" class="btn btn-primary mx-1 mt-2">조회</button>
      </form>
   </section>
   <!-- 졸업요건 선택 -->

   <section class="container"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
      <!-- get방식; 사용자가 서버에 데이터 전달하도록, mt-3;위쪽으로 3만큼 마진을 준다. -->
      <form method="get" action="./Graduate.jsp" class="form-inline">
         <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#reportInstead">대체 과목 승인 신청</a> 
         <a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#reportDepart">전공 승인 신청</a> <script language="javascript">  
		
					function openWin(){  
					    window.open("infoUserProcess.png", "info새창", "width=800, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
					}   
					</script>  
	               <a class="btn btn-warning float-right mx-1 mt-2"  onClick="javascript:openWin();">조회 방법</a> 
      </form>
      
   </section>
   
<!-- 대체과목 모달창 -->
   <div class="modal fade" id="reportInstead" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="modal">대체 과목 신청 하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
             <div><h5><small><gray>이수한 과목</gray>은 <gray>회색</gray>, <red>이수하지 않은 필수 과목</red>은 <red>빨강색</red>으로 나타납니다.</small></h5>
               </div><div><h5><small>대체과목은 자신이<red>수강</red>한 과목중에, 성적이 <red>C+</red>이하인 과목,<br><red>폐지된 과목</red>과 <red>학점이 같은</red>과목만 대체가능합니다.</small></h5>
               </div>
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./insteadCommitServlet" method="post">
               <input type="hidden" value="<%=userID%>" name="userID3" id="userID3">
                     <select class="form-control mx-1 mt-2" id="insteadselect" name="insteadselect">
                        <option value="전체" selected disabled>대체 과목</option>
                        <%
                        String admission=null;
                        String userDepart =null;
                        if(user.getUserID().indexOf("2013") != -1){
                           admission="2013";
                        }
                        else if(user.getUserID().indexOf("2014") != -1){
                           admission="2014";
                        }
                        else if(user.getUserID().indexOf("2015") != -1){
                           admission="2015";
                        }
                        else if(user.getUserID().indexOf("2016") != -1){
                           admission="2016";
                        }
                        else if(user.getUserID().indexOf("2017") != -1){
                           admission="2017";
                        }
                        else if(user.getUserID().indexOf("2018") != -1){
                           admission="2018";
                        } 
                        userDepart=user.getUserDepart();
                        
                  ArrayList<userClassDTO> classList=new ArrayList<userClassDTO>(); 
                  classList = new userClassDAO().getUserClass(userID);   //userID에 따른 수강한 과목중 대체될 과목명, 과목코드, 학점 뽑아노는 list
                       
                  ArrayList<DepartrDTO> departrList=new ArrayList<DepartrDTO>();
                  departrList = new DepartrDAO().getDepartInstead(userID, admission, userDepart);  //학번에 따라 필수 과목중에 폐지된 과목들 list 
                  
                  if(classList !=null){
                     for(int i=0; i<classList.size(); i++){
                              userClassDTO classInsteadSubj = classList.get(i);
                              if(classInsteadSubj.getScore().equals("C+") || classInsteadSubj.getScore().equals("C0") || classInsteadSubj.getScore().equals("D+") || classInsteadSubj.getScore().equals("D0") || classInsteadSubj.getScore().equals("F") || classInsteadSubj.getScore().equals("N") ){
                              %>   
                              <option value="<%=classInsteadSubj.getSubjCode() %>" ><%=classInsteadSubj.getSubjName() %></option>
                           <% } 
                           }
                  }
                  boolean insteadbool = true;
                  
                  if(departrList !=null){
                     for(int q=0; q<departrList.size(); q++){
                        DepartrDTO departr = departrList.get(q);
                        //System.out.println(departr.getSubjName());
                        //System.out.println(departr.getSubjCode()); %>
                        <option class="insteadOption" value="<%=departr.getSubjCode() %>" ><%=departr.getSubjName() %></option>
                     <% }
                  }
                  
                     %>
                    
                     <script type="text/javascript">
                        var select = document.getElementById('insteadselect');
                        var selectedSubjCode ="";
                        select.addEventListener('change', function(event){
                           $('#selecInstead option').remove();
                           $('#selecInstead').html('<option selected disabled>대체할 과목</option>');
                           
                           var insteadUserID = <%=userID %>
                           selectedSubjCode =event.target.value;
                            
                           $.ajax({
                               type: "POST",
                               url: './insteadGet2',
                               async:false,
                               data: {subjCode: selectedSubjCode, userID2: insteadUserID},
                               success: function(result){
                                   //alert('성공');
                                  var object = eval('(' + result + ')');
                                   var result = object.result;
                                  for(var i=0; i<result.length; i++){
                                     
                                     $('#selecInstead').append('<option value="'+result[i][1].value+'">'+result[i][0].value+'</option>');
                                  }
                                  if(result.length <= 0){
                                    alert('현재 수강하신 과목중에 대체 가능한 과목이 없습니다.');
                                 }
                               },
                               error: function(){
                                  alert(selectedSubjCode);                                  
                               }
                            });
                        });
                    
                     
                     </script>
                     </select>
                     <select class="form-control mx-1 mt-2" name="selecInstead" id ="selecInstead">
                        <option id="test" value="전체" selected disabled>대체할 과목</option>
                       
                     </select>
                     <p id="result"></p>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">대체 과목 신청하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
	
   <div class="modal fade" id="reportDepart" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="modal">전공 승인 신청하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./majorInstead" method="post">
                     <select name="checkId4" id="checkId4" class="form-control mx-1 mt-2">
                        <option value="전체" disabled selected>전공 승인 신청할 과목</option>
                        <%
			               ArrayList<userClassDTO> listClass=new ArrayList<userClassDTO>();
			                   
			               listClass=new userClassDAO().getListScore();
			               if(listClass != null)
			                  for(int i=0; i < listClass.size(); i++){
			                     userClassDTO sub = listClass.get(i);
			                        if((user.getUserID()).equals(sub.getUserID())){
			                     %>
			                           <%
			                                 if(sub.getBigDepartName().equals("공학계") && !sub.getUserDepart().equals("컴퓨터공학과") && sub.getSubjMain().equals("교선")){
			                              
			                              %>
			                                     <option value="<%=sub.getSubjCode()%>"><%=sub.getSubjName() %>(<%=sub.getSubjCode() %>)</option>
			                                <%
			                                 } 
			                                
			                                %>
			                  <%
			                        }
			                     }
			                  %>
                     </select>
                       <input type="hidden" name="checkId5" id="checkId5"class="form-control" value="<%= user.getUserID() %>">
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">전공 승인 신청하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
	


  <!-- 졸업 테이블 -->
   <div class="container">
      <div class="jumbotron bg-light">
         <div class="row">
            <div class="float-left"><h4><나의 졸업 현황></h4></div>
            
            <%
            
            String a=null;
            if(user.getUserID().indexOf("2013") != -1){
               a="2013";
            }
            else if(user.getUserID().indexOf("2014") != -1){
               a="2014";
            }
            else if(user.getUserID().indexOf("2015") != -1){
               a="2015";
            }
            else if(user.getUserID().indexOf("2016") != -1){
               a="2016";
            }
            else if(user.getUserID().indexOf("2017") != -1){
               a="2017";
            }
            else if(user.getUserID().indexOf("2018") != -1){
               a="2018";
            } %>
            
               <table class="table table-bordered mt-3">
                    <thead>
                      <tr>
                        <th class="jb-th-1"scope="col">학년</th>
                        <th scope="col">1학기</th>
                        <th scope="col">2학기</th>                  
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row">1학년</th>
                       <td> <%
                        ArrayList<DepartrDTO> list=new ArrayList<DepartrDTO>();
                        list=new DepartrDAO().getList();
                        
                        ArrayList<userClassDTO> list2=new ArrayList<userClassDTO>();
                        list2=new userClassDAO().getListScore();

                        boolean bool = true;
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("1") && dep.getSubjSemester().equals("1학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){ 
                                 
                                 if(list2 != null)
                                    for(int j=0; j < list2.size(); j++){
                                       userClassDTO sub = list2.get(j);
                                          if((user.getUserID()).equals(sub.getUserID())){%>   <!-- 해당 과목의  -->
                                             <%
                                             if(dep.getSubjCode().equals(sub.getSubjCode())){
                                                %>
                                                
                                                <gray><%= dep.getSubjName() %></gray>.
                                                
                                             <% bool = false; break; 
                                             } 
                                          }
                                    }
                                      if(bool == true){%>
                                    <red><%= dep.getSubjName() %></red>.
                                    <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                     <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("1") && dep.getSubjSemester().equals("2학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                      </tr>
                      <tr>
                        <th scope="row">2학년</th>
                        <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("2") && dep.getSubjSemester().equals("1학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                        <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("2") && dep.getSubjSemester().equals("2학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                      </tr>
                      <tr>
                        <th scope="row">3학년</th>
                        <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("3") && dep.getSubjSemester().equals("1학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                        <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("3") && dep.getSubjSemester().equals("2학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                      </tr>
                      <tr>
                        <th scope="row">4학년</th>
                        <td>  <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("4") && dep.getSubjSemester().equals("1학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                        <td> <%
                        if(list != null)
                           for(int i=0; i < list.size(); i++){
                              DepartrDTO dep = list.get(i);
                                 if(dep.getUserDepart().equals("컴퓨터공학과") && dep.getUserAdmission().equals(a) && dep.getSubjGrade().equals("4") && dep.getSubjSemester().equals("2학기")&& (dep.getSubjDivision().equals("전필") || dep.getSubjDivision().equals("교필"))){
                     
                                 if(list2 != null)
                                       for(int j=0; j < list2.size(); j++){
                                          userClassDTO sub = list2.get(j);
                                             if((user.getUserID()).equals(sub.getUserID())){%>
                                                <%if(dep.getSubjCode().equals(sub.getSubjCode())){%>
                                                   
                                                   <gray><%= dep.getSubjName() %></gray>.
                                                   
                                                <% bool = false; break;
                                                } 
                                              }
                                       }
                                 if(bool == true){%>
                                             <red><%= dep.getSubjName() %></red>.
                                      <%}else{ bool=true;}
                                 }
                        }
                     %></td>
                      </tr>
                    </tbody>
               </table>
         </div>
         <div><h5><small class="float-right"><gray>이수한 과목</gray>은 <gray>회색</gray>, <red>이수하지 않은 과목</red>은 <red>빨강색</red>으로 나타납니다.</small></h5>
         </div>
         <br>
         
         <%if(totalCultureNecessary!=null && totalCulture!=null && totalMajorNecessary!=null && totalMajor!=null && totalAbility!=null && totalGraduate!=null && totalFindMajor!=null) {%>
            <%neceCultur=Double.parseDouble(score.getCulturalReqScore())/totalCultureNecessary * 100; %> <!-- 학과별 필수 교양. 18학번은 IT융합 자울학부의 필수과목도 포함된다. -->
            <div>
            <h5><label>필수 교양 <small><%=score.getCulturalReqScore() %>/<%= totalCultureNecessary%></small></label></h5>
            <div class="progress">
              <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+neceCultur+"%");%>>
                <%= Double.parseDouble(String.format("%.1f", neceCultur))%> %
              </div>
            </div>
            </div>
          
            <%allCultural=(Double.parseDouble(score.getRefinementScore())+Double.parseDouble(score.getCulturalReqScore()))/totalCulture * 100; %>
           <div class="mt-4">
            <h5><label>전체 교양 <small><%=(Double.parseDouble(score.getRefinementScore())+Double.parseDouble(score.getCulturalReqScore())) %>/<%= totalCulture%></small></label></h5> 
            <!-- 전체 교양 점수 = 교필 점수 + 교선 점수 (+ 18학번일 경우, 전공 탐색 점수) (핵심 역량 점수는 교필이나 교선에 포함돼있음.) -->
            <div class="progress">
              <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+allCultural+"%");%>>
                <%= Double.parseDouble(String.format("%.1f", allCultural))%> %
              </div>
            </div>
            </div>
           
           
	        <%
	        double NeceSocre=0.0;
	        if(user.getUserDepart().equals("컴퓨터공학과")) {
	            NeceSocre=Double.parseDouble(score.getMajorReqScore());
	        }else{
	            NeceSocre=(pluralMajorNece + minorNece);
	        } 
	        neceMajor=NeceSocre/totalMajorNecessary * 100;
	        
	        if(totalMajorNecessary==0){
	        	neceMajor=100;
	        }
	        %>
            <%if(user.getUserDepart().equals("컴퓨터공학과")){ %>
            <div class="mt-4">
            <h5><label>전공 필수 <small><%=NeceSocre %>/<%= totalMajorNecessary%></small></label></h5> <!-- 학과별 전공 필수 점수. -->
             <div class="progress">
              <div class="progress-bar progress-bar-warning progress-bar-striped bg-warning progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+neceMajor+"%");%>>
                 <%= Double.parseDouble(String.format("%.1f", neceMajor)) %> %
              </div>
            </div>
            </div>
            <%} //System.out.println(neceMajor);%>
            
            
            <%
            double totalMajorScore=0.0;
            if(totalMajor<60) {%>
	            <%
	            if(user.getUserDepart().equals("컴퓨터공학과")){
		              totalMajorScore=(Double.parseDouble(score.getMajorReqScore())+Double.parseDouble(score.getMajorSelectScore()));
	            }else{
		              totalMajorScore=pluralMajorSelect + pluralMajorNece + minorSelect + minorNece;
	            }
	        }else{
	              totalMajorScore=(Double.parseDouble(score.getMajorReqScore())+Double.parseDouble(score.getMajorSelectScore()));
	        }
            allMajor=totalMajorScore/totalMajor * 100; %>
            <div class="mt-4">
            <h5><label>전체 전공 <small><%=totalMajorScore %>/<%=totalMajor %></small></label></h5>
            <!-- 전체 전공 점수 = 전공 필수 점수 + 전공 선택 점수 -->
             <div class="progress">
              <div class="progress-bar progress-bar-warning progress-bar-striped bg-warning progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+allMajor+"%");%>>
                 <%= Double.parseDouble(String.format("%.1f", allMajor)) %> %
              </div>
            </div>
            </div>
            
           <%findMajor=Double.parseDouble(score.getMajorFind())/totalFindMajor * 100; %>
            <%if(user.getUserID().indexOf("2018") != -1){ %> <!-- 2018학번만 보인다 -->
            <div class="mt-4">
            <h5><label>전공 탐색 <small><%= score.getMajorFind() %>/<%=totalFindMajor %></small></label></h5>
             <div class="progress">
              <div class="progress-bar progress-bar-striped bg-success progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+findMajor+"%");%>>
                 <%= Double.parseDouble(String.format("%.1f", findMajor))%> %
              </div>
            </div>
            
            </div>
            <%} %>
            
               <%Capa=Double.parseDouble(score.getCapaReinforceScore())/totalAbility * 100; %>
            <%if(user.getUserID().indexOf("2018") != -1){ %> 
            <div class="mt-4">
            <h5><label>핵심 역량 <small><%= score.getCapaReinforceScore() %>/<%=totalAbility %></small></label></h5>
             <div class="progress">
              <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+Capa+"%");%>>
                 <%= Double.parseDouble(String.format("%.1f", Capa))%> %
              </div>
            </div>
            </div>
            <%} %>
            
            
            <% double totalGradu= (Double.parseDouble(score.getRefinementScore())+Double.parseDouble(score.getCulturalReqScore())+Double.parseDouble(score.getMajorFind()))+(Double.parseDouble(score.getMajorReqScore())+Double.parseDouble(score.getMajorSelectScore())+(pluralMajorSelect+pluralMajorNece+minorSelect+minorNece)+etcScore);
            allGradu=totalGradu/totalGraduate * 100;%> <!-- 개인별 전체 이수 점수 = 전체 교양(교필+교선(+전공 탐색)) + 전체 전공(전필+전선) -->
           <div>
           <div class="mt-4">
           <h5><label>졸업 현황 <small><%= totalGradu%>/<%=totalGraduate %></small></label></h5>
            <div class="progress"> 
              <div class="progress-bar progress-bar-striped bg-danger progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style=<%out.print("width:"+allGradu+"%");%>>
                 <%= Double.parseDouble(String.format("%.1f", allGradu))%> %
              </div>
            </div>
            </div>
            
            <div>
               <% ArrayList<userClassDTO> listsep2=new ArrayList<userClassDTO>();
               
               listsep2=new userClassDAO().getListClassUser2(user.getUserID()); 
               if(listsep2 != null)
                  for(int i=0; i < listsep2.size(); i++){
                     userClassDTO sub = listsep2.get(i); 
                     
                     if(!sub.getScore().equals("F") && !sub.getScore().equals("N")){ 
                    	// System.out.println(sub.getScore());
	                     if(sub.getSubjName().equals("사회봉사I") || sub.getSubjName().indexOf("CUAC")!=-1
	                    		 || sub.getSubjName().indexOf("해외봉사")!=-1 || sub.getSubjName().indexOf("농촌봉사")!=-1){//사회봉사
	                        count_volunteer++;
	                     }
	                     
	                     if((sub.getSubjMain().equals("교필")) && (sub.getUserDepart().equals("교목실"))){//채플
	                        count_chapel++;
	                     }

	   					String coreName=sub.getCoreCapaName();
	   					String detailName=sub.getDetailAreaName();
	   					if(coreName!=null && sub.getSubjName().indexOf("인권과평화")==-1 && sub.getSubjName().indexOf("말과글")==-1 && sub.getSubjName().indexOf("과학기술과 에콜로지")==-1
	   						 && sub.getSubjName().indexOf("데이터 활용 및 분석")==-1 && !sub.getSubjName().equals("사회봉사I") && sub.getSubjName().indexOf("대학생활세미나")==-1 && sub.getSubjName().indexOf("채플")==-1 ){
	   						if(coreName.indexOf("가치역량")!=-1){
	   							cRScore[0]+=Double.parseDouble(sub.getSubjScore());
	   							check[0]++;
	   							if(detailName.indexOf("인간인권")!=-1){	kind[0]++;}
	   							else if(detailName.indexOf("생명평화")!=-1){	kind[1]++;}
	   							else if(detailName.indexOf("민주시민")!=-1){	kind[2]++;}
	   						}else if(coreName.indexOf("대안역량")!=-1){
	   							cRScore[1]+=Double.parseDouble(sub.getSubjScore());
	   							check[1]++;
	   							if(detailName.indexOf("융복합적사고")!=-1){	kind2[0]++;}
	   							else if(detailName.indexOf("조사분석")!=-1){	kind2[1]++;}
	   							else if(detailName.indexOf("대안제시문제해결")!=-1){	kind2[2]++;}
	   						}else if(coreName.indexOf("실천역량")!=-1){
	   							cRScore[2]+=Double.parseDouble(sub.getSubjScore());
	   							check[2]++;
	   							if(detailName.indexOf("민주적소통")!=-1){	kind3[0]++;}
	   							else if(detailName.indexOf("연대와공동체")!=-1){	kind3[1]++;}
	   						}
	   						
	   					}
                     }
	   					
	             		  if(check[0]!=0){
	             			  if((kind[0]!=0 && kind[1]!=0 && kind[2]!=0) || (kind[0]!=0 && kind[1]!=0 && kind[2]==0)
	                    			   || (kind[0]!=0 && kind[1]==0 && kind[2]!=0) || (kind[0]==0 && kind[1]!=0 && kind[2]!=0)){
	             				  area[0]=true;
	             			  }else{
	             				  area[0]=false;
	             			  }
	             		  }
	             		  if(check[1]!=0){
	             			  if((kind2[0]!=0 && kind2[1]!=0 && kind2[2]!=0) || (kind2[0]!=0 && kind2[1]!=0 && kind2[2]==0)
	                    			   || (kind2[0]!=0 && kind2[1]==0 && kind2[2]!=0) || (kind2[0]==0 && kind2[1]!=0 && kind2[2]!=0)){
	             				  area[1]=true;
	             			  }else{
	             				  area[1]=false;
	             			  }
	             		  }
	             		  if(check[2]!=0){
	             			  if(kind3[0]!=0 && kind3[1]!=0){
	             				  area[2]=true;
	             			  }else{
	             				  area[2]=false;
	             			  }
	             		  }
	             		  
                   }
               
                   if(count_chapel<2){ %>
                     <h5><small><label class="float-right">남은 채플 이수 횟수 : <red><%= 2-count_chapel %>&nbsp;</red></label></small></h5>
                     <%} %>
                     <%if(count_volunteer<1){ %>
                     <h5><small><label class="float-right">남은 사회봉사 이수 횟수 : <red><%= 1-count_volunteer %>&nbsp;</red></label></small></h5>
                     <%} %>
            
            <% if(user.getUserID().indexOf("2018")!=-1){
            		if(area[0]==true && area[1]==true && area[2]==true && cRScore[0] >=6 && cRScore[1]>=6 && cRScore[2]>=6){
            		}else if(((area[0]==true && area[1]==true && cRScore[0] >=6 && cRScore[1]>=6)
                            || (area[0]==true && area[2]==true && cRScore[0]>=6 && cRScore[2]>=6) || (area[1]==true && area[2]==true && cRScore[1]>=6 && cRScore[2]>=6))){%> <!-- 3영역 중 2개의 영역을 이수했을 경우 -->
            			<h5><small><label class="float-right">이수해야 하는 핵심역량 영역 수 : <red>1&nbsp;</red></label></small></h5>
            <%		}else if(((area[0]==true && cRScore[0] >=6)
                    || (area[1]==true && cRScore[1]>=6) || (area[2]==true && cRScore[2]>=6))){%> <!-- 3영역 중 1개의 영역만 들었을 경우 -->
            			<h5><small><label class="float-right">이수해야 하는 핵심역량 영역 수 : <red>2&nbsp;</red></label></small></h5>
            <%		}else{%>
            			<h5><small><label class="float-right">이수해야 하는 핵심역량 영역 수 : <red>3&nbsp;</red></label></small></h5>
            	<% }
            }%>
                </div>
            
            
            <%//System.out.println(area[0]);System.out.println(cRScore[0]);System.out.println(area[1]);System.out.println(cRScore[1]);System.out.println(area[2]);System.out.println(cRScore[2]);
                boolean cultureNeceSatisfy=false;
                boolean cultureReqSatisfy=false;
                boolean majorNeceSatisfy=false;
                boolean majorReqSatisfy=false;
                boolean graduPossible=false;
                boolean FindSatisfy=false;
                boolean CapaSatisfy=false;

                bool44 = true;

                ArrayList<userClassDTO> listsep=new ArrayList<userClassDTO>();
    	   			
                listsep=new userClassDAO().getListClassUser2(user.getUserID()); 
	   			if(listsep != null)
	   				for(int i=0; i < listsep.size(); i++){
	   					userClassDTO sub = listsep.get(i);
	   					
		   					if(sub.getBigDepartName().equals("공학계") && sub.getSubjMain().equals("전탐")){
		   						Majorcount++;
		   					}else if(!sub.getBigDepartName().equals("공학계") && sub.getSubjMain().equals("전탐")){
		   						Majorcount2++;
		   					}
		   					
		   					if(sub.getSubjName().equals("전공탐색세미나")){
	                   			semina++;
	                   	 	}
	   					
	   					/*if(sub.getSubjName().indexOf("봉사")!=-1){//사회봉사
	   						count_volunteer1++;
	   					}
	   					if((sub.getSubjName().indexOf("봉사")==-1) && (sub.getSubjMain().equals("교필")) && (sub.getSubjName().indexOf("인문학의 세계-느티아래 강좌")==-1)){//채플
	   						count_chapel1++;
	   					}
	   				/*	String coreName=sub.getCoreCapaName();
	   					String detailName=sub.getDetailAreaName();
	   					if(coreName!=null){
	   						if(coreName.indexOf("가치역량")!=-1){
	   							check[0]++;
	   							if(detailName.indexOf("인간인권")!=-1){	kind[0]++;}
	   							else if(detailName.indexOf("생명평화")!=-1){	kind[1]++;}
	   							else if(detailName.indexOf("민주시민")!=-1){	kind[2]++;}
	   						}else if(coreName.indexOf("대안역량")!=-1){
	   							check[1]++;
	   							if(detailName.indexOf("융복합적사고")!=-1){	kind2[0]++;}
	   							else if(detailName.indexOf("조사분석정보활용")!=-1){	kind2[1]++;}
	   							else if(detailName.indexOf("대안제시문제해결")!=-1){	kind2[2]++;}
	   						}else if(coreName.indexOf("실천역량")!=-1){
	   							check[2]++;
	   							if(detailName.indexOf("민주적소통")!=-1){	kind3[0]++;}
	   							else if(detailName.indexOf("연대와공동체적실천")!=-1){	kind3[1]++;}
	   						}
	   					}*/
	   				}
               

				//System.out.println(count_chapel); 
               if((neceCultur < 100) || (count_chapel<2) || (count_volunteer<1)){//교필 
            	   cultureNeceSatisfy=false;
               }else{
            	   cultureNeceSatisfy=true;
               }
               
               if(neceMajor < 100){//전필
                  majorNeceSatisfy=false;
               }else{
                  majorNeceSatisfy=true;
               }
               

             		if(allMajor < 100){//총전공
                      majorReqSatisfy=false;
                   }else{
                      majorReqSatisfy=true;
                   } System.out.println(majorReqSatisfy);
               
             		//핵심 역량
	              //3영역을 모두 이수하되, 1영역당 2과목 이상을 이수해야된다.
            	   if(check[0]!=0 && check[1]!=0 && check[2]!=0){ // 3영역에서 한영역 당 최소 하나의 과목을 들었을 경우
            		 /* if(check[0]!=0){
            			  if((kind[0]!=0 && kind[1]!=0 && kind[2]!=0) || (kind[0]!=0 && kind[1]!=0 && kind[2]==0)
                   			   || (kind[0]!=0 && kind[1]==0 && kind[2]!=0) || (kind[0]==0 && kind[1]!=0 && kind[2]!=0)){//한 영역에서 최소 두개의 세부 영역 과목을 들었을 경우
            				  area[0]=true;
            			  }else{
            				  area[0]=false;
            			  }
            		  }
            		  if(check[1]!=0){
            			  if((kind2[0]!=0 && kind2[1]!=0 && kind2[2]!=0) || (kind2[0]!=0 && kind2[1]!=0 && kind2[2]==0)
                   			   || (kind2[0]!=0 && kind2[1]==0 && kind2[2]!=0) || (kind2[0]==0 && kind2[1]!=0 && kind2[2]!=0)){//한 영역에서 최소 두개의 세부 영역 과목을 들었을 경우
            				  area[1]=true;
            			  }else{
            				  area[1]=false;
            			  }
            		  }
            		  if(check[2]!=0){
            			  if(kind3[0]!=0 && kind3[1]!=0){//한 영역에서 최소 두개의 세부 영역 과목을 들었을 경우
            				  area[2]=true;
            			  }else{
            				  area[2]=false;
            			  }
            		  }*/
            		  
            		  //System.out.println(area[0]);
            		  if((area[0]==true && area[1]==true && area[2]==true) && (cRScore[0]>=6 && cRScore[1]>=6 && cRScore[2]>=6)){ //세가지 영역 각각 조건을 충족할 때(각 영역은 6점 이상 이수해야한다.)
            			  CapaSatisfy=true;
            		  }else{
            			  CapaSatisfy=false;
            		  }//System.out.println(CapaSatisfy);
            	   }
             		

   	   			if(user.getUserID().indexOf("2018")==-1){
   	   				if(allCultural < 100){ //교양 총
   	   						cultureReqSatisfy=false;
   		               }else{
   		            		cultureReqSatisfy=true;
   		               }
   	               }else{// 18학번일 경우에는 교양 총 점수(전필, 전선, 핵심 역량 점수, 전공 탐색 점수)와 전공 탐색 조건을 충족해야한다.
   	                   if(allCultural < 100 || CapaSatisfy!=true){//총 교양
   	                		cultureReqSatisfy=false;
   	                   }else{
   	                		cultureReqSatisfy=true;
   	                   }
   	               }
   	   			
   	   			if(user.getUserID().indexOf("2018") != -1){//전탐 
   	   				if((Majorcount >= 1 && Majorcount2 >= 1 && Majorcount+Majorcount2 >= 7 && semina!=0) && findMajor >= 100){
   	   					FindSatisfy=true;
   	   				}else{
   	   					FindSatisfy=false;
   	   				} 
   	   			}
               %>
               
               <% 
               if(allGradu >= 100 && cultureNeceSatisfy==true && cultureReqSatisfy==true && majorNeceSatisfy==true && majorReqSatisfy==true){
            	   if(user.getUserID().indexOf("2018") != -1){//18학번일 경우
            		   if(FindSatisfy==false){
            			   graduPossible=false;
            		   }else{
                		   if(totalMajor<60){//총 전공의 점수가 60점보다 낮을 경우, (복수전공이나, 부전공을 할 경우), 부전필, 전필, 복필 등 전공 점수의 합산이 60점보다 높으면 true
                			   if(majorSelectScore+majorReqScore+pluralMajorSelect+pluralMajorNece+minorSelect+minorNece>60){
                                   graduPossible=true;
                			   }else{
                                   graduPossible=false;
                			   }
                		   }else{//60점보다 높을 경우, 전공의 합산이 60점보다 높으면 true
                			   if(totalMajorScore>60){
                                   graduPossible=true;
                			   }else{
                                   graduPossible=false;
                			   }
                		   }
            		   }
            	   }else{
            		   if(totalMajor<60){//총 전공의 점수가 60점보다 낮을 경우, (복수전공이나, 부전공을 할 경우), 부전필, 전필, 복필 등 전공 점수의 합산이 60점보다 높으면 true
            			   if(majorSelectScore+majorReqScore+pluralMajorSelect+pluralMajorNece+minorSelect+minorNece>60){
                               graduPossible=true;
            			   }else{
                               graduPossible=false;
            			   }
            		   }else{//60점보다 높을 경우, 전공의 합산이 60점보다 높으면 true
            			   if(totalMajorScore>60){
                               graduPossible=true;
            			   }else{
                               graduPossible=false;
            			   }
            		   }
            		   
            	   }
               }else{
                  graduPossible=false;
               }
               

              // System.out.println(area[1]);
               	int result = new userScoreDAO().updateCheck(user.getUserID(), cultureNeceSatisfy, cultureReqSatisfy, majorNeceSatisfy, majorReqSatisfy, graduPossible, FindSatisfy);
                  
                  if(result==-1){
                     int result2 = new userScoreDAO().AddCheck(user.getUserID(), cultureNeceSatisfy, cultureReqSatisfy, majorNeceSatisfy, majorReqSatisfy, graduPossible, FindSatisfy);
                  }
            } %>
            </div>
            
   </div></div>
   
   
      
   

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