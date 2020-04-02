package studentMemo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import util.DatabaseUtil;

public class StudentMemoDAO {
   
   
   //memo 테이블 내에 해당 상담 내역이 존재하는 검사하는 함수
   public String getMemoContent(String userID, String adminID) {
      StudentMemoDTO memo = new StudentMemoDTO();
      String SQL="SELECT memoContent, memoTime FROM userStudentMemo WHERE userID=? AND adminID=?";
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      String error = "첫 상담내용을 작성해 주세요.";
      String contentDate ="";
      try {
         conn=DatabaseUtil.getConnection(); //DB connection
         pstmt=conn.prepareStatement(SQL);
         pstmt.setString(1, userID);
         pstmt.setString(2, adminID);
         rs = pstmt. executeQuery();
         if(rs.next()) {
            memo.setUserID(userID);
            memo.setAdminID(adminID);
            memo.setMemoContent(rs.getString("memoContent"));
            memo.setMemoTime(rs.getString("memoTime"));
         }else {
            return error; 
         }
         contentDate =memo.getMemoContent()+memo.getMemoTime();
         return contentDate;
      } catch(Exception e){
         e.printStackTrace();
      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
      }
      return null;
   }
   
   
   //현재 시간 출력 함수
   public String getDate() {
      Connection conn=null;
     
       ResultSet rs=null;
      String SQL = "SELECT NOW()";
      try {
         conn=DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(SQL);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            return rs.getString(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      }
      return "";
   }
   
   
   //상담내용 삽입 함수
   public int insertMemo(String userID, String adminID, String memoContent) {
         String SQL="INSERT INTO userStudentMemo VALUES (?,?,?,?)";
         Connection conn=null;
         PreparedStatement pstmt=null;
         ResultSet rs=null;
         try {
            conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
            pstmt=conn.prepareStatement(SQL);
            pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
            pstmt.setString(2, adminID);
            pstmt.setString(3, memoContent);
            pstmt.setString(4, "  <작성일: "+getDate()+">"); //현재 시간 set
            
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
   
   
   //상담 내용 update 함수
   public int updateMemo(String userID, String adminID, String memoContent) {
      String SQL = "UPDATE userStudentMemo SET memoContent=?, memoTime=? WHERE userID = ? AND adminID =?";
      Connection conn=null;
       PreparedStatement pstmt=null;
       ResultSet rs=null;
      try { 
         conn=DatabaseUtil.getConnection();
         pstmt = conn.prepareStatement(SQL);
         pstmt.setString(1, memoContent);
         pstmt.setString(2, "  <작성일: "+getDate()+">");
         pstmt.setString(3,userID);
         pstmt.setString(4,adminID);
         
         return pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
           try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
           try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
           try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
       } 
      return -1; //update 실패
   }

   public int search(String userID) {
		//String SQL="SELECT userID FROM userscore WHERE userName=?";
		String SQL="SELECT * FROM userStudentMemo WHERE userID = ?";
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