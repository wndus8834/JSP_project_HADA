package board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import user.UserDAO;


public class BoardReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		MultipartRequest multi = null;
		int fileMaxSize = 10*1024*1024;
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		System.out.println(savePath);
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('파일 업로드 오류발생!.');");
	         script.println("location.href='index.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		String userID = multi.getParameter("userID");
		System.out.println("유저아이디"+userID);
		HttpSession session = request.getSession();
		if(!userID.equals((String) session.getAttribute("userID"))) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('접근할 수 없습니다.');");
	         script.println("location.href='index.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		String boardID = multi.getParameter("boardID");
		if(boardID == null || boardID.equals("")) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('올바른 접근이 아닙니다');");
	         script.println("location.href='boardView.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		String boardTitle = multi.getParameter("boardTitle");
		String boardContent = multi.getParameter("boardContent");
		if(boardTitle == null || boardTitle.equals("") || boardContent == null || boardContent.equals("")) {
			PrintWriter script=response.getWriter();
	         script.println("<script>");
	         script.println("alert('내용을 입력해 주시기 바랍니다.');");
	         script.println("location.href='boardWrite.jsp';");
	         script.println("</script>");
	         script.close();
	         return;
		}
		String boardFile ="";
		String boardRealFile ="";
		File file = multi.getFile("boardFile");
		if(file != null) {
			boardFile = multi.getOriginalFileName("boardFile");
			boardRealFile = file.getName();
		}
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO parent = boardDAO.getBoard(boardID);
		boardDAO.replyUpdate(parent);
		boardDAO.reply(userID, boardTitle, boardContent, boardFile, boardRealFile, parent);
		
		PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('성공적으로 답변이 작성되었습니다.');");
        script.println("location.href='boardView.jsp';");
        script.println("</script>");
        script.close();
        return;
	}

}
