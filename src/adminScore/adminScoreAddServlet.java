package adminScore;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import departr.DepartrDAO;

/**
 * Servlet implementation class adminScoreAddServlet
 */
public class adminScoreAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userDepart = request.getParameter("userDepart");
		String userAdmission = request.getParameter("userAdmission");
		String userProcess = request.getParameter("userProcess");
		String totalCulture = request.getParameter("totalCulture");
		String totalCultureNecessary = request.getParameter("totalCultureNecessary");
		String totalMajor = request.getParameter("totalMajor");
		String totalMajorNecessary = request.getParameter("totalMajorNecessary");
		String totalGraduate = request.getParameter("totalGraduate");
		String totalAbility = request.getParameter("totalAbility");
		String totalFindMajor = request.getParameter("totalFindMajor");
		

		if(totalCulture == null || totalCulture.trim().equals("")){
			totalCulture = "0";
			}
		if(totalCultureNecessary == null || totalCultureNecessary.trim().equals("")){
			totalCultureNecessary = "0";
			}
		if(totalMajor == null || totalMajor.trim().equals("")){
			totalMajor = "0";
			}
		if(totalMajorNecessary == null || totalMajorNecessary.trim().equals("")){
			totalMajorNecessary = "0";
			}
		if(totalGraduate == null || totalGraduate.trim().equals("")){
			totalGraduate = "0";
			}
		if(totalAbility == null || totalAbility.trim().equals("")){
			totalAbility = "0";
			}
		if(totalFindMajor == null || totalFindMajor.trim().equals("")){
			totalFindMajor = "0";
			}
		
		
		
		Integer totalCulture2 = Integer.parseInt(totalCulture);
		Integer totalCultureNecessary2 = Integer.parseInt(totalCultureNecessary);
		Integer totalMajor2 = Integer.parseInt(totalMajor);
		Integer totalMajorNecessary2 = Integer.parseInt(totalMajorNecessary);
		Integer totalGraduate2 = Integer.parseInt(totalGraduate);
		Integer totalAbility2 = Integer.parseInt(totalAbility);
		Integer totalFindMajor2 = Integer.parseInt(totalFindMajor);
		
		if(userDepart==null || userAdmission==null || userProcess==null || totalCulture2==0 || totalCultureNecessary2==0
				|| totalMajor2==0 || totalGraduate2==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		
		int result= new adminScoreDAO().Add(userDepart, userProcess, userAdmission, totalCulture2, totalCultureNecessary2,
				totalMajor2, totalMajorNecessary2, totalGraduate2, totalAbility2, totalFindMajor2);
		
		
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
			script.println("location.href='adminScore.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
			script.println("</script>");
			script.close();
			return;
		}
		
	}

}
