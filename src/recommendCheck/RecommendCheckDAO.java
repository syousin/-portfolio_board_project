package recommendCheck;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RecommendCheckDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public RecommendCheckDAO() {
		try {
			 String dbURL = "jdbc:mysql://localhost:3306/bbs";
			 String dbID = "root";
			 String dbPassword = "1111";
			 Class.forName("com.mysql.jdbc.Driver");
			 conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() {
		String SQL = "SELECT recommendID FROM recommendCheck ORDER BY recommendID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("recommendID") + 1;
			}
			return 1;                          
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int recommendBest(String userID, int dbbsID) {
		String SQL = "INSERT INTO recommendCheck VALUES (?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, dbbsID);
			pstmt.setInt(4, 1);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int BestCheck(String userID, int dbbsID) {
		String SQL = "SELECT bestCheck FROM recommendCheck WHERE userID = ? AND dbbsID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, dbbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("bestCheck") == 1) 
					return 1;
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
}
