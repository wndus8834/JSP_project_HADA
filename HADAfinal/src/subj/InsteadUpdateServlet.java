package subj;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import departr.DepartrDAO;

public class InsteadUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String subjCode = request.getParameter("subjcode");
		HttpSession session=request.getSession();
		
		String subjInsteadCode = request.getParameter("subjinsteadCode");
		String subjInsteadName = request.getParameter("subjinsteadName");
		String subjName = request.getParameter("subjname");
		
		if(subjCode.equals("") || subjName.equals("") ||subjInsteadCode.equals("") ||subjInsteadName.equals("") ){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		int result= new SubjDAO().update(subjCode, subjName, subjInsteadCode, subjInsteadName);
		
		
		if(result==-1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("location.href='InsertInstead.jsp';");
			script.println("</script>");
			script.close();
			return;
		} else{
			request.getSession().setAttribute("subjCode", subjCode);
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('수정이 성공되었습니다.');");
			script.println("location.href='InsertInstead.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
	}

}
