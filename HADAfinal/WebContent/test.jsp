<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="subj.SubjDTO" %>
<%@ page import="subj.SubjDAO" %>
<%@ page import="java.util.ArrayList" %>
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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<select id="ee">
    <option value="">서태지</option>
    <option value="">양현석</option>
    <option value="">이주노</option>
</select>

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
					   			<option value="<%=dep.getSubjCode()%>"><%=dep.getSubjYear()%><%=dep.getSubjName() %>(<%=dep.getSubjCode() %>)</option>
					   		<%
					   				}
					   		%>
						</select>
						
					<!-- 	<input type="text" name="subjCode" id="subjCode" class="form-control" placeholder="과목코드 입력란"> --> 
					</div>
					
</body>
</html>