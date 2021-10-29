package recommendCheck;

public class RecommendCheck {
	private int recommendID;
	private String userID;
	private int dbbsID;
	private int bestCheck;
	
	public int getRecommendID() {
		return recommendID;
	}
	public void setRecommendID(int recommendID) {
		this.recommendID = recommendID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getDbbsID() {
		return dbbsID;
	}
	public void setDbbsID(int dbbsID) {
		this.dbbsID = dbbsID;
	}
	public int getBestCheck() {
		return bestCheck;
	}
	public void setBestCheck(int bestCheck) {
		this.bestCheck = bestCheck;
	}
}
