package board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response); //deleteShow.jsp 에서 삭제할때 get방식으로 전달했기 때문에 doPost로 작동하도록 함수 호출
	}
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		String boardID = request.getParameter("boardID");
		if(boardID ==null || boardID.equals("")) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('접근할 수 없습니다.');");
	         script.println("location.href='boardWrite.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO board = boardDAO.getBoard(boardID);
		if(!userID.equals(board.getUserID())) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('접근할 수 없습니다.');");
	         script.println("location.href='boardWrite.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		String prev = boardDAO.getRealFile(boardID);
		int result = boardDAO.delete(boardID);
		if(result == -1) {  //삭제 실패시
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('삭제에 실패하였습니다.');");
	         script.println("location.href='boardWrite.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}else {
			File prevFile = new File(savePath + "/" + prev);
			if(prevFile.exists()) {
				prevFile.delete();
			}
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('삭제에 성공하였습니다.');");
	         script.println("location.href='boardView.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
	}

}
