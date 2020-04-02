package departr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;

public class DepartrAddServlet extends HttpServlet{
	private static final long serialVersionUID=1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userDepart = request.getParameter("userDepart");
		String userAdmission = request.getParameter("userAdmission");
		String subjCode = request.getParameter("subjCode");
		String subjGrade = request.getParameter("subjGrade");
		String subjSemester = request.getParameter("subjSemester");
		String subjDivision = request.getParameter("subjDivision");
		
		if(userDepart==null || userAdmission==null || subjSemester==null || subjGrade==null || subjCode.equals("")){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		int result= new DepartrDAO().Add(userDepart, userAdmission, subjCode, subjGrade, subjSemester, subjDivision);
		
		
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재합니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else{
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('등록이 성공되었습니다.');");
			script.println("location.href='WriteGradu.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
		
	}
}
