package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL ="jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";   // MySQL 8버전 이상은 이렇게 설정해줘야함 
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");	// 이쪽부분도 MySQL 8버전에 맞게 수정  * 추가 JDBC connector-java class path는 Module Path에 Add External JARs를 한다.
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	public int login(String userID, String userPassword) {
		String SQL= "SELECT userPassword FROM USER WHERE userID = ?";  
		try {
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;//로그인성공
				else
					return 0; //비밀번호 불일치
					
			}
			return -1; //아이디가 없을 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;// DB오류
	}
	
	public int join(User user) {	// 회원가입 
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";	//SQL 문장 삽입 	
		try {	// 예외처리 
			pstmt = conn.prepareStatement(SQL);	// SQL 문장 호출  ID,Password,Name,Gender,Email 순
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserEmail());
			return pstmt.executeUpdate(); // 실행 Insert 문장을 수행한 경우 반드시 0이상의 숫자가 반환됨 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// DB오류 
		
	}
	
}
