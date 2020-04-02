package studentMemo;

import java.io.IOException;

import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class StudentMemoServlet
 */
@WebServlet("/StudentMemoServlet")
public class StudentMemoServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html;charset=UTF-8");
      String userID = request.getParameter("userID_s");
      String adminID = request.getParameter("adminID");
      String content = request.getParameter("studentMemoContent");
      
      System.out.println("Memo서블릿연결");
      System.out.println(userID);
      System.out.println(adminID);
      System.out.println(content);
      
      //if(content.equals(anObject))
      //String Rcontent = new StudentMemoDAO().getMemoContent(userID, adminID);
      
         //Rcontent.equals
      
      int result= new StudentMemoDAO().search(userID); 
      
         if(result==1) {
            int Rupdate = new StudentMemoDAO().updateMemo(userID, adminID, content);
            if(Rupdate==-1) {
               PrintWriter script=response.getWriter();
                  script.println("<script>");
                  script.println("alert('memo업로드실패!!!!');");
        			script.println("history.back();");
                  script.println("</script>");
                  script.close();
                  return;
            }else {
               PrintWriter script=response.getWriter();
                  script.println("<script>");
                  script.println("alert('상담내용이 등록되었습니다.');");
        			script.println("history.back();");
                  script.println("</script>");
                  script.close();
                  return;
            }
         }else {
            int Rinsert = new StudentMemoDAO().insertMemo(userID, adminID, content);
            if(Rinsert==-1) {
               PrintWriter script=response.getWriter();
                  script.println("<script>");
                  script.println("alert('첫 상담 내용 insert 실패');");
        			script.println("history.back();");
                  script.println("</script>");
                  script.close();
                  return;
            }else {
               PrintWriter script=response.getWriter();
                  script.println("<script>");
                  script.println("alert('첫 상담 내용 작성 성공');");
      			script.println("history.back();");
                  script.println("</script>");
                  script.close();
                  return;
            }
         }
         
      
   }

}