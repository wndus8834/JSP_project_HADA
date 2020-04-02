package insteadSubj;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import subj.SubjDAO;
import subj.SubjDTO;
import userClass.userClassDAO;
import userClass.userClassDTO;

/**
 * Servlet implementation class InsteadGetServlet2
 */

public class InsteadGetServlet2 extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String beInsteadSubjCode = request.getParameter("subjCode");
		String userID = request.getParameter("userID2");
		
		ArrayList<InsteadSubjDTO> insteadSubj = new InsteadSubjDAO().getInsteadSubj(beInsteadSubjCode);
		String insteadCode  = insteadSubj.get(0).getInsteadSubjCode();  //대체과목 코드
		String insteadName = insteadSubj.get(0).getInsteadSubjName();   //대체과목 명
		String depart = insteadSubj.get(0).getBeInsteadDepart();  //대체될 과목 학과
		String beInsteadSubjScore =insteadSubj.get(0).getSubjScore();  //대체될 과목의 학점
		
		
		
		if(insteadName.equals("전공 선택과목으로 대체")) {
			response.getWriter().write(getJSON(userID, beInsteadSubjCode, "전선", null, depart, beInsteadSubjScore));
		}else if(insteadName.indexOf("교양") !=-1) {
			response.getWriter().write(getJSON(userID, beInsteadSubjCode, "교선", null, depart, beInsteadSubjScore));
		}else {
			response.getWriter().write(getOneJSON(userID, beInsteadSubjCode, "else", insteadCode, depart));
		}
	}
	
	public String getJSON(String userID, String beInsteadSubjCode, String condition, String insteadSubjCode, String beSubjDepart, String beInsteadSubjScore) {
	      StringBuffer result = new StringBuffer("");
	      ArrayList<userClassDTO> userClass = new userClassDAO().getUserListClass(userID, condition, insteadSubjCode);
	      
	      result.append("{\"result\":[");
	      for(int i =0; i< userClass.size(); i++) {
	         if(userClass.get(i).getSubjCode().equals(beInsteadSubjCode)) { //내가 select한 과목과 내가 수강한 과목이 같다면
	            
	            continue;
	         }
	         else if(userClass.get(i).getUserDepart().equals(beSubjDepart) && userClass.get(i).getGrade().equals(beInsteadSubjScore)){ //같은 과 내에서 찾기
	            
	            result.append("[{\"value\": \"" + userClass.get(i).getSubjName() + "\"},");
	            result.append("{\"value\": \"" + userClass.get(i).getSubjCode()  + "\"}],");
	            
	            }
	      } 
	      result.append("]}");
	      return result.toString();
	      
	   }

	//대체과목이 정해져 있을때 즉, 하나만 일때
	public String getOneJSON(String userID, String beInsteadSubjCode, String condition, String insteadSubjCode, String beSubjDepart) {
		StringBuffer result = new StringBuffer("");
		ArrayList<userClassDTO> userClass2 = new userClassDAO().getUserListClass(userID, condition, insteadSubjCode);
		
		result.append("{\"result\":[");
		for(int i =0; i< userClass2.size(); i++) {
				result.append("[{\"value\": \"" + userClass2.get(i).getSubjName() + "\"},");
				result.append("{\"value\": \"" + userClass2.get(i).getSubjCode()  + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}
}
