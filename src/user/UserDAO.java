package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;


public class UserDAO {

	//로그인
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;
				}
				else {
					return 0;
				}
			}
			return -1;
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -2;
	}
	
	//회원가입
	public int join(String userID, String userPassword, String userEmail, String userGrade, String userSemester, String userDepart, String userName, String userQuestion, String userAnswer, boolean adminApply ,boolean adminChecked) {
	      String SQL="INSERT INTO user VALUES (?,?,?,?,?,?,?,?,?,?, false)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, userPassword);
	         pstmt.setString(3, userEmail);
	         pstmt.setString(4, userGrade);
	         pstmt.setString(5, userSemester);
	         pstmt.setString(6, userDepart);
	         pstmt.setString(7, userName);
	         pstmt.setString(8, userQuestion);
	         pstmt.setString(9, userAnswer);
	         pstmt.setBoolean(10, adminApply );
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

	public UserDTO getUser(String userID) {
		UserDTO user = new UserDTO();
		String SQL="SELECT * FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				user.setUserID(userID);
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserGrade(rs.getString("userGrade"));
				user.setUserDepart(rs.getString("userDepart"));
				user.setUserName(rs.getString("userName"));
				user.setUserQuestion(rs.getString("userQuestion"));
				user.setUserAnswer(rs.getString("userAnswer"));
				user.setAdminChecked(rs.getBoolean("adminChecked"));
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return user;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public int update(String userID, String userPassword, String userEmail, String userDepart, String userName, String userQuestion, String userAnswer) {
		String SQL="UPDATE user SET userPassword=?, userEmail=?, userDepart=?, userName=?, userQuestion=?, userAnswer=? WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userDepart);
			pstmt.setString(4, userName);
			pstmt.setString(5, userQuestion);
			pstmt.setString(6, userAnswer);
			pstmt.setString(7, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;//�쉶�썝媛��엯 �떎�뙣
	}
	
	//비밀번호를 재설정하기 위한 절차1 - 회원가입 시 입력한 질문과 답이 사용자의 아이디와 일치할 때 userid를 반환한다.
	public String search(String userID, String userQuestion, String userAnswer) {
		String userid=null;
		String SQL="SELECT userID FROM user WHERE userID=? and userQuestion=? and userAnswer=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userQuestion);
			pstmt.setString(3, userAnswer);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				userid=rs.getString("userID");
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return userid;
	}
	
	//비밀번호를 재설정하기 위한 절차2
	public int password(String userID, String userPassword) {
		String SQL="UPDATE user SET userPassword=? WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public boolean getAdminChecked(String userID) { //�씠硫붿씪 寃�利�. �씠硫붿씪 寃�利앹쓣 �븯吏� �븡�쑝硫� �궗�슜�옄�뒗 媛뺤쓽 �룊媛�瑜� �옉�꽦�븷 �닔 �뾾�떎.
		String SQL="SELECT adminChecked FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;//�듅�젙�븳 sql臾몄옣�쓣 �꽦怨듭쟻�쑝濡� �닔�뻾�븷 �닔 �엳�룄濡�
		ResultSet rs=null;//�듅�젙�븳 sql臾몄옣�쓣 �떎�뻾�븳 �썑�쓽 寃곌낵瑜� 媛�吏�怨� 泥섎━瑜� �빐二쇨퀬�옄 �븷 �븣
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);//sql臾� �븞�뿉 �엳�뒗 ?(臾쇱쓬�몴)�뿉 �궗�슜�옄媛� �엯�젰�븳 媛믪쓣 set�떆�궓�떎.
			rs=pstmt.executeQuery();
			if(rs.next()) { //寃곌낵媛� 議댁옱�븳�떎硫�, 利� 議댁옱�븯�뒗 �궗�슜�옄�쓽 �븘�씠�뵒�씪 寃쎌슦
				return rs.getBoolean(1);//愿꾪샇 �븞 1�� 泥ル쾲吏� �냽�꽦, 利� userEmailChecked�쓣 諛섑솚�븯�룄濡� �빐以��떎.
				//�꽦怨듭쟻�쑝濡� �궗�슜�옄�쓽 �씠硫붿씪�씠 �씤利앸릺�뿀�떎硫� true 媛� 諛섑솚
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false;//�뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	public boolean setAdminChecked(String userID) { 
		String SQL="UPDATE user SET adminChecked =true WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return false;
	}
	
	public ArrayList<UserDTO> getListUser(String search, int pageNumber, String userGrade, String userSemester, String userDepart) {//관리자 학생관리------------------
	      ArrayList<UserDTO> userList = null;
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         String SQL="SELECT * FROM user WHERE CONCAT(userName) LIKE ? AND userGrade LIKE ? AND userSemester LIKE ? AND userDepart LIKE ? AND adminChecked=false ORDER BY userName ASC LIMIT " + pageNumber*10 + ", " + 10;
	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, "%" + search + "%");
	         if(userGrade.equals("전체")) {
	            pstmt.setString(2, "%");
	         }
	         else{pstmt.setString(2, userGrade);}
	         
	         if(userSemester.equals("전체")) {
	            pstmt.setString(3, "%");
	         }else {pstmt.setString(3, userSemester);}
	         
	         if(userDepart.equals("전체")) {
	            pstmt.setString(4, "%");
	         }else {pstmt.setString(4, userDepart);}
	         
	         
	         rs = pstmt. executeQuery();
	         
	         userList = new ArrayList<UserDTO>();
	         while(rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserID(rs.getString("userID"));
	            user.setUserName(rs.getString("userName"));
	            user.setUserGrade(rs.getString("userGrade"));
	            user.setUserSemester(rs.getString("userSemester"));
	            user.setUserDepart(rs.getString("userDepart"));
	            user.setUserName(rs.getString("userName")); ////////////미충족 졸업요건--------------
	            user.setUserEmail(rs.getString("userEmail"));
	            userList.add(user);
	         }
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return userList;//�쉶�썝媛��엯 �떎�뙣
	   }
	
	public ArrayList<UserDTO> getListUser4(String search, int pageNumber, String userDepart, String a) {//관리자 학생관리------------------18학번 전
	      ArrayList<UserDTO> userList = null;
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	    	 if(a.equals("전체")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
	 	         		//+ "AND (S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false OR S.majorNeceSatisfy=false OR S.majorReqSatisfy=false OR S.graduPossible=false)"
	 	         		+ "AND (S.graduPossible=false)"
	 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
	 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
	 	         pstmt=conn.prepareStatement(SQL); 
	 	         pstmt.setString(1, "%" + search + "%");
	 	         
	    	 }else if(a.equals("전공 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND (S.cultureNeceSatisfy=true AND S.cultureReqSatisfy=true AND (S.majorNeceSatisfy=false OR S.majorReqSatisfy=false) AND S.graduPossible=false)"
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }else if(a.equals("교양 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND ((S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false) AND S.majorNeceSatisfy=true AND S.majorReqSatisfy=true AND S.graduPossible=false)"
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }else if(a.equals("종합 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND (((S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false) AND (S.majorNeceSatisfy=false OR S.majorReqSatisfy=false) AND S.graduPossible=false)" 
		 	         		+ "OR ((S.cultureNeceSatisfy=true AND S.cultureReqSatisfy=true) AND (S.majorNeceSatisfy=true AND S.majorReqSatisfy=true) AND S.graduPossible=false))" 
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }
 	         
 	         if(userDepart.equals("전체")) {
 	            pstmt.setString(2, "%");
 	         }else {pstmt.setString(2, userDepart);
 	         }
 	         
	         rs = pstmt. executeQuery();
	         
	         userList = new ArrayList<UserDTO>();
	         while(rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserID(rs.getString("userID"));
	            user.setUserName(rs.getString("userName"));
	            user.setUserGrade(rs.getString("userGrade"));
	            user.setUserDepart(rs.getString("userDepart"));
	            user.setUserName(rs.getString("userName")); ////////////미충족 졸업요건--------------
	            user.setUserEmail(rs.getString("userEmail"));
	            user.setCultureNeceSatisfy(rs.getBoolean("cultureNeceSatisfy"));
	            user.setMajorReqSatisfy(rs.getBoolean("majorReqSatisfy"));
	            user.setGraduPossible(rs.getBoolean("graduPossible"));
	            user.setCultureReqSatisfy(rs.getBoolean("cultureReqSatisfy"));
	            user.setMajorNeceSatisfy(rs.getBoolean("majorNeceSatisfy"));
	            user.setFindSatisfy(rs.getBoolean("findSatisfy"));
	            userList.add(user);
	         }
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return userList;//�쉶�썝媛��엯 �떎�뙣
	   }
	
	public ArrayList<UserDTO> getListUser18(String search, int pageNumber, String userDepart, String a) {//관리자 학생관리------------------18학번
	      ArrayList<UserDTO> userList = null;
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	    	 if(a.equals("전체")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
	 	         		//+ "AND (S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false OR S.majorNeceSatisfy=false OR S.majorReqSatisfy=false OR S.graduPossible=false)"
	 	         		+ "AND (S.graduPossible=false)"
	 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
	 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
	 	         pstmt=conn.prepareStatement(SQL); 
	 	         pstmt.setString(1, "%" + search + "%");
	 	         
	    	 }else if(a.equals("전공 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND (S.cultureNeceSatisfy=true AND S.cultureReqSatisfy=true AND (S.majorNeceSatisfy=false OR S.majorReqSatisfy=false OR FindSatisfy=false) AND S.graduPossible=false)"
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }else if(a.equals("교양 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND ((S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false) AND S.majorNeceSatisfy=true AND S.majorReqSatisfy=true AND S.graduPossible=false AND FindSatisfy=true)"
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }else if(a.equals("종합 미충족")) {
	    		 String SQL="SELECT * FROM user R INNER JOIN userscore S ON R.userID = S.userID WHERE CONCAT(R.userID) LIKE ? AND (R.userSemester='8' OR R.userSemester='9') AND R.userDepart LIKE ? "
		 	         		+ "AND (((S.cultureNeceSatisfy=false OR S.cultureReqSatisfy=false) AND (S.majorNeceSatisfy=false OR S.majorReqSatisfy=false OR S.FindSatisfy=false) AND S.graduPossible=false)"
		 	         		+ "OR ((S.cultureNeceSatisfy=true AND S.cultureReqSatisfy=true) AND (S.majorNeceSatisfy=true AND S.majorReqSatisfy=true AND  S.FindSatisfy=true) AND S.graduPossible=false))" 
		 	         		+ " AND R.adminChecked=false ORDER BY R.userName ASC LIMIT " + pageNumber*5 + ", " + 5;
		 	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
		 	         pstmt=conn.prepareStatement(SQL); 
		 	         pstmt.setString(1, "%" + search + "%");
	    	 }
	         
	         if(userDepart.equals("전체")) {
	            pstmt.setString(2, "%");
	         }else {pstmt.setString(2, userDepart);
	         }
	         
	         rs = pstmt. executeQuery();
	         
	         userList = new ArrayList<UserDTO>();
	         while(rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserID(rs.getString("userID"));
	            user.setUserName(rs.getString("userName"));
	            user.setUserGrade(rs.getString("userGrade"));
	            user.setUserDepart(rs.getString("userDepart"));
	            user.setUserName(rs.getString("userName")); ////////////미충족 졸업요건--------------
	            user.setUserEmail(rs.getString("userEmail"));
	            user.setCultureNeceSatisfy(rs.getBoolean("cultureNeceSatisfy"));
	            user.setMajorReqSatisfy(rs.getBoolean("majorReqSatisfy"));
	            user.setGraduPossible(rs.getBoolean("graduPossible"));
	            user.setCultureReqSatisfy(rs.getBoolean("cultureReqSatisfy"));
	            user.setMajorNeceSatisfy(rs.getBoolean("majorNeceSatisfy"));
	            user.setFindSatisfy(rs.getBoolean("findSatisfy"));
	            userList.add(user);
	         }
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return userList;//�쉶�썝媛��엯 �떎�뙣
	   }
	public ArrayList<UserDTO> getListAdmin(String search, int pageNumber) {
		ArrayList<UserDTO> userList = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT * FROM user WHERE adminApply=? AND adminChecked=false AND CONCAT(userID) LIKE ? ORDER BY userName ASC LIMIT " + pageNumber*5 + ", " + 5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "1");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt. executeQuery();
			userList = new ArrayList<UserDTO>();
			while(rs.next()) {
				UserDTO user = new UserDTO();
				user.setUserID(rs.getString("userID"));
				user.setUserName(rs.getString("userName"));
				userList.add(user);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return userList;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public String getUserName(String userID) {
		UserDTO user = new UserDTO();
		String SQL="SELECT * FROM user WHERE userID=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				user.setUserID(userID);
				user.setUserName(rs.getString("userName"));
			}
			return user.getUserName();
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return null;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public int registerCheck(String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0; // 이미 존재하는 회원, 사용자가 id 입력난 빈칸으로				
			}
			else {
				return 1; //가입가능한 회원
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs !=null)
					rs.close();
				if(pstmt !=null)
					pstmt.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류
	}
	
	public int delUser(String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM user WHERE userID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
}
