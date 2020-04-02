package userClass;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;

public class userClassAddServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding ("UTF-8");
      response.setContentType ("text/html;charset=UTF-8");

      String subjYear = null;
      String subjSemester = null;
      String subjCode = null;
      String userID = request.getParameter ("userID");
      String subjName = null;
      String subjMain = null;
      String score = null;
      String grade = null;
      boolean changeMain=false;
      
      int result = 0;
      boolean isMultipart = ServletFileUpload.isMultipartContent (request);

      if (isMultipart) {
         MultipartRequest multi = new MultipartRequest (request, System.getProperty ("user.home"), "UTF-8");
         File file = multi.getFile ("file");
         if (file == null) {
            response.getWriter ().print ("<script>alert ('파일을 선택해주세요.'); location.href='InsertClass.jsp';</script>");
            return;
         }
         if (!file.getName ().trim ().endsWith (".xlsx")) {
            response.getWriter ().print ("<script>alert ('허용되지 않은 확장자입니다.'); location.href='InsertClass.jsp';</script>");
            return;
         }
         
         FileInputStream fis = new FileInputStream (file);
         
         XSSFWorkbook workbook = new XSSFWorkbook(fis);
         int rowindex = 0;
         int columnindex = 0;

         XSSFSheet sheet = workbook.getSheetAt(0);
         int rows = sheet.getPhysicalNumberOfRows();
         String[] value = new String[7];
         outer : for (rowindex = 2; rowindex < rows; rowindex++) {
            XSSFRow row = sheet.getRow(rowindex);
            if (row != null) {
//               int cells = row.getPhysicalNumberOfCells();
               for (columnindex = 1; columnindex <= 7; columnindex++) {
                  XSSFCell cell = row.getCell(columnindex);
                  if (cell != null) {
                     switch (cell.getCellType ()) {
                        case (0) : 
                           String temp = String.valueOf (cell.getNumericCellValue ());
                           if (temp.indexOf (".") != -1) {
                              temp = temp.substring (0, temp.indexOf ("."));
                           }
                           value[columnindex - 1] = temp;
                           break;
                        case (1) : 
                           value[columnindex - 1] = cell.getStringCellValue ();
                        break;
                     }
                  } else {
                     break outer;
                  }
               }
               
               subjYear = value[0];
               subjSemester = value[1];
               subjCode = value[2];
               subjName = value[3];
               subjMain = value[4];
               score = value[6];
               grade = value[5];
               
               if (subjYear == null || subjSemester == null || subjMain == null || subjName.equals ("") || subjCode.equals ("") || score == null || grade == null) {
                  PrintWriter script = response.getWriter ();
                  script.println ("<script>");
                  script.println ("alert('입력이 안 된 사항이 있습니다.');");
                  script.println ("history.back();");
                  script.println ("</script>");
                  script.close ();
                  return;
               }
               
               result = new userClassDAO ().Add (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score, grade,changeMain);
            }
         }
         
         response.getWriter ().print("<script>alert ('일괄 입력이 완료되었습니다.'); location.href='InsertClass.jsp';</script>");
         return;
         
      } else {
         subjYear = request.getParameter ("subjYear");
         subjSemester = request.getParameter ("subjSemester");
         subjCode = request.getParameter ("subjCode");
         subjName = request.getParameter ("subjName");
         subjMain = request.getParameter ("subjMain");
         score = request.getParameter ("score");
         grade = request.getParameter ("grade");
         
         if (subjYear == null || subjSemester == null || subjMain == null || subjName.equals ("") || subjCode.equals ("") || score == null) {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('입력이 안 된 사항이 있습니다.');");
            script.println ("history.back();");
            script.println ("</script>");
            script.close ();
            return;
         }
         
         result = new userClassDAO ().Add (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score, grade,changeMain);
         
         if (result == -1) {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('이미 존재합니다.');");
            script.println ("history.back();");
            script.println ("</script>");
            script.close ();
            return;
         } else {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('등록이 성공되었습니다.');");
            script.println ("location.href='InsertClass.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
            script.println ("</script>");
            script.close ();
            return;
         }
      }
   }
}