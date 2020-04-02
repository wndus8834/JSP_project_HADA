package studentMemo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StudentMContent
 */
@WebServlet("/StudentMContent")
public class StudentMContentServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html;charset=UTF-8");
      String userID = request.getParameter("ajaxuserID");
      String adminID = request.getParameter("ajaxuseradminID");
      
      
      
      String Rcontent = new StudentMemoDAO().getMemoContent(userID, adminID);
      response.getWriter().write(Rcontent+"");
   }

}