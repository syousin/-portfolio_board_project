package report;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReportDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ReportDAO() {
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
		String SQL = "SELECT report_ID FROM REPORT ORDER BY report_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("report_ID") + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int report_write(String userID, String bbs_Type, int bbs_Type_ID, String report_countent, String report_title) {
		String SQL = "INSERT INTO REPORT VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, bbs_Type);
			pstmt.setInt(4, bbs_Type_ID);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			pstmt.setString(7, report_countent);
			pstmt.setString(8, report_title);
			return pstmt.executeUpdate();                           
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Report> getList_bbs_report(String bbs_Type, int bbs_Type_ID) {
		String SQL = "SELECT * FROM REPORT WHERE bbs_Type = ? AND bbs_Type_ID = ? ORDER BY report_ID ASC";
		ArrayList<Report> list = new ArrayList<Report>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbs_Type);
			pstmt.setInt(2, bbs_Type_ID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Report report = new Report();
				report.setReport_ID(rs.getInt("report_ID"));
				report.setUserID(rs.getString("userID"));
				report.setBbs_Type(rs.getString("bbs_Type"));
				report.setBbs_Type_ID(rs.getInt("bbs_Type_ID"));
				report.setReport_Date(rs.getString("report_Date"));
				report.setReport_Content(rs.getString("report_Content"));
				report.setReport_Title(rs.getString("report_Title"));
				list.add(report);
			}                        
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int reportCheck(String userID, String bbs_Type, int bbs_Type_ID) {
		String SQL = "SELECT userID FROM REPORT WHERE userID = ? AND bbs_Type = ? AND bbs_Type_ID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, bbs_Type);
			pstmt.setInt(3, bbs_Type_ID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userID").contentEquals(userID)) 
					return 1;
			}
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
}
