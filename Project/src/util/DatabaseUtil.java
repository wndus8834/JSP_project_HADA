/*package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
		try {
			String dbURL="jdbc:mysql://localhost:3306/joined?autoReconnect=true&useSSL=false";
			String dbID="root";
			String dbPassword="root";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}*/

package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

   public static Connection getConnection() {
      try {
         String dbURL="jdbc:mysql://54.180.90.56/joined?autoReconnect=true&serverTimezone=Asia/Seoul";
         String dbID="root";
         String dbPassword="root";
         Class.forName("com.mysql.jdbc.Driver");
         return DriverManager.getConnection(dbURL, dbID, dbPassword);
      }catch(Exception e) {
         e.printStackTrace();
      }
      return null;
   }
}