package subj;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import departr.DepartrDAO;
import departr.DepartrDTO;
import util.DatabaseUtil;

public class SubjDAO {
	
	public ArrayList<SubjDTO> getListSubj(String userDepart, String search, int pageNumber) {
		if(userDepart.equals("전체")) {
			userDepart="";
		}
		ArrayList<SubjDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT bigDepartName, userDepart , subjCode, subjName, subjInsteadCode, subjInsteadName, subjYear, subjSemester  FROM subj WHERE userDepart LIKE ? AND CONCAT(subjCode) LIKE ?  AND subjInsteadCode IS NOT NULL AND subjInsteadName IS NOT NULL ORDER BY userDepart ASC LIMIT " + pageNumber*5+ ", " +5;
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + userDepart + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt. executeQuery();
			list = new ArrayList<SubjDTO>();
			while(rs.next()) {
				SubjDTO subj = new SubjDTO();
				subj.setBigDepartName(rs.getString("bigDepartName"));
				subj.setUserDepart(rs.getString("userDepart"));
				subj.setSubjCode(rs.getString("subjCode"));
				subj.setSubjName(rs.getString("subjName"));
				subj.setSubjInsteadCode(rs.getString("subjInsteadCode"));
				subj.setSubjInsteadName(rs.getString("subjInsteadName"));
				subj.setSubjYear(rs.getString("subjYear"));
				subj.setSubjSemester(rs.getString("subjSemester"));
				list.add(subj);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { 
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return list;//�쉶�썝媛��엯 �떎�뙣
	}
	public ArrayList<SubjDTO> getListSubj2() {
		ArrayList<SubjDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT bigDepartName, userDepart , subjCode, subjName, subjYear, subjSemester  FROM subj2 ORDER BY userDepart ASC ";
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			rs = pstmt. executeQuery();
			list = new ArrayList<SubjDTO>();
			while(rs.next()) {
				SubjDTO subj = new SubjDTO();
				subj.setBigDepartName(rs.getString("bigDepartName"));
				subj.setUserDepart(rs.getString("userDepart"));
				subj.setSubjCode(rs.getString("subjCode"));
				subj.setSubjName(rs.getString("subjName"));
				subj.setSubjYear(rs.getString("subjYear"));
				subj.setSubjSemester(rs.getString("subjSemester"));
				list.add(subj);
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
	
	public int update(String subjCode, String subjName, String subjInsteadCode, String subjInsteadName) {
		String SQL="UPDATE subj SET  subjName=?, subjInsteadCode=?, subjInsteadName=? WHERE subjCode=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, subjName);
			pstmt.setString(2, subjInsteadCode);
			pstmt.setString(3, subjInsteadName);
			pstmt.setString(4, subjCode);
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
	
	public int delInstead(String subjInsteadCode, String subjInsteadName, String subjCode) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="UPDATE subj SET subjInsteadCode=null, subjInsteadName=null  WHERE subjCode=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
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
	
	public ArrayList<SubjDTO> getListCapa(String coreCapaName, String search, int pageNumber) {
		if(coreCapaName.equals("전체")) {
			coreCapaName="";
		}
		ArrayList<SubjDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		 
		try {
			SQL="SELECT subjYear, subjSemester, subjCode, coreCapaName , detailAreaName, subjName, subjScore  FROM subj2 WHERE coreCapaName LIKE ? AND CONCAT(subjName) LIKE ?  AND coreCapaName IS NOT NULL AND detailAreaName IS NOT NULL ORDER BY userDepart ASC LIMIT " + pageNumber*5+ ", " +5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + coreCapaName + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt. executeQuery();
			list = new ArrayList<SubjDTO>();
			while(rs.next()) {
				SubjDTO subj = new SubjDTO();
				subj.setSubjCode(rs.getString("subjCode"));
				subj.setCoreCapaName(rs.getString("coreCapaName"));
				subj.setDetailAreaName(rs.getString("detailAreaName"));
				subj.setSubjName(rs.getString("subjName"));
				subj.setSubjScore(rs.getString("subjScore"));
				subj.setSubjYear(rs.getString("subjYear"));
				subj.setSubjSemester(rs.getString("subjSemester"));
				list.add(subj);
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
	

	public int Capaupdate(String coreCapaName, String detailAreaName, String subjCode) {
		String SQL="UPDATE subj2 SET coreCapaName=?, detailAreaName=? WHERE subjYear='2018' AND subjCode=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, coreCapaName);
			pstmt.setString(2, detailAreaName);
			pstmt.setString(3, subjCode);
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
	
	
	public int delCapa(String coreCapaName, String detailAreaName, String subjCode) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="UPDATE subj2 SET coreCapaName=null, detailAreaName=null  WHERE subjYear='2018' AND subjCode=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
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
