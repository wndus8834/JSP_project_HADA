package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserWriteIDServlet extends HttpServlet{
	private static final long serialVersionUID=1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
	//	HttpSession session=request.getSession();
		String userQuestion = request.getParameter("userQuestion");
		String userAnswer = request.getParameter("userAnswer");
		request.getSession().setAttribute("userID", userID);
		
		if(userID.equals("") || userQuestion==null || userAnswer.equals("") ){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	/*	if(!userID.equals((String) session.getAttribute("userID"))){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}*/
		
		String result= new UserDAO().search(userID, userQuestion, userAnswer);
		
		
		if(result==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			//script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("alert('정보를 찾을 수 없습니다.');");
			script.println("location.href='Passwd_WriteID.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else{
			request.getSession().setAttribute("userID", userID);
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("location.href='userRePasswd.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
		
	}
}
