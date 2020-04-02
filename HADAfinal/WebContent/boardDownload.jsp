<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="board.BoardDAO" %> 
<%@ page import="board.BoardDTO" %>
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
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String boardID = request.getParameter("boardID");
		if(boardID==null || boardID.equals("")){
			PrintWriter script=response.getWriter();
		    script.println("<script>");
		    script.println("alert('로그인을 해주세요.');");
		    script.println("location.href='userLogin.jsp';");
		    script.println("</script>");
		    script.close();
		    return;
		}
		String root = request.getSession().getServletContext().getRealPath("/");
		String savePath = root+"upload";
		String fileName ="";
		String realFile ="";
		BoardDAO boardDAO = new BoardDAO();
		fileName = boardDAO.getFile(boardID);
		realFile =boardDAO.getRealFile(boardID);
		if(fileName.equals("") || realFile.equals("")){
			PrintWriter script=response.getWriter();
		    script.println("<script>");
		    script.println("alert('로그인을 해주세요.');");
		    script.println("location.href='userLogin.jsp';");
		    script.println("</script>");
		    script.close();
		    return;
		}
		InputStream in =null;
		OutputStream os =null;
		File file = null;
		boolean skip = false;
		String client = "";
		try{
			try{
				file = new File(savePath, realFile);  //실제 저장경로에 있는 파일을 가져와서 객체에 초기화
				in = new FileInputStream(file);  //가져온 파일을 inputStream으로 읽음
			} catch(FileNotFoundException e){  //파일을 찾지 못했을경우의 에러
				skip = true;
			}
			client = request.getHeader("User-Agent");
			response.reset();
			response.setContentType("application/octet-stream");  //웹페이지를 실행하는 브라우저에게 meta data 
			response.setHeader("Content-Description", "JSP Generated Data");
			if(!skip){   //다운로드가 될경우
				if(client.indexOf("MSIE") !=-1){
					response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("KSC5601"), "ISO8859_1"));
				}else{
					fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
				}
				response.setHeader("Content-Length", "" + file.length());
				os = response.getOutputStream();
				byte b[] = new byte[(int)file.length()];
				int leng = 0;
				while ((leng = in.read(b)) > 0){
					os.write(b, 0, leng);
				}
				
			}else{
				response.setContentType("text/html; charset=UTF-8");
				out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
			}
			in.close();
			os.close();
		} catch(Exception e){
			e.printStackTrace();
		}

	%>
</body>
</html>