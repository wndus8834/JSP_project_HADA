package departr;

public class DepartrDTO {
	private String userDepart;
	private String userAdmission;
	private String subjCode;
	private String subjGrade;
	private String subjSemester;
	private String subjName;
	private String subjDivision;
	
	public String getSubjName() {
		return subjName;
	}
	public void setSubjName(String subjName) {
		this.subjName = subjName;
	}
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getUserAdmission() {
		return userAdmission;
	}
	public void setUserAdmission(String userAdmission) {
		this.userAdmission = userAdmission;
	}
	public String getSubjCode() {
		return subjCode;
	}
	public void setSubjCode(String subjCode) {
		this.subjCode = subjCode;
	}
	public String getSubjGrade() {
		return subjGrade;
	}
	public void setSubjGrade(String subjGrade) {
		this.subjGrade = subjGrade;
	}
	public String getSubjSemester() {
		return subjSemester;
	}
	public void setSubjSemester(String subjSemester) {
		this.subjSemester = subjSemester;
	}
	
	public String getSubjDivision() {
		return subjDivision;
	}
	public void setSubjDivision(String subjDivision) {
		this.subjDivision = subjDivision;
	}
	
	public DepartrDTO() {}
	
	public DepartrDTO(String userDepart, String userAdmission, String subjCode, String subjGrade, String subjSemester, String subjDivision) {
		super();
		this.userDepart = userDepart;
		this.userAdmission = userAdmission;
		this.subjCode = subjCode;
		this.subjGrade = subjGrade;
		this.subjSemester = subjSemester;
		this.subjDivision = subjDivision;
	}
	
	
}
