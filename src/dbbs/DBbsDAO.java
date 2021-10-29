package dbbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DBbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public DBbsDAO() {
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
		String SQL = "SELECT dbbsID FROM DBBS ORDER BY dbbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("dbbsID") + 1;
			}
			return 1;                          
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String dbbsTitle, String userID, String dbbsContent) {
		String SQL = "INSERT INTO DBBS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, dbbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, dbbsContent);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 1);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<DBbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsAvailable = 1 AND dbbsrequest = 0 ORDER BY dbbsID DESC LIMIT 10";
		ArrayList<DBbs> list = new ArrayList<DBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DBbs dbbs = new DBbs();
				dbbs.setDbbsID(rs.getInt("dbbsID"));
				dbbs.setDbbsTitle(rs.getString("dbbsTitle"));
				dbbs.setUserID(rs.getString("userID"));
				dbbs.setDbbsDate(rs.getString("dbbsDate"));
				dbbs.setDbbsContent(rs.getString("dbbsContent"));
				dbbs.setDbbsAvailable(rs.getInt("dbbsAvailable"));
				dbbs.setDbbsBest(rs.getInt("dbbsBest"));
				list.add(dbbs);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<DBbs> getList_main(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsAvailable = 1 AND dbbsrequest = 0 ORDER BY dbbsID DESC LIMIT 5";
		ArrayList<DBbs> list = new ArrayList<DBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DBbs dbbs = new DBbs();
				dbbs.setDbbsID(rs.getInt("dbbsID"));
				dbbs.setDbbsTitle(rs.getString("dbbsTitle"));
				dbbs.setUserID(rs.getString("userID"));
				dbbs.setDbbsDate(rs.getString("dbbsDate"));
				dbbs.setDbbsContent(rs.getString("dbbsContent"));
				dbbs.setDbbsAvailable(rs.getInt("dbbsAvailable"));
				dbbs.setDbbsBest(rs.getInt("dbbsBest"));
				list.add(dbbs);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<DBbs> admin_getList(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsrequest = 1 ORDER BY dbbsID DESC LIMIT 10";
		ArrayList<DBbs> list = new ArrayList<DBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DBbs dbbs = new DBbs();
				dbbs.setDbbsID(rs.getInt("dbbsID"));
				dbbs.setDbbsTitle(rs.getString("dbbsTitle"));
				dbbs.setUserID(rs.getString("userID"));
				dbbs.setDbbsDate(rs.getString("dbbsDate"));
				dbbs.setDbbsContent(rs.getString("dbbsContent"));
				dbbs.setDbbsAvailable(rs.getInt("dbbsrequest"));
				list.add(dbbs);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsAvailable = 1 AND dbbsrequest = 0";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean admin_nextPage(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsrequest = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public int request(int dbbsID) {
		String SQL = "UPDATE DBBS SET dbbsAvailable = ?, dbbsrequest = ?, dbbsrequestAvailable = ? WHERE dbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 1);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 0);
			pstmt.setInt(4, dbbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int request_delete(int dbbsID) {
		String SQL = "UPDATE DBBS SET dbbsAvailable = ?, dbbsrequest = ?, dbbsrequestAvailable = ? WHERE dbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, 1);
			pstmt.setInt(4, dbbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public DBbs getDBbs(int dbbsID) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dbbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				DBbs dbbs = new DBbs();
				dbbs.setDbbsID(rs.getInt("dbbsID"));
				dbbs.setDbbsTitle(rs.getString("dbbsTitle"));
				dbbs.setUserID(rs.getString("userID"));
				dbbs.setDbbsDate(rs.getString("dbbsDate"));
				dbbs.setDbbsContent(rs.getString("dbbsContent"));
				dbbs.setDbbsAvailable(rs.getInt("dbbsAvailable"));
				dbbs.setDbbsrequest(rs.getInt("dbbsrequest"));
				dbbs.setDbbsrequestAvailable(rs.getInt("dbbsrequestAvailable"));
				dbbs.setDbbsBest(rs.getInt("dbbsBest"));
				return dbbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int Best(int dbbsID) {
		String SQL = "SELECT dbbsBest FROM DBBS WHERE dbbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, dbbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("dbbsBest") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int BestNext(int dbbsID) {
		String SQL = "UPDATE DBBS SET DBBSBEST = ? WHERE DBBSID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Best(dbbsID));
			pstmt.setInt(2, dbbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<DBbs> getBestList(int pageNumber) {
		String SQL = "SELECT * FROM DBBS WHERE dbbsID < ? AND dbbsAvailable = 1 AND dbbsBest >= 10 ORDER BY dbbsID DESC LIMIT 5";
		ArrayList<DBbs> list = new ArrayList<DBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				DBbs dbbs = new DBbs();
				dbbs.setDbbsID(rs.getInt("dbbsID"));
				dbbs.setDbbsTitle(rs.getString("dbbsTitle"));
				dbbs.setUserID(rs.getString("userID"));
				dbbs.setDbbsDate(rs.getString("dbbsDate"));
				dbbs.setDbbsContent(rs.getString("dbbsContent"));
				dbbs.setDbbsAvailable(rs.getInt("dbbsAvailable"));
				dbbs.setDbbsBest(rs.getInt("dbbsBest"));
				list.add(dbbs);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}