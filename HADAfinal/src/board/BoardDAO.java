package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import util.DatabaseUtil;

public class BoardDAO {
	DataSource dataSource;
	
	 //게시글 삽입
	   public int write(String userID, String boardTitle,String boardContent, String boardFile, String boardRealFile) {
	         String SQL="INSERT INTO board SELECT ?, IFNULL((SELECT MAX(boardID) + 1 FROM board), 1), ?, ?, now(), 0, ?, ?, IFNULL((SELECT MAX(boardGroup) + 1 FROM board), 0), 0, 0, 1";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	            pstmt.setString(2, boardTitle);
	            pstmt.setString(3, boardContent);
	            pstmt.setString(4, boardFile);
	            pstmt.setString(5, boardRealFile);
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }

	   //게시글 조회
	   public BoardDTO getBoard(String boardID) {
		   BoardDTO board = new BoardDTO();
		      String SQL="SELECT * FROM board WHERE boardID = ?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection(); //DB connection
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, boardID);
		         rs = pstmt. executeQuery();
		         if(rs.next()) {
		        	 board.setUserID(rs.getString("userID"));
		        	 board.setBoardID(rs.getInt("boardID"));
		        	 board.setBoardTitle(rs.getString("boardTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
		        	 board.setBoardContent(rs.getString("boardContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
		        	 board.setBoardDate(rs.getString("boardDate").substring(0, 11));
		        	 board.setBoardHit(rs.getInt("boardHit"));
		        	 board.setBoardFile(rs.getString("boardFile"));
		        	 board.setBoardRealFile(rs.getString("boardRealFile"));
		        	 board.setBoardGroup(rs.getInt("boardGroup"));
		        	 board.setBoardSequence(rs.getInt("boardSequence"));
		        	 board.setBoardLevel(rs.getInt("boardLevel"));
		        	 board.setBoardAvailable(rs.getInt("boardAvailable"));
		         }
		        
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return board;
		   }
	   
	   //게시글 조회
	   public ArrayList<BoardDTO> getList(String pageNumber) {
		   ArrayList<BoardDTO> boardList = null;	
		   String SQL="SELECT * FROM board WHERE boardGroup > (SELECT MAX(boardGroup) FROM board) - ? AND boardGroup <= (SELECT MAX(boardGroup) FROM board) - ? ORDER BY boardGroup DESC,boardSequence ASC";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection(); //DB connection
		         pstmt=conn.prepareStatement(SQL);
			     pstmt.setInt(1, Integer.parseInt(pageNumber) * 10);
			     pstmt.setInt(2, (Integer.parseInt(pageNumber) -1) * 10);
		         rs = pstmt. executeQuery();
		         boardList = new ArrayList<BoardDTO>();
		         while(rs.next()) {
		        	 BoardDTO board = new BoardDTO();
		        	 board.setUserID(rs.getString("userID"));
		        	 board.setBoardID(rs.getInt("boardID"));
		        	 board.setBoardTitle(rs.getString("boardTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
		        	 board.setBoardContent(rs.getString("boardContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
		        	 board.setBoardDate(rs.getString("boardDate").substring(0, 11));
		        	 board.setBoardHit(rs.getInt("boardHit"));
		        	 board.setBoardFile(rs.getString("boardFile"));
		        	 board.setBoardRealFile(rs.getString("boardRealFile"));
		        	 board.setBoardGroup(rs.getInt("boardGroup"));
		        	 board.setBoardSequence(rs.getInt("boardSequence"));
		        	 board.setBoardLevel(rs.getInt("boardLevel"));
		        	 board.setBoardAvailable(rs.getInt("boardAvailable"));
		        	 boardList.add(board);
		         }
		        
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return boardList;
		   }
	   
	   //게시글 조회수
	   public int hit(String boardID) {
	         String SQL="UPDATE board SET boardHit = boardHIt + 1 WHERE boardID =?";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setString(1, boardID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	           
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }
	   
	   //파일 다운로드
	   public String getFile(String boardID) {
		  String SQL="SELECT boardFile FROM board WHERE boardID =?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection(); //DB connection
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, boardID);
		         rs = pstmt. executeQuery();
		         if(rs.next()) {
		        	 return rs.getString("boardFile");
		         }
		         return "";
		        
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return "";
		   }
	   
	 //파일 실제 물리적 경로
	   public String getRealFile(String boardID) {
		     String SQL="SELECT boardRealFile FROM board WHERE boardID =?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection(); //DB connection
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, boardID);
		         rs = pstmt. executeQuery();
		         if(rs.next()) {
		        	 return rs.getString("boardRealFile");
		         }
		         return "";
		        
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return "";
		   }
	   
	 //게시글 수정
	   public int update(String boardID, String boardTitle,String boardContent, String boardFile, String boardRealFile) {
	         String SQL="UPDATE board SET boardTitle =?, boardContent=?, boardFile=?, boardRealFile=? WHERE boardID=?";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setString(1, boardTitle);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	            pstmt.setString(2, boardContent);
	            pstmt.setString(3, boardFile);
	            pstmt.setString(4, boardRealFile);
	            pstmt.setInt(5, Integer.parseInt(boardID));
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }
	   
	 //게시글 삭제
	   public int delete(String boardID) {
	         String SQL="UPDATE board SET boardAvailable = 0 WHERE boardID =?";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setInt(1, Integer.parseInt(boardID));
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }
	   
	 //게시글 답변 작성
	   public int reply(String userID, String boardTitle,String boardContent, String boardFile, String boardRealFile, BoardDTO parent) {
	         String SQL="INSERT INTO board SELECT ?, IFNULL((SELECT MAX(boardID) + 1 FROM board), 1), ?, ?, now(), 0, ?, ?, ?, ?, ?, 1";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	            pstmt.setString(2, boardTitle);
	            pstmt.setString(3, boardContent);
	            pstmt.setString(4, boardFile);
	            pstmt.setString(5, boardRealFile);
	            pstmt.setInt(6, parent.getBoardGroup());
	            pstmt.setInt(7, parent.getBoardSequence()+1);
	            pstmt.setInt(8, parent.getBoardLevel()+1);   //들여 쓰기를 위해
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }
	   
	 //답변이 달리면 Sequence +1 해주기
	   public int replyUpdate(BoardDTO parent) {
	         String SQL="UPDATE board SET boardSequence = boardSequence + 1 WHERE boardGroup=? AND boardSequence > ? ";
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         try {
	            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setInt(1, parent.getBoardGroup());
	            pstmt.setInt(2, parent.getBoardSequence());
	           
	            return pstmt.executeUpdate();
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return -1;//memo 저장 실패
	      }
	   
	   
	   //다음 페이지 있는지 조회
	   public boolean nextPage(String pageNumber) {
			  String SQL="SELECT * FROM board WHERE boardGroup >= ? ";
			      Connection conn=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      try {
			         conn=DatabaseUtil.getConnection(); //DB connection
			         pstmt=conn.prepareStatement(SQL);
			         pstmt.setInt(1, Integer.parseInt(pageNumber) * 10);
			         rs = pstmt. executeQuery();
			         if(rs.next()) {
			        	 return true;
			         }
			        
			      } catch(Exception e){
			         e.printStackTrace();
			      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
			      }
			      return false;
			   }
	   
	   public int targetPage(String pageNumber) {
			  String SQL="SELECT COUNT(boardGroup) FROM board WHERE boardGroup > ?";
			      Connection conn=null;
			      PreparedStatement pstmt=null;
			      ResultSet rs=null;
			      try {
			         conn=DatabaseUtil.getConnection(); //DB connection
			         pstmt=conn.prepareStatement(SQL);
			         pstmt.setInt(1, (Integer.parseInt(pageNumber) -1) * 10);
			         rs = pstmt. executeQuery();
			         if(rs.next()) {
			        	 return rs.getInt(1) / 10;
			         }
			        
			      } catch(Exception e){
			         e.printStackTrace();
			      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
			      }
			      return 0;
			   }
}
