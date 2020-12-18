package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
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
	
	public String getDate() {	// 현재 시간을 가져오는 함수로써 게시판에 글을 작성할때 작성 시간을 나타나게함
		String SQL = "SELECT NOW()"; // 현재의 시간을 가져오는 MySQL 함수 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
			}
			
		}	catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB오류 
	}
	
	public int getNext() {	// 다음글 
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
				
			}
			return 1; // 첫 번째 게시물
		}	catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류 
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {	// 글작성 
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);	// 글이 보여주는 형태 1 
			return pstmt.executeUpdate();	// 성공적으로 수행될시 0이상의 수를 반환
			
		}	catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	
	}

}
