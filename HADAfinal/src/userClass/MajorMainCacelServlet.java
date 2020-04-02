package userClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MajorMainCacelServlet
 */
@WebServlet("/MajorMainCacelServlet")
public class MajorMainCacelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String subjMain = request.getParameter("checkId");
		String subjCode = request.getParameter("checkId2");
		String userID = request.getParameter("checkId3");
	      
	      int result=new userClassDAO().changeMain( subjMain, subjCode, userID);
	      //System.out.println(userID);
	      
	      if(result==-1){
	         PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('전공 승인 취소를 실패하였습니다.');");
	         script.println("history.back();");
	         script.println("</script>");
	         script.close();
	         return;
	      } else{
	         PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('전공 승인 취소를 성공하였습니다.');");
	         script.println("location.href='adminDepart.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
	         script.println("</script>");
	         script.close();
	         return;
	      }
	}

}
