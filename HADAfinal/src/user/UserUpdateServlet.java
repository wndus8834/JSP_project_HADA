package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserUpdateServlet extends HttpServlet{
	private static final long serialVersionUID=1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		HttpSession session=request.getSession();

		String userPassword = request.getParameter("userPassword");
		String userPassword1 = request.getParameter("userPassword1");
		String userEmail = request.getParameter("userEmail");
		String userDepart = request.getParameter("userDepart");
		String userName = request.getParameter("userName");
		String userQuestion = request.getParameter("userQuestion");
		String userAnswer = request.getParameter("userAnswer");
		
		if(userID.equals("") || userPassword.equals("") || userEmail.equals("") || userPassword1.equals("") || userDepart==null || userName.equals("") || userQuestion==null || userAnswer.equals("") ){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		if(!userID.equals((String) session.getAttribute("userID"))){
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		if(!userPassword.equals(userPassword1)){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 일치하지 않습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;//오류가 발생한 경우 바로 이 jsp 페이지의 작동을 종료시키도록 한다.
		}
		
		int result= new UserDAO().update(userID, userPassword, userEmail, userDepart, userName, userQuestion, userAnswer);
		
		
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("location.href='userModify.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else{
			request.getSession().setAttribute("userID", userID);
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 수정이 성공되었습니다.');");
			script.println("location.href='index.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
		
	}
}
