package adminScore;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import departr.DepartrDTO;
import util.DatabaseUtil;

public class adminScoreDAO {
	
	public int Add(String userDepart, String userProcess, String userAdmission, int totalCulture, int totalCultureNecessary,
			int totalMajor, int totalMajorNecessary, int totalGraduate, int totalAbility, int totalFindMajor) {
	      String SQL="INSERT INTO adminscore VALUES (?,?,?,?,?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userDepart);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, userProcess);
	         pstmt.setString(3, userAdmission);
	         pstmt.setInt(4, totalCulture);
	         pstmt.setInt(5, totalCultureNecessary);
	         pstmt.setInt(6, totalMajor);
	         pstmt.setInt(7, totalMajorNecessary);
	         pstmt.setInt(8, totalGraduate);
	         pstmt.setInt(9, totalAbility);
	         pstmt.setInt(10, totalFindMajor);
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
	
	public ArrayList<adminScoreDTO> getList() {
		ArrayList<adminScoreDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT *  FROM adminscore ORDER BY userDepart ASC";
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			rs = pstmt. executeQuery();
			list = new ArrayList<adminScoreDTO>();
			while(rs.next()) {
				adminScoreDTO depart = new adminScoreDTO();
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setUserAdmission(rs.getString("userAdmission"));
				depart.setUserProcess(rs.getString("userProcess"));
				depart.setTotalCulture(rs.getInt("totalCulture"));
				depart.setTotalCultureNecessary(rs.getInt("totalCultureNecessary"));
				depart.setTotalMajor(rs.getInt("totalMajor"));
				depart.setTotalMajorNecessary(rs.getInt("totalMajorNecessary"));
				depart.setTotalGraduate(rs.getInt("totalGraduate"));
				depart.setTotalAbility(rs.getInt("totalAbility"));
				depart.setTotalFindMajor(rs.getInt("totalFindMajor"));
				list.add(depart);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return list;//�쉶�썝媛��엯 �떎�뙣
	}

	public adminScoreDTO getScore(String userProcess, String userDepart, String userAdmission) {
		adminScoreDTO dep = new adminScoreDTO();
		String SQL="SELECT * FROM adminscore WHERE userProcess=? AND userDepart=? AND userAdmission=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userProcess);
			if(userDepart.equals("컴퓨터공학과")) {
				pstmt.setString(2, userDepart);
			}else if(userDepart.equals("IT융합 자율학부")) {
				pstmt.setString(2, userDepart);
			}else {
				pstmt.setString(2, "타과");
			}
			pstmt.setString(3, userAdmission);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				dep.setUserDepart(rs.getString("userDepart"));
				dep.setUserAdmission(rs.getString("userAdmission"));
				dep.setUserProcess(rs.getString("userProcess"));
				dep.setTotalCulture(rs.getInt("totalCulture"));
				dep.setTotalCultureNecessary(rs.getInt("totalCultureNecessary"));
				dep.setTotalMajor(rs.getInt("totalMajor"));
				dep.setTotalMajorNecessary(rs.getInt("totalMajorNecessary"));
				dep.setTotalGraduate(rs.getInt("totalGraduate"));
				dep.setTotalAbility(rs.getInt("totalAbility"));
				dep.setTotalFindMajor(rs.getInt("totalFindMajor"));
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return dep;//�쉶�썝媛��엯 �떎�뙣
	}
	public int update(String userDepart, String userAdmission, String userProcess, int totalCulture, int totalCultureNecessary,
			int totalMajor, int totalMajorNecessary, int totalGraduate, int totalAbility, int totalFindMajor) {
		String SQL="UPDATE adminscore SET totalCulture=?, totalCultureNecessary=?, totalMajor=?, totalMajorNecessary=?, totalGraduate=?, totalAbility=?, totalFindMajor=? WHERE userDepart=? AND userAdmission=? AND userProcess=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
	         pstmt.setInt(1, totalCulture);
	         pstmt.setInt(2, totalCultureNecessary);
	         pstmt.setInt(3, totalMajor);
	         pstmt.setInt(4, totalMajorNecessary);
	         pstmt.setInt(5, totalGraduate);
	         pstmt.setInt(6, totalAbility);
	         pstmt.setInt(7, totalFindMajor);
			 pstmt.setString(8, userDepart);
	         pstmt.setString(9, userAdmission);
	         pstmt.setString(10, userProcess);
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
	
	public int del(String userDepart, String userAdmission, String userProcess) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM adminscore WHERE userDepart=? AND userAdmission=? AND userProcess=? ";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userDepart);
			pstmt.setString(2, userAdmission);
			pstmt.setString(3, userProcess);
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
