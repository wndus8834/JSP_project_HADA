package insteadSubj;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import subj.SubjDAO;

/**
 * Servlet implementation class InsteadAddServlet2
 */

public class InsteadAddServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String bigDepartName = request.getParameter("bigDepartName");  //대분류 select
		String beInsteadDepart = request.getParameter("beInsteadDepart"); //학과 select	
		String beInsteadSubjCode = request.getParameter("subjCode"); //대체될 과목의 과목코드
		String beInsteadSubjName = request.getParameter("subjName"); //대체될 과목의 과목이름
		String subjMain = request.getParameter("subjMain"); //이수구분 select
		String subjScore = request.getParameter("subjScore"); //학점 
		String insteadSubjCode = request.getParameter("subjInsteadCode"); //대체할 과목의 과목코드
		String insteadSubjName = request.getParameter("subjInsteadName"); //대체할 과목의 이름
		
		if(beInsteadSubjCode.equals("") || beInsteadSubjName.equals("") || bigDepartName==null ||beInsteadDepart==null || subjMain==null || insteadSubjName.equals("") || subjScore.equals("")){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		int result= new InsteadSubjDAO().Capaupdate(bigDepartName, beInsteadDepart, beInsteadSubjCode, beInsteadSubjName, subjMain, subjScore, insteadSubjCode, insteadSubjName);
		
		
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("location.href='WriteCulture.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else{
			request.getSession().setAttribute("subjCode", beInsteadSubjCode);
			PrintWriter script=response.getWriter();
			script.println("<script>");
			
			script.println("alert('등록이 성공되었습니다.');");
			script.println("location.href='WriteCulture.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
	}

}
