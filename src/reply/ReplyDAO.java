package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReplyDAO {
	private Connection conn;
	private ResultSet rs;
	
	public ReplyDAO() {
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
		String SQL = "SELECT ID FROM REPLY ORDER BY ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("ID") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int reply_count(int bbsID) {
		String SQL = "SELECT count(*) FROM REPLY WHERE bbsID = ? and replyAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
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
	
	public int write(int bbsID, String userID, String Reply) {
		String SQL = "INSERT INTO REPLY VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bbsID);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, Reply);
			pstmt.setInt(6, 1);
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();                           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public Reply getBbs(int bbsID) {
		String SQL = "SELECT * FROM REPLY WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Reply reply = new Reply();
				reply.setID(rs.getInt("ID"));
				reply.setBbsID(rs.getInt("bbsID"));
				reply.setUserID(rs.getString("userID"));
				reply.setDate(rs.getString("Date"));
				reply.setReply(rs.getString("Reply"));
				reply.setReplyAvailable(rs.getInt("replyAvailable"));
				reply.setReCount(rs.getInt("reCount"));
				return reply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Reply getID(int ID) {
		String SQL = "SELECT * FROM REPLY WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Reply reply = new Reply();
				reply.setID(rs.getInt("ID"));
				reply.setBbsID(rs.getInt("bbsID"));
				reply.setUserID(rs.getString("userID"));
				reply.setDate(rs.getString("Date"));
				reply.setReply(rs.getString("Reply"));
				reply.setReplyAvailable(rs.getInt("replyAvailable"));
				reply.setReCount(rs.getInt("reCount"));
				return reply;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Reply> getList(int bbsID) {
		String SQL = "SELECT * FROM REPLY WHERE bbsID = ? ORDER BY ID ASC";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setID(rs.getInt("ID"));
				reply.setBbsID(rs.getInt("bbsID"));
				reply.setUserID(rs.getString("userID"));
				reply.setDate(rs.getString("Date"));
				reply.setReply(rs.getString("Reply"));
				reply.setReplyAvailable(rs.getInt("replyAvailable"));
				reply.setReCount(rs.getInt("reCount"));
				list.add(reply);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete(int ID) {
		String SQL = "UPDATE REPLY SET replyAvailable = 0 WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getreCount(int ID) {
		String SQL = "SELECT reCount FROM REPLY WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("reCount") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int setreCount(int ID) {
		String SQL = "UPDATE REPLY SET reCount = ? WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getreCount(ID));
			pstmt.setInt(2, ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Reply> getList_reply(String userID) {
		String SQL = "SELECT * FROM REPLY WHERE userID = ? and replyAvailable = 1 ORDER BY ID DESC";
		ArrayList<Reply> list = new ArrayList<Reply>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setID(rs.getInt("ID"));
				reply.setBbsID(rs.getInt("bbsID"));
				reply.setUserID(rs.getString("userID"));
				reply.setDate(rs.getString("Date"));
				reply.setReply(rs.getString("Reply"));
				reply.setReplyAvailable(rs.getInt("replyAvailable"));
				reply.setReCount(rs.getInt("reCount"));
				list.add(reply);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}