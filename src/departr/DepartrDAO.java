package departr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.UserDTO;
import userClass.userClassDTO;
import util.DatabaseUtil;

public class DepartrDAO {
	
	public int Add(String userDepart, String userAdmission, String subjCode, String subjGrade, String subjSemester, String subjDivision) {
	      String SQL="INSERT INTO departr VALUES (?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userDepart);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, userAdmission);
	         pstmt.setString(3, subjCode);
	         pstmt.setString(4, subjGrade);
	         pstmt.setString(5, subjSemester);
	         pstmt.setString(6, subjDivision);
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
	
	public ArrayList<DepartrDTO> getListDepartr(String userDepart, String search, int pageNumber) {
		if(userDepart.equals("전체")) {
			userDepart="";
		}
		ArrayList<DepartrDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT R.userDepart, S.subjName , R.userAdmission, R.subjCode, R.subjGrade, R.subjSemester, R.subjDivision FROM departr R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.userAdmission=S.subjYear AND R.subjSemester=S.subjSemester WHERE R.userDepart LIKE ? AND CONCAT(S.subjName) LIKE ?  ORDER BY R.userDepart ASC LIMIT " + pageNumber*10+ ", " +10;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + userDepart + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt. executeQuery();
			list = new ArrayList<DepartrDTO>();
			while(rs.next()) {
				DepartrDTO depart = new DepartrDTO();
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setUserAdmission(rs.getString("userAdmission"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjGrade(rs.getString("subjGrade"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjDivision(rs.getString("subjDivision"));
				depart.setSubjName(rs.getString("subjName"));
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
	
	//필수과목 list 가져오는 함수
	   public ArrayList<DepartrDTO> getList() {
	      ArrayList<DepartrDTO> list = null;
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      String SQL="";
	      
	      
	      try {
	         SQL="SELECT R.userDepart, S.subjName , R.userAdmission, R.subjCode, R.subjGrade, R.subjSemester, R.subjDivision FROM joined.departr R INNER JOIN joined.subj2 S ON R.subjCode = S.subjCode AND R.userAdmission = S.subjYear and R.subjSemester=S.subjSemester ORDER BY R.userDepart ASC";
	         conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
	         pstmt=conn.prepareStatement(SQL);
	         //pstmt.setString(1, a);
	         rs = pstmt. executeQuery();
	         list = new ArrayList<DepartrDTO>();
	         while(rs.next()) {
	            DepartrDTO depart = new DepartrDTO();
	            depart.setUserDepart(rs.getString("userDepart"));
	            depart.setUserAdmission(rs.getString("userAdmission"));
	            depart.setSubjCode(rs.getString("subjCode"));
	            depart.setSubjGrade(rs.getString("subjGrade"));
	            depart.setSubjSemester(rs.getString("subjSemester"));
	            depart.setSubjDivision(rs.getString("subjDivision"));
	            depart.setSubjName(rs.getString("subjName"));
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

	public DepartrDTO getDepart(String subjCode) {
		DepartrDTO dep = new DepartrDTO();
		String SQL="SELECT * FROM departr WHERE subjCode=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
			rs = pstmt. executeQuery();
			if(rs.next()) {
				dep.setSubjCode(subjCode);
				dep.setUserDepart(rs.getString("userDepart"));
				dep.setUserAdmission(rs.getString("userAdmission"));
				dep.setSubjGrade(rs.getString("subjGrade"));
				dep.setSubjSemester(rs.getString("subjSemester"));
				dep.setSubjDivision(rs.getString("subjDivision"));
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

	public int update(String userDepart, String userAdmission, String subjCode, String subjGrade, String subjSemester, String subjDivision) {
		String SQL="UPDATE departr SET userDepart=?, subjGrade=?, subjSemester=?, subjDivision=? WHERE subjCode=? AND userAdmission=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userDepart);
			pstmt.setString(2, subjGrade);
			pstmt.setString(3, subjSemester);
			pstmt.setString(4, subjDivision);
			pstmt.setString(5, subjCode);
			pstmt.setString(6, userAdmission);
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
	
	public int delDepartr(String subjCode,String userAdmission) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM departr WHERE subjCode=? AND userAdmission=? ";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
			pstmt.setString(2, userAdmission);
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
	
	
	//자신이 수강하지 못한 과목중에 학과 필수 과목인 것들 뽑아오는 함수
    public ArrayList<DepartrDTO> getDepartInstead(String userID, String userAdmission, String userDepart) {
       ArrayList<DepartrDTO> list = null;
       Connection conn=null;
       PreparedStatement pstmt=null;
       ResultSet rs=null;
       String SQL="";
       
       
       try {
          SQL="SELECT DISTINCT I.beInsteadSubjCode, I.beInsteadSubjName FROM joined.insteadtable I WHERE I.beInsteadSubjCode IN (SELECT D.subjCode FROM joined.departr D LEFT JOIN joined.class C ON D.subjCode = C.subjCode AND C.userID = ? WHERE D.userAdmission = ? AND D.userDepart =? AND C.subjName Is null)";
          conn=DatabaseUtil.getConnection();
          pstmt=conn.prepareStatement(SQL);
          pstmt.setString(1, userID);
          pstmt.setString(2, userAdmission);
          pstmt.setString(3, userDepart);
          rs = pstmt. executeQuery();
          list = new ArrayList<DepartrDTO>();
          while(rs.next()) {
             DepartrDTO depart = new DepartrDTO();
             depart.setSubjCode(rs.getString("beInsteadSubjCode"));            
             depart.setSubjName(rs.getString("beInsteadSubjName"));
             list.add(depart);
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
	   
  //대체될 과목의 이수구분, 과목명을 알기위해
    public ArrayList<userClassDTO> getDepartList(String subjCode, String userID) {
          ArrayList<userClassDTO> list = null;
          String SQL="SELECT C.subjMain, S.subjName FROM class C INNER JOIN subj2 S ON C.subjCode = S.subjCode AND C.subjYear=S.subjYear AND C.subjSemester=S.subjSemester WHERE C.subjCode=? AND userID=?";
          Connection conn=null;
          PreparedStatement pstmt=null;
          ResultSet rs=null;
          try {
             conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
             pstmt=conn.prepareStatement(SQL);
             pstmt.setString(1, subjCode);
             pstmt.setString(2, userID);
             rs = pstmt. executeQuery();
             list = new ArrayList<userClassDTO>();
             if(rs.next()) {
                userClassDTO uClass = new userClassDTO();
                            
                uClass.setSubjMain(rs.getString("subjMain"));
                uClass.setSubjName(rs.getString("subjName"));
                list.add(uClass);
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
    //대체될 과목의 이수구분, 과목명을 알기위해  (필수과목에서 조회 -> 대체과목 신청시 수강하지 않은 필수 과목 대체 필요할때)
    public ArrayList<DepartrDTO> getDepartList(String subjCode) {
          ArrayList<DepartrDTO> list = null;
          String SQL="SELECT D.subjDivision, S.subjName FROM departr D INNER JOIN subj2 S ON D.subjCode = S.subjCode AND D.userAdmission=S.subjYear AND D.subjSemester=S.subjSemester WHERE D.subjCode=?";
          Connection conn=null;
          PreparedStatement pstmt=null;
          ResultSet rs=null;
          try {
             conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
             pstmt=conn.prepareStatement(SQL);
             pstmt.setString(1, subjCode);
             rs = pstmt. executeQuery();
             list = new ArrayList<DepartrDTO>();
             if(rs.next()) {
                DepartrDTO dep = new DepartrDTO();
                            
                dep.setSubjDivision(rs.getString("subjDivision"));
                dep.setSubjName(rs.getString("subjName"));
                list.add(dep);
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
