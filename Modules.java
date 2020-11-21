import java.sql.*;
import javax.sql.*;

public class DepartmentDBconnect {
   // JDBC driver name, database URL
   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
   static final String DB_URL = "jdbc:mysql://localhost/STUDENTS";

   //  Personal username and password from database
   static final String USER = "username";
   static final String PASS = "password";

   public static void main(String[] args) {
   Connection conn = null;
   Statement stmt = null;
   try{
      Class.forName(JDBC_DRIVER);

      conn = DriverManager.getConnection(DB_URL, USER, PASS);

      stmt = conn.createStatement();

      String sql = "SELECT register_num, module_name, module_code, credits,level_study,module_status,final_result FROM module_info";
      ResultSet result = stmt.executeQuery(sql);

      while(result.next()){

         int register_num  = result.getInt("Registration number: ");
         String module_name = result.getString("Module name: ");
         String module_code = result.getString("Module code: ");
         int credits = result.getInt("credits : ");
         int level_study = result.getInt("level study:");
         String module_status = result.getString("Module status: ");
         String final_result = result.getString("final result: ");


         //Display values
         System.out.print(register_num);
         System.out.print(module_name);
         System.out.print(module_code);
         System.out.print(level_study);
         System.out.print(module_status);
         System.out.print(final_result);
      }
      result.close();
   }catch(SQLException se){ //Check JDBC errors

      se.printStackTrace();
   }catch(Exception e){ //Check Class.forName errors

	  e.printStackTrace();
   }finally{  //block used to close resources
      try{
         if(stmt!=null)

        	 conn.close();
      }catch(SQLException se){
      }// do nothing
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }
     }
 }
}
