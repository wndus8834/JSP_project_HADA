package userScore;

public class userScoreDTO {
	private String userID;
	private String refinementScore;
	private String culturalReqScore;
	private boolean cultureReqSatisfy;
	private String majorScore;
	private String majorSelectScore;
	private String majorReqScore;
	private boolean majorReqSatisfy;
	private boolean graduPossible;
	private String capaReinforceScore;
	private boolean cRSatisfy;
	private boolean cultureNeceSatisfy;
	private boolean majorNeceSatisfy;
	private String majorFind;
	
	
	public String getMajorFind() {
		return majorFind;
	}
	public void setMajorFind(String majorFind) {
		this.majorFind = majorFind;
	}
	public boolean isCultureNeceSatisfy() {
		return cultureNeceSatisfy;
	}
	public void setCultureNeceSatisfy(boolean cultureNeceSatisfy) {
		this.cultureNeceSatisfy = cultureNeceSatisfy;
	}
	public boolean isMajorNeceSatisfy() {
		return majorNeceSatisfy;
	}
	public void setMajorNeceSatisfy(boolean majorNeceSatisfy) {
		this.majorNeceSatisfy = majorNeceSatisfy;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRefinementScore() {
		return refinementScore;
	}
	public void setRefinementScore(String refinementScore) {
		this.refinementScore = refinementScore;
	}
	public String getCulturalReqScore() {
		return culturalReqScore;
	}
	public void setCulturalReqScore(String culturalReqScore) {
		this.culturalReqScore = culturalReqScore;
	}
	public boolean isCultureReqSatisfy() {
		return cultureReqSatisfy;
	}
	public void setCultureReqSatisfy(boolean cultureReqSatisfy) {
		this.cultureReqSatisfy = cultureReqSatisfy;
	}
	public String getMajorScore() {
		return majorScore;
	}
	public void setMajorScore(String majorScore) {
		this.majorScore = majorScore;
	}
	public String getMajorSelectScore() {
		return majorSelectScore;
	}
	public void setMajorSelectScore(String majorSelectScore) {
		this.majorSelectScore = majorSelectScore;
	}
	public String getMajorReqScore() {
		return majorReqScore;
	}
	public void setMajorReqScore(String majorReqScore) {
		this.majorReqScore = majorReqScore;
	}
	public boolean isMajorReqSatisfy() {
		return majorReqSatisfy;
	}
	public void setMajorReqSatisfy(boolean majorReqSatisfy) {
		this.majorReqSatisfy = majorReqSatisfy;
	}
	public boolean isGraduPossible() {
		return graduPossible;
	}
	public void setGraduPossible(boolean graduPossible) {
		this.graduPossible = graduPossible;
	}
	public String getCapaReinforceScore() {
		return capaReinforceScore;
	}
	public void setCapaReinforceScore(String capaReinforceScore) {
		this.capaReinforceScore = capaReinforceScore;
	}
	public boolean iscRSatisfy() {
		return cRSatisfy;
	}
	public void setcRSatisfy(boolean cRSatisfy) {
		this.cRSatisfy = cRSatisfy;
	}
	
	public userScoreDTO() {}
	
	public userScoreDTO(String userID, String refinementScore, String culturalReqScore, boolean cultureReqSatisfy,
			String majorScore, String majorSelectScore, String majorReqScore, boolean majorReqSatisfy,
			boolean graduPossible, String capaReinforceScore, boolean cRSatisfy, boolean cultureNeceSatisfy, boolean majorNeceSatisfy, String majorFind) {
		super();
		this.userID = userID;
		this.refinementScore = refinementScore;
		this.culturalReqScore = culturalReqScore;
		this.cultureReqSatisfy = cultureReqSatisfy;
		this.majorScore = majorScore;
		this.majorSelectScore = majorSelectScore;
		this.majorReqScore = majorReqScore;
		this.majorReqSatisfy = majorReqSatisfy;
		this.graduPossible = graduPossible;
		this.capaReinforceScore = capaReinforceScore;
		this.cRSatisfy = cRSatisfy;
		this.cultureNeceSatisfy = cultureNeceSatisfy;
		this.majorNeceSatisfy = majorNeceSatisfy;
		this.majorFind = majorFind;
	}
	
	
}
