package aoreply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AOreplyDAO {
	private Connection conn;
	private ResultSet rs;
	
	public AOreplyDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("NOW()");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT aoID FROM AOREPLY ORDER BY aoID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("aoID") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int aoreply_count(String aoreply_ao, int dbbsID) {
		String SQL = "SELECT count(*) FROM AOREPLY WHERE aoreply_ao = ? and dbbsID = ? and aoreply_Available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, aoreply_ao);
			pstmt.setInt(2, dbbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("count(*)");
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(int dbbsID, String userID, String aoreply_ao, String aoreply_Title, String aoreply_Content) {
		String SQL = "INSERT INTO AOREPLY VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, dbbsID);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, aoreply_ao);
			pstmt.setString(6, aoreply_Title);
			pstmt.setString(7, aoreply_Content);
			pstmt.setInt(8, 1);
			return pstmt.executeUpdate();                           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public AOreply getDBbs(int dbbsID) {
		String SQL = "SELECT * FROM AOREPLY WHERE dbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dbbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				AOreply aoreply = new AOreply();
				aoreply.setAoID(rs.getInt("aoID"));
				aoreply.setDbbsID(rs.getInt("dbbsID"));
				aoreply.setUserID(rs.getString("userID"));
				aoreply.setAoDate(rs.getString("aoDate"));
				aoreply.setAoreply_ao(rs.getString("aoreply_ao"));
				aoreply.setAoreply_Title(rs.getString("aoreply_Title"));
				aoreply.setAoreply_Content(rs.getString("aoreply_Content"));
				aoreply.setAoreply_Available(rs.getInt("aoreply_Available"));
				return aoreply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public AOreply get_aoreply_UserID(int aoID) {
		String SQL = "SELECT * FROM AOREPLY WHERE aoID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aoID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				AOreply aoreply = new AOreply();
				aoreply.setAoID(rs.getInt("aoID"));
				aoreply.setDbbsID(rs.getInt("dbbsID"));
				aoreply.setUserID(rs.getString("userID"));
				aoreply.setAoDate(rs.getString("aoDate"));
				aoreply.setAoreply_ao(rs.getString("aoreply_ao"));
				aoreply.setAoreply_Title(rs.getString("aoreply_Title"));
				aoreply.setAoreply_Content(rs.getString("aoreply_Content"));
				aoreply.setAoreply_Available(rs.getInt("aoreply_Available"));
				return aoreply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int aoID) {
		String SQL = "UPDATE AOREPLY SET aoreply_Available = 0 WHERE aoID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, aoID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<AOreply> getList(int dbbsID) {
		String SQL = "SELECT * FROM AOREPLY WHERE dbbsID = ? AND aoreply_Available = 1 ORDER BY aoID DESC";
		ArrayList<AOreply> aolist = new ArrayList<AOreply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dbbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AOreply aoreply = new AOreply();
				aoreply.setAoID(rs.getInt("aoID"));
				aoreply.setDbbsID(rs.getInt("dbbsID"));
				aoreply.setUserID(rs.getString("userID"));
				aoreply.setAoDate(rs.getString("aoDate"));
				aoreply.setAoreply_ao(rs.getString("aoreply_ao"));
				aoreply.setAoreply_Title(rs.getString("aoreply_Title"));
				aoreply.setAoreply_Content(rs.getString("aoreply_Content"));
				aoreply.setAoreply_Available(rs.getInt("aoreply_Available"));
				aolist.add(aoreply);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return aolist;
	}
}