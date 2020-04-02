package adminScore;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class adminGetScoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userDepart = request.getParameter("userDepart");
		String userProcess = request.getParameter("userProcess");
		String userID = request.getParameter("userID");
		String userAdmission=null;
		if(userID.indexOf("2013")!=-1) {
			userAdmission="2013";
		}
        else if(userID.indexOf("2014") != -1){
        	userAdmission="2014";
         }
         else if(userID.indexOf("2015") != -1){
        	 userAdmission="2015";
         }
         else if(userID.indexOf("2016") != -1){
        	 userAdmission="2015";
         }
         else if(userID.indexOf("2017") != -1){
        	 userAdmission="2017";
         }
         else if(userID.indexOf("2018") != -1){
        	 userAdmission="2018";
         } 
		
		adminScoreDTO dep = new adminScoreDAO().getScore(userProcess, userDepart, userAdmission);
		
		int totalCulture=dep.getTotalCulture();
		int totalCultureNecessary=dep.getTotalCultureNecessary();
		int totalMajor = dep.getTotalMajor();
		int totalMajorNecessary=dep.getTotalMajorNecessary();
		int totalGraduate=dep.getTotalGraduate();
		int totalAbility=dep.getTotalAbility();
		int totalFindMajor=dep.getTotalFindMajor();
		
		request.setAttribute("totalCulture", totalCulture);
		request.setAttribute("totalCultureNecessary", totalCultureNecessary);
		request.setAttribute("totalMajor", totalMajor);
		request.setAttribute("totalMajorNecessary", totalMajorNecessary);
		request.setAttribute("totalGraduate", totalGraduate);
		request.setAttribute("totalAbility", totalAbility);
		request.setAttribute("totalFindMajor", totalFindMajor);
		ServletContext context =getServletContext();
	    RequestDispatcher dispatcher = context.getRequestDispatcher("/Graduate.jsp"); //넘길 페이지 주소
	    dispatcher.forward(request, response);
		
	/*	PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert(<%=majorScore%>);");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;*/
		
		
		
		
	}

}
