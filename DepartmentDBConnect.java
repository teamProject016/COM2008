package --;
import java.sql.*;

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

      String sql = "SELECT department_id, department, register_num FROM Departments";
      ResultSet result = stmt.executeQuery(sql);
      
      while(result.next()){
    	  
         int department_id  = result.getInt("Department id: ");
         String department = result.getString("Department: ");
         String register_num = result.getString("Student id: ");

         //Display values
         System.out.print(department_id);
         System.out.print(department);
         System.out.print(register_num);
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
