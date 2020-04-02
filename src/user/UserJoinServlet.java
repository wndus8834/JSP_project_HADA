package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserJoinServlet extends HttpServlet{
	private static final long serialVersionUID=1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userPassword1 = request.getParameter("userPassword1");
		String userEmail = request.getParameter("userEmail");
		String userGrade = request.getParameter("userGrade");
		String userSemester = request.getParameter("userSemester");
		String userDepart = request.getParameter("userDepart");
		String userName = request.getParameter("userName");
		String userQuestion = request.getParameter("userQuestion");
		String userAnswer = request.getParameter("userAnswer");
		
		String a=request.getParameter("adminApply");
		boolean adminApply = false;
		if(a.equals("0")) {adminApply=false;}
		else {adminApply=true;}
		
		if(userID.equals("") || userPassword.equals("") || userEmail.equals("") || userPassword1.equals("") || userDepart==null || userSemester==null || userName.equals("") || userQuestion==null || userAnswer.equals("") || userGrade==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
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
		
		int result= new UserDAO().join(userID, userPassword, userEmail, userGrade, userSemester, userDepart, userName, userQuestion, userAnswer, adminApply, false);
		
		
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('회원 가입이 성공되었습니다.');");
			script.println("location.href='userLogin.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
		
	}
}
