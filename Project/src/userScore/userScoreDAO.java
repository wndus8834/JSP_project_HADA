package userScore;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.UserDTO;
import util.DatabaseUtil;

public class userScoreDAO {
	public int Add(String userID, String refinementScore, String culturalReqScore, String majorSelectScore, String majorReqScore, String capaReinforceScore, String majorFind) {
	      String SQL="INSERT INTO userscore(userID,refinementScore,culturalReqScore,majorSelectScore,majorReqScore,capaReinforceScore,majorFind) VALUES (?,?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, refinementScore);
	         pstmt.setString(3, culturalReqScore);
	         pstmt.setString(4, majorSelectScore);
	         pstmt.setString(5, majorReqScore);
	         pstmt.setString(6, capaReinforceScore);
	         pstmt.setString(7, majorFind);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	   }
	public int update(String userID, String refinementScore, String culturalReqScore, String majorSelectScore, String majorReqScore, String capaReinforceScore, String majorFind) {
		      String SQL="UPDATE userscore SET refinementScore=?,culturalReqScore=?,majorSelectScore=?,majorReqScore=?,capaReinforceScore=?,majorFind=? WHERE userID=?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setString(1, refinementScore);
		         pstmt.setString(2, culturalReqScore);
		         pstmt.setString(3, majorSelectScore);
		         pstmt.setString(4, majorReqScore);
		         pstmt.setString(5, capaReinforceScore);
		         pstmt.setString(6, majorFind);
		         pstmt.setString(7, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
		         return pstmt.executeUpdate();
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return -1;//회원가입 실패
		  }
	
	public int AddCheck(String userID, boolean cultureNeceSatisfy, boolean cultureReqSatisfy, boolean majorNeceSatisfy, boolean majorReqSatisfy, boolean graduPossible, boolean FindSatisfy) {
	      String SQL="INSERT INTO userscore(userID,cultureNeceSatisfy,cultureReqSatisfy,majorNeceSatisfy,majorReqSatisfy, graduPossible,FindSatisfy) VALUES (?,?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setBoolean(2, cultureNeceSatisfy);
	         pstmt.setBoolean(3, cultureReqSatisfy);
	         pstmt.setBoolean(4, majorNeceSatisfy);
	         pstmt.setBoolean(5, majorReqSatisfy);
	         pstmt.setBoolean(6, graduPossible);
	         pstmt.setBoolean(7, FindSatisfy);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	   }
	public int updateCheck(String userID, boolean cultureNeceSatisfy, boolean cultureReqSatisfy, boolean majorNeceSatisfy, boolean majorReqSatisfy, boolean graduPossible, boolean FindSatisfy) {
		      String SQL="UPDATE userscore SET cultureNeceSatisfy=?,cultureReqSatisfy=?,majorNeceSatisfy=?,majorReqSatisfy=?,graduPossible=?,FindSatisfy=? WHERE userID=?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setBoolean(1, cultureNeceSatisfy);
		         pstmt.setBoolean(2, cultureReqSatisfy);
		         pstmt.setBoolean(3, majorNeceSatisfy);
		         pstmt.setBoolean(4, majorReqSatisfy);
		         pstmt.setBoolean(5, graduPossible);
		         pstmt.setBoolean(6, FindSatisfy);
		         pstmt.setString(7, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
		         return pstmt.executeUpdate();
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return -1;//회원가입 실패
		  }
	
	public userScoreDTO getUserScore(String userID) {
		userScoreDTO score = new userScoreDTO();
		String SQL="SELECT * FROM userscore WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				score.setUserID(userID);
				score.setRefinementScore(rs.getString("refinementScore"));
				score.setCulturalReqScore(rs.getString("culturalReqScore"));
				score.setMajorSelectScore(rs.getString("majorSelectScore"));
				score.setMajorReqScore(rs.getString("majorReqScore"));
				score.setCapaReinforceScore(rs.getString("capaReinforceScore"));
				score.setMajorFind(rs.getString("majorFind"));
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return score;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public int search(String userID) {
		//String SQL="SELECT userID FROM userscore WHERE userName=?";
		String SQL="SELECT * FROM userscore WHERE userID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return 1;
			}else {
				return -1;
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -2;//�쉶�썝媛��엯 �떎�뙣
	}
}
