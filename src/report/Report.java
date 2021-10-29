package report;

public class Report {
	private int report_ID;
	private String userID;
	private String bbs_Type;
	private int bbs_Type_ID;
	private String report_Date;
	private int report_Available;
	private String report_Content;
	private String report_Title;
	
	public int getReport_ID() {
		return report_ID;
	}
	public void setReport_ID(int report_ID) {
		this.report_ID = report_ID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbs_Type() {
		return bbs_Type;
	}
	public void setBbs_Type(String bbs_Type) {
		this.bbs_Type = bbs_Type;
	}
	public int getBbs_Type_ID() {
		return bbs_Type_ID;
	}
	public void setBbs_Type_ID(int bbs_Type_ID) {
		this.bbs_Type_ID = bbs_Type_ID;
	}
	public String getReport_Date() {
		return report_Date;
	}
	public void setReport_Date(String report_Date) {
		this.report_Date = report_Date;
	}
	public int getReport_Available() {
		return report_Available;
	}
	public void setReport_Available(int report_Available) {
		this.report_Available = report_Available;
	}
	public String getReport_Content() {
		return report_Content;
	}
	public void setReport_Content(String report_Content) {
		this.report_Content = report_Content;
	}
	public String getReport_Title() {
		return report_Title;
	}
	public void setReport_Title(String report_Title) {
		this.report_Title = report_Title;
	}	
}
