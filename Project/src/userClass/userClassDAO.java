package userClass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class userClassDAO {
	
	public ArrayList<userClassDTO> getListClass(String subjYear, String subjSemester, String subjMain, String search, int pageNumber) {
		if(subjYear.equals("전체")) {
			subjYear="";
		}
		if(subjSemester.equals("전체")) {
			subjSemester="";
		}
		if(subjMain.equals("전체")) {
			subjMain="";
		}
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, R.subjName, R.subjMain,R.score, R.userID, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.subjYear=S.subjYear AND R.subjSemester=S.subjSemester WHERE R.subjYear LIKE ? AND R.subjSemester LIKE ? AND R.subjMain LIKE ? AND CONCAT(R.subjCode) LIKE ?  ORDER BY R.subjYear ASC LIMIT " + pageNumber*5+ ", " +5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + subjYear + "%");
			pstmt.setString(2, "%" + subjSemester + "%");
			pstmt.setString(3, "%" + subjMain + "%");
			pstmt.setString(4, "%" + search + "%");
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjScore(rs.getString("subjScore"));
				depart.setBigDepartName(rs.getString("bigDepartName"));
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setCoreCapaName(rs.getString("coreCapaName"));
				depart.setDetailAreaName(rs.getString("detailAreaName"));
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
	

	public ArrayList<userClassDTO> getListClassUser(String subjYear, String subjSemester, String subjMain, String search, int pageNumber, String userID) {
		if(subjYear.equals("전체")) {
			subjYear="";
		}
		if(subjSemester.equals("전체")) {
			subjSemester="";
		}
		if(subjMain.equals("전체")) {
			subjMain="";
		}
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, S.subjName, R.subjMain,R.score, R.userID, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.subjYear = S.subjYear AND R.subjSemester = S.subjSemester  WHERE R.subjYear LIKE ? AND R.subjSemester LIKE ? AND R.subjMain LIKE ? AND CONCAT(S.subjName) LIKE ?  AND userID=? ORDER BY R.subjYear ASC LIMIT " + pageNumber*10+ ", " +10;
			//SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, R.subjName, R.subjMain,R.score, R.userID, R.score, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj S ON R.subjCode = S.subjCode  WHERE R.subjYear LIKE ? AND R.subjSemester LIKE ? AND R.subjMain LIKE ? AND CONCAT(R.subjCode) LIKE ?  AND userID=? ORDER BY R.subjYear ASC LIMIT " + pageNumber*5+ ", " +5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + subjYear + "%");
			pstmt.setString(2, "%" + subjSemester + "%");
			pstmt.setString(3, "%" + subjMain + "%");
			pstmt.setString(4, "%" + search + "%");
			pstmt.setString(5, userID);
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjScore(rs.getString("subjScore"));
				depart.setBigDepartName(rs.getString("bigDepartName"));
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setCoreCapaName(rs.getString("coreCapaName"));
				depart.setDetailAreaName(rs.getString("detailAreaName"));
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
	public ArrayList<userClassDTO> getListChangeMain(String search, int pageNumber) {
		
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT U.userName, R.subjYear, R.subjSemester , R.subjCode, S.subjName, R.subjMain,R.score, R.userID, R.score, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.subjYear = S.subjYear INNER JOIN user U ON R.userID = U.userID AND R.subjSemester = S.subjSemester AND R.changeMain=true  WHERE CONCAT(R.userID) LIKE ? ORDER BY R.subjYear ASC LIMIT " + pageNumber*5+ ", " +5;
			//SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, R.subjName, R.subjMain,R.score, R.userID, R.score, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj S ON R.subjCode = S.subjCode  WHERE R.subjYear LIKE ? AND R.subjSemester LIKE ? AND R.subjMain LIKE ? AND CONCAT(R.subjCode) LIKE ?  AND userID=? ORDER BY R.subjYear ASC LIMIT " + pageNumber*5+ ", " +5;
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjScore(rs.getString("subjScore"));
				depart.setBigDepartName(rs.getString("bigDepartName"));
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setCoreCapaName(rs.getString("coreCapaName"));
				depart.setDetailAreaName(rs.getString("detailAreaName"));
				depart.setScore(rs.getString("score"));
				depart.setUserName(rs.getString("userName"));
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
	public ArrayList<userClassDTO> getListScore() {
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, R.subjName, R.subjMain, R.score, R.userID, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.subjYear = S.subjYear AND R.subjSemester = S.subjSemester ORDER BY R.subjYear ASC";
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjScore(rs.getString("subjScore"));
				depart.setBigDepartName(rs.getString("bigDepartName"));
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setCoreCapaName(rs.getString("coreCapaName"));
				depart.setDetailAreaName(rs.getString("detailAreaName"));
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
	

	public ArrayList<userClassDTO> getListClassUser2(String userID) {
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT R.subjYear, R.subjSemester , R.subjCode, R.subjName, R.subjMain,R.score, R.userID, S.subjScore, S.bigDepartName, S.userDepart, S.coreCapaName, S.detailAreaName FROM class R INNER JOIN subj2 S ON R.subjCode = S.subjCode AND R.subjYear = S.subjYear AND R.subjSemester = S.subjSemester WHERE userID=? ORDER BY R.subjYear ASC";
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjScore(rs.getString("subjScore"));
				depart.setBigDepartName(rs.getString("bigDepartName"));
				depart.setUserDepart(rs.getString("userDepart"));
				depart.setCoreCapaName(rs.getString("coreCapaName"));
				depart.setDetailAreaName(rs.getString("detailAreaName"));
				depart.setScore(rs.getString("score"));
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
	
	public int delClass(String subjYear,String subjSemester, String subjCode, String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM class WHERE subjYear=? AND subjSemester=? AND subjCode=? AND userID=? ";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjYear);
			pstmt.setString(2, subjSemester);
			pstmt.setString(3, subjCode);
			pstmt.setString(4, userID);
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
	public int Add(String subjYear, String subjSemester, String subjCode, String userID, String subjName, String subjMain, String score, String grade, boolean changeMain) {
	      String SQL="INSERT INTO class (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score, grade, changeMain) VALUES (?,?,?,?,?,?,?,?,false)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, subjYear);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, subjSemester);
	         pstmt.setString(3, subjCode);
	         pstmt.setString(4, userID);
	         pstmt.setString(5, subjName);
	         pstmt.setString(6, subjMain);
	         pstmt.setString(7, score);
	         pstmt.setString(8, grade);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;
	   }
	
	public int majorInstead(String subjMain,  String subjCode, String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="UPDATE class SET subjMain=replace(subjMain, '교선', '전선'), changeMain=true WHERE  subjCode=? AND userID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
			pstmt.setString(2, userID);
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
	public int changeMain(String subjMain,  String subjCode, String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="UPDATE class SET subjMain=replace(subjMain, '전선', '교선'), changeMain=false WHERE  subjCode=? AND userID=?";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjCode);
			pstmt.setString(2, userID);
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
	
	//userID && 이수구분 에따라 자신이 수강한 과목에서 과목코드, 과목이름, 학과 뽑
    public ArrayList<userClassDTO> getUserListClass(String userID, String condition, String insteadSubjCode) {
       
       ArrayList<userClassDTO> list = null;
       Connection conn=null;
       PreparedStatement pstmt=null;
       ResultSet rs=null;
       String SQL="";
       
       
       try {
          if(condition.equals("전선")) {
             SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj2 S ON C.subjCode = S.subjCode AND C.subjYear = S.subjYear AND C.subjSemester = S.subjSemester AND C.grade=S.subjScore WHERE C.userID = ? AND C.subjMain = '전선' ";
             conn=DatabaseUtil.getConnection();
             pstmt=conn.prepareStatement(SQL);
             pstmt.setString(1, userID);
          }else if(condition.equals("교선")) {
             SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj2 S ON C.subjCode = S.subjCode AND C.subjYear = S.subjYear AND C.subjSemester = S.subjSemester AND C.grade=S.subjScore WHERE C.userID = ? AND C.subjMain = '교선' ";
             conn=DatabaseUtil.getConnection();
             pstmt=conn.prepareStatement(SQL);
             pstmt.setString(1, userID);
          }else {
             SQL="SELECT C.subjCode, C.subjName, S.userDepart, C.grade FROM class C INNER JOIN subj2 S ON C.subjCode = S.subjCode AND C.subjYear = S.subjYear AND C.subjSemester = S.subjSemester AND C.grade=S.subjScore WHERE C.userID = ? AND C.subjCode = ? ";
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
             
             depart.setUserDepart(rs.getString("userDepart"));

             depart.setGrade(rs.getString("grade"));
             
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
   
	   
	   //해당 과목이 class 테이블에 존재하는지
	   public int existClassSubj(String subjCode, String userID) {
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      
	      try {
	         String SQL="SELECT * FROM class WHERE subjCode = ? AND userID = ? ";
	         conn=DatabaseUtil.getConnection();
	         pstmt = conn.prepareStatement(SQL);
	         pstmt.setString(1, subjCode);
	         pstmt.setString(2, userID);
	         rs=pstmt.executeQuery();
	         if(rs.next()) {
	            return 1;
	         }else {
	            return 0;
	         }
	       
	      }catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;
	   }
	   
	   //class테이블에 해당 과목 존재 했을때  update, delete 트랜잭션 (대체과목 기능)
	   public int upAndDelInstead(String beReplaceSubjCode, String replaceSubjCode, String replaceSubjScore ,String userID) {
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      PreparedStatement pstmtDel=null;
	      ResultSet rs=null;
	      
	      try {
	         conn=DatabaseUtil.getConnection();
	         conn.setAutoCommit(false);
	         String SQL1="UPDATE class SET score = ? WHERE subjCode=? AND userID = ? ";
	         
	         pstmt = conn.prepareStatement(SQL1);
	         pstmt.setString(1, replaceSubjScore);
	         pstmt.setString(2, beReplaceSubjCode);
	         pstmt.setString(3, userID);
	         pstmt.executeUpdate();
	         
	         String SQL2="DELETE FROM class WHERE subjCode=? AND userID = ?";
	         pstmtDel = conn.prepareStatement(SQL2);
	         pstmtDel.setString(1, replaceSubjCode);
	         pstmtDel.setString(2, userID);
	         pstmtDel.executeUpdate();
	         
	         conn.commit();
	       
	      }catch(Throwable e) {
	         if(conn !=null) {
	            try{
	               conn.rollback();
	            }catch(SQLException ex){
	               ex.printStackTrace();
	            }
	         }         
	         e.printStackTrace();
	      } finally {
	         try {
	            if(conn!=null) {
	               conn.setAutoCommit(true);
	               conn.close();
	            }
	         } catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmtDel!=null) pstmtDel.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         
	      }
	      return -1;
	   }
	   
	   //class테이블에 해당 과목 존재하지 않았을때, 즉 필수과목인데 수강하지 않은경우  insert, delete 트랜잭션 (대체과목 기능)
	      public int inAndDelInstead(String beReplaceSubjCode, String beReplaceSubjYear, String beReplaceSubjSemester, String beReplaceSubjName,String subjMain, String score,String replaceSubjCode, String replaceSubjScore ,String userID) {
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         PreparedStatement pstmtDel=null;
	         ResultSet rs=null;
	         
	         try {
	            conn=DatabaseUtil.getConnection();
	            conn.setAutoCommit(false);
	            String SQL1="INSERT INTO class (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score)"
	                  + "VALUES (?, ?, ?, ?, ?, ?, ?)";
	            
	            pstmt = conn.prepareStatement(SQL1);
	            pstmt.setString(1, beReplaceSubjYear);
	            pstmt.setString(2, beReplaceSubjSemester);
	            pstmt.setString(3, beReplaceSubjCode);
	            pstmt.setString(4, userID);
	            pstmt.setString(5, beReplaceSubjName);
	            pstmt.setString(6, subjMain);
	            pstmt.setString(7, score);
	            pstmt.executeUpdate();
	            
	            String SQL2="DELETE FROM class WHERE subjCode=? AND userID = ?";
	            pstmtDel = conn.prepareStatement(SQL2);
	            pstmtDel.setString(1, replaceSubjCode);
	            pstmtDel.setString(2, userID);
	            pstmtDel.executeUpdate();
	            
	            conn.commit();
	          
	         }catch(Throwable e) {
	            if(conn !=null) {
	               try{
	                  conn.rollback();
	               }catch(SQLException ex){
	                  ex.printStackTrace();
	               }
	            }         
	            e.printStackTrace();
	         } finally {
	            try {
	               if(conn!=null) {
	                  conn.setAutoCommit(true);
	                  conn.close();
	               }
	            } catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmtDel!=null) pstmtDel.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	            
	         }
	         return -1;
	      }
	   
	   //대체 과목의 (대체되는 과목코드 x) 년도, 학기, 점수 뽑기
	   public ArrayList<userClassDTO> getInsteadClass(String userID, String insteadCode) {
	         ArrayList<userClassDTO> list = null;
	         Connection conn=null;
	         PreparedStatement pstmt=null;
	         ResultSet rs=null;
	         String SQL="";
	         
	         
	         try {
	            SQL="SELECT subjYear, subjSemester, score FROM class WHERE userID =?  AND subjCode=?";
	            conn=DatabaseUtil.getConnection();
	            pstmt=conn.prepareStatement(SQL);
	            pstmt.setString(1, userID);
	            pstmt.setString(2, insteadCode);
	            rs = pstmt. executeQuery();
	            list = new ArrayList<userClassDTO>();
	            while(rs.next()) {
	               userClassDTO depart = new userClassDTO();                
	               depart.setSubjYear(rs.getString("subjYear"));
	               depart.setSubjSemester(rs.getString("subjSemester"));   
	               depart.setScore(rs.getString("score"));                  
	               list.add(depart);
	            }
	         } catch(Exception e){
	            e.printStackTrace();
	         } finally { 
	            try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	            try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	         }
	         return list;
	      }
	   
	   
	 //userID에 따라 내가 수강한 과목 && 대체과목 리스트에 존재 && C+ 이하인 과목 뽑아오는 함수. (대체과목 리스트1)
       public ArrayList<userClassDTO> getUserClass(String userID) {
          ArrayList<userClassDTO> list = null;
          Connection conn=null;
          PreparedStatement pstmt=null;
          ResultSet rs=null;
          String SQL="";
          
          
          try {
             SQL="SELECT R.subjCode, I.beInsteadSubjName, R.score FROM joined.class R INNER JOIN joined.insteadtable I ON R.subjCode = I.beInsteadSubjCode WHERE userID=? ORDER BY R.subjYear ASC";
             conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
             pstmt=conn.prepareStatement(SQL);
             pstmt.setString(1, userID);
             rs = pstmt. executeQuery();
             list = new ArrayList<userClassDTO>();
             while(rs.next()) {
                userClassDTO depart = new userClassDTO();                
                depart.setSubjCode(rs.getString("subjCode"));
                depart.setSubjName(rs.getString("beInsteadSubjName"));                  
                depart.setScore(rs.getString("score"));                  
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
