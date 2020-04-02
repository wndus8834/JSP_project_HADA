package insteadSubj;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import subj.SubjDTO;
import userClass.userClassDTO;
import util.DatabaseUtil;

public class InsteadSubjDAO {
	//대체 과목 리시트 뽑는 함수
		public ArrayList<InsteadSubjDTO> getListSubj(String userDepart, String search, int pageNumber) {
			if(userDepart.equals("전체")) {
				userDepart="";
			}
			ArrayList<InsteadSubjDTO> list = null;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String SQL="";
			
			
			try {
				SQL="SELECT bigDepartName, beInsteadDepart, beInsteadSubjCode, beInsteadSubjName, InsteadSubjCode, InsteadSubjName FROM insteadtable WHERE beInsteadDepart LIKE ? AND CONCAT(beInsteadSubjName)  LIKE ?  AND InsteadSubjCode IS NOT NULL AND InsteadSubjName IS NOT NULL ORDER BY beInsteadDepart ASC LIMIT " + pageNumber*10+ ", " +10;
				conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + userDepart + "%");
				pstmt.setString(2, "%" + search + "%");
				rs = pstmt. executeQuery();
				list = new ArrayList<InsteadSubjDTO>();
				while(rs.next()) {
					InsteadSubjDTO subj = new InsteadSubjDTO();
					subj.setBigDepartName(rs.getString("bigDepartName"));
					subj.setBeInsteadDepart(rs.getString("beInsteadDepart"));
					subj.setBeInsteadSubjCode(rs.getString("beInsteadSubjCode"));
					subj.setBeInsteadSubjName(rs.getString("beInsteadSubjName"));
					subj.setInsteadSubjCode(rs.getString("InsteadSubjCode"));
					subj.setInsteadSubjName(rs.getString("InsteadSubjName"));
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
		
		//대체과목 수정 함수
		public int update(String subjCode, String subjName, String subjInsteadCode, String subjInsteadName) {
			String SQL="UPDATE insteadtable SET  beInsteadSubjName=?, insteadSubjCode=?, InsteadSubjName=? WHERE beInsteadSubjCode=?";
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
		
		//대체과목 삭제 함수
		public int delInstead(String subjCode) {
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String SQL="DELETE FROM insteadtable WHERE beInsteadSubjCode=?";
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
		
		//대체과목 등록 함수
		public int Capaupdate(String bigDepartName, String beInsteadDepart, String beInsteadSubjCode, String beInsteadSubjName, String subjMain, String subjScore, String insteadSubjCode, String insteadSubjName) {
			String SQL="INSERT INTO insteadtable (bigDepartName, beInsteadDepart, beInsteadSubjCode, beInsteadSubjName, subjMain, subjScore, insteadSubjCode, insteadSubjName)"
					+"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, bigDepartName);
				pstmt.setString(2, beInsteadDepart);
				pstmt.setString(3, beInsteadSubjCode);
				pstmt.setString(4, beInsteadSubjName);
				pstmt.setString(5, subjMain);
				pstmt.setString(6, subjScore);
				pstmt.setString(7, insteadSubjCode);
				pstmt.setString(8, insteadSubjName);
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
		
		public ArrayList<InsteadSubjDTO> getListInsteadSubj() {
			ArrayList<InsteadSubjDTO> list = null;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String SQL="";
			
			
			try {
				SQL="SELECT bigDepartName, beInsteadDepart, beInsteadSubjCode, beInsteadSubjName, insteadSubjCode, insteadSubjName, subjMain FROM joined.insteadtable ORDER BY beInsteadDepart ASC";
				conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
				pstmt=conn.prepareStatement(SQL);
				rs = pstmt. executeQuery();
				list = new ArrayList<InsteadSubjDTO>();
				while(rs.next()) {
					InsteadSubjDTO subj = new InsteadSubjDTO();
					subj.setBigDepartName(rs.getString("bigDepartName"));
					subj.setBeInsteadDepart(rs.getString("beInsteadDepart"));
					subj.setBeInsteadSubjCode(rs.getString("beInsteadSubjCode"));
					subj.setBeInsteadSubjName(rs.getString("beInsteadSubjName"));
					subj.setInsteadSubjCode(rs.getString("insteadSubjCode"));
					subj.setInsteadSubjName(rs.getString("insteadSubjName"));
					subj.setSubjMain(rs.getString("subjMain"));
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
		
		//대체과목 리스트 뽑기위한 함수 -> InsteadGetServlet에서 사용
		public ArrayList<InsteadSubjDTO> getInsteadSubj(String subjCode) {
			
			ArrayList<InsteadSubjDTO> list = null;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String SQL="";
			
			
			try {
				SQL="SELECT InsteadSubjCode, InsteadSubjName, beInsteadDepart, subjScore FROM insteadtable WHERE beInsteadSubjCode = ? ";
				conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
				pstmt=conn.prepareStatement(SQL);
				pstmt.setString(1, subjCode);
				rs = pstmt. executeQuery();
				list = new ArrayList<InsteadSubjDTO>();
				while(rs.next()) {
					InsteadSubjDTO subj = new InsteadSubjDTO();
					
					subj.setInsteadSubjCode(rs.getString("InsteadSubjCode"));
					subj.setInsteadSubjName(rs.getString("InsteadSubjName"));
					subj.setBeInsteadDepart(rs.getString("beInsteadDepart"));
					subj.setSubjScore(rs.getString("subjScore"));
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
	
		//userID && 같은 학과 && insteadName 에 따라 수강한 과목 불러오는 함수
		public ArrayList<userClassDTO> getUserListClass(String userID, String condition, String insteadSubjCode) {
			
			ArrayList<userClassDTO> list = null;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String SQL="";
			
			
			try {
				if(condition.equals("전선")) {
					SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj S ON C.subjCode = S.subjCode WHERE C.userID = ? AND C.subjMain = '전선' ";
					conn=DatabaseUtil.getConnection();
					pstmt=conn.prepareStatement(SQL);
					pstmt.setString(1, userID);
				}else if(condition.equals("교선")) {
					SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj S ON C.subjCode = S.subjCode WHERE C.userID = ? AND C.subjMain = '교선' ";
					conn=DatabaseUtil.getConnection();
					pstmt=conn.prepareStatement(SQL);
					pstmt.setString(1, userID);
				}else {
					SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj S ON C.subjCode = S.subjCode WHERE C.userID = ? AND C.subjCode = ? ";
					conn=DatabaseUtil.getConnection();
					pstmt=conn.prepareStatement(SQL);
					pstmt.setString(1, userID);
					pstmt.setString(2, insteadSubjCode);
				}
				
				
				
				rs = pstmt. executeQuery();
				list = new ArrayList<userClassDTO>();
				while(rs.next()) {
					userClassDTO depart = new userClassDTO();
					
					depart.setSubjCode(rs.getString("subjCode"));
					depart.setSubjName(rs.getString("subjName"));
					depart.setGrade(rs.getString("grade")); 
					
					depart.setUserDepart(rs.getString("userDepart"));
					
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

}
