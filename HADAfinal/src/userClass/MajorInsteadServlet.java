package userClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import subj.SubjDAO;

public class MajorInsteadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String subjMain = request.getParameter("checkId");
		/*	String subjYear = request.getParameter("checkId2");
		String subjSemester = request.getParameter("checkId3");*/
		String subjCode = request.getParameter("checkId4");
		String userID = request.getParameter("checkId5");
	      
	      int result=new userClassDAO().majorInstead( subjMain, subjCode, userID);
	      
	      if(result==-1){
	         PrintWriter script=response.getWriter();
	         script.println("<script>");
	         System.out.println(subjCode);
	         script.println("alert('전공 승인을 실패하였습니다.');");
	         script.println("history.back();");
	         script.println("</script>");
	         script.close();
	         return;
	      } else{
	         PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('전공 승인을 성공하였습니다.');");
	         script.println("location.href='Graduate.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
	         script.println("</script>");
	         script.close();
	         return;
	      }
	}

}
