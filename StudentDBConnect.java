package --;
import java.sql.*;

public class StudentDBconnect {
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

      String sql = "SELECT register_num, surname, forname, email, password FROM Students";
      ResultSet result = stmt.executeQuery(sql);
      
      while(result.next()){
    	  
         int id  = result.getInt("Student Id: ");
         String title = result.getString("Mr/Mrs/Ms");
         String surname = result.getString("First Name: ");
         String forename = result.getString("Last Name: ");
         String email = result.getString("Email: ");

         //Display values
         System.out.print(id);
         System.out.print(title);
         System.out.print(surname);
         System.out.println(forename);
         System.out.println(email);
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
