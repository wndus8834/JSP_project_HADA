package subj;

public class SubjDTO {
	private String subjCode;
	private String bigDepartName;
	private String userDepart;
	private String subjName;
	private String subjMain;
	private String subjScore;
	private String subjInsteadCode;
	private String subjInsteadName;
	private String coreCapaID;
	private String coreCapaName;
	private String detailAreaID;
	private String detailAreaName;
	private String subjYear;
	private String subjSemester;
	
	
	
	public String getSubjYear() {
		return subjYear;
	}
	public void setSubjYear(String subjYear) {
		this.subjYear = subjYear;
	}
	public String getSubjSemester() {
		return subjSemester;
	}
	public void setSubjSemester(String subjSemester) {
		this.subjSemester = subjSemester;
	}
	public String getSubjCode() {
		return subjCode;
	}
	public void setSubjCode(String subjCode) {
		this.subjCode = subjCode;
	}
	public String getBigDepartName() {
		return bigDepartName;
	}
	public void setBigDepartName(String bigDepartName) {
		this.bigDepartName = bigDepartName;
	}
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getSubjName() {
		return subjName;
	}
	public void setSubjName(String subjName) {
		this.subjName = subjName;
	}
	public String getSubjMain() {
		return subjMain;
	}
	public void setSubjMain(String subjMain) {
		this.subjMain = subjMain;
	}
	public String getSubjScore() {
		return subjScore;
	}
	public void setSubjScore(String subjScore) {
		this.subjScore = subjScore;
	}
	public String getSubjInsteadCode() {
		return subjInsteadCode;
	}
	public void setSubjInsteadCode(String subjInsteadCode) {
		this.subjInsteadCode = subjInsteadCode;
	}
	public String getSubjInsteadName() {
		return subjInsteadName;
	}
	public void setSubjInsteadName(String subjInsteadName) {
		this.subjInsteadName = subjInsteadName;
	}
	public String getCoreCapaID() {
		return coreCapaID;
	}
	public void setCoreCapaID(String coreCapaID) {
		this.coreCapaID = coreCapaID;
	}
	public String getCoreCapaName() {
		return coreCapaName;
	}
	public void setCoreCapaName(String coreCapaName) {
		this.coreCapaName = coreCapaName;
	}
	public String getDetailAreaID() {
		return detailAreaID;
	}
	public void setDetailAreaID(String detailAreaID) {
		this.detailAreaID = detailAreaID;
	}
	public String getDetailAreaName() {
		return detailAreaName;
	}
	public void setDetailAreaName(String detailAreaName) {
		this.detailAreaName = detailAreaName;
	}
	
	public SubjDTO() {}
	
	public SubjDTO(String subjCode, String bigDepartName, String userDepart, String subjName, String subjMain,
			String subjScore, String subjInsteadCode, String subjInsteadName, String coreCapaID, String coreCapaName,
			String detailAreaID, String detailAreaName, String subjYear, String subjSemester) {
		super();
		this.subjCode = subjCode;
		this.bigDepartName = bigDepartName;
		this.userDepart = userDepart;
		this.subjName = subjName;
		this.subjMain = subjMain;
		this.subjScore = subjScore;
		this.subjInsteadCode = subjInsteadCode;
		this.subjInsteadName = subjInsteadName;
		this.coreCapaID = coreCapaID;
		this.coreCapaName = coreCapaName;
		this.detailAreaID = detailAreaID;
		this.detailAreaName = detailAreaName;
		this.subjYear = subjYear;
		this.subjSemester = subjSemester;
	}
	
	

}
