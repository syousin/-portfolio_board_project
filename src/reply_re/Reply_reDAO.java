package reply_re;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Reply_reDAO {
	private Connection conn;
	private ResultSet rs;
	
	public Reply_reDAO() {
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
	
	public int reply_re_count(int bbsID) {
		String SQL = "SELECT count(*) FROM REPLY_RE WHERE bbsID = ? and reply_reAvailable = 1";
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
	
	public int getNext() {
		String SQL = "SELECT reply_re_ID FROM REPLY_RE ORDER BY reply_re_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("reply_re_ID") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(int bbsID, int replyID, String userID, String Reply_re) {
		String SQL = "INSERT INTO REPLY_RE VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bbsID);
			pstmt.setInt(3, replyID);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, Reply_re);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();                           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public Reply_re getIDs(int bbsID, int replyID) {
		String SQL = "SELECT * FROM REPLY_RE WHERE bbsID = ? AND replyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, replyID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Reply_re reply_re = new Reply_re();
				reply_re.setReply_re_ID(rs.getInt("reply_re_ID"));
				reply_re.setBbsID(rs.getInt("bbsID"));
				reply_re.setReplyID(rs.getInt("replyID"));
				reply_re.setUserID(rs.getString("userID"));
				reply_re.setDate(rs.getString("Date"));
				reply_re.setReply_re(rs.getString("Reply_re"));
				reply_re.setReply_reAvailable(rs.getInt("reply_reAvailable"));
				return reply_re;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Reply_re> getList(int bbsID, int replyID) {
		String SQL = "SELECT * FROM REPLY_RE WHERE bbsID = ? AND replyID = ? AND reply_reAvailable = 1 ORDER BY reply_re_ID ASC";
		ArrayList<Reply_re> list = new ArrayList<Reply_re>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setInt(2, replyID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reply_re reply_re = new Reply_re();
				reply_re.setReply_re_ID(rs.getInt("reply_re_ID"));
				reply_re.setBbsID(rs.getInt("bbsID"));
				reply_re.setReplyID(rs.getInt("replyID"));
				reply_re.setUserID(rs.getString("userID"));
				reply_re.setDate(rs.getString("Date"));
				reply_re.setReply_re(rs.getString("Reply_re"));
				reply_re.setReply_reAvailable(rs.getInt("reply_reAvailable"));
				list.add(reply_re);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Reply_re> getList_reply_re(String userID) {
		String SQL = "SELECT * FROM REPLY_RE WHERE userID = ? and reply_reAvailable = 1 ORDER BY reply_re_ID DESC";
		ArrayList<Reply_re> list = new ArrayList<Reply_re>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reply_re reply_re = new Reply_re();
				reply_re.setReply_re_ID(rs.getInt("reply_re_ID"));
				reply_re.setBbsID(rs.getInt("bbsID"));
				reply_re.setReplyID(rs.getInt("replyID"));
				reply_re.setUserID(rs.getString("userID"));
				reply_re.setDate(rs.getString("Date"));
				reply_re.setReply_re(rs.getString("Reply_re"));
				reply_re.setReply_reAvailable(rs.getInt("reply_reAvailable"));
				list.add(reply_re);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}