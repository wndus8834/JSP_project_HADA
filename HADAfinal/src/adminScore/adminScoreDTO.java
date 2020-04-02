package adminScore;

public class adminScoreDTO {
	private String userDepart;
	private String userAdmission;
	private String userProcess;
	private int totalCulture;
	private int totalCultureNecessary;
	private int totalMajor;
	private int totalMajorNecessary;
	private int totalGraduate;
	private int totalAbility;
	private int totalFindMajor;
	
	
	public int getTotalFindMajor() {
		return totalFindMajor;
	}
	public void setTotalFindMajor(int totalFindMajor) {
		this.totalFindMajor = totalFindMajor;
	}
	public String getUserAdmission() {
		return userAdmission;
	}
	public void setUserAdmission(String userAdmission) {
		this.userAdmission = userAdmission;
	}
	
	
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getUserProcess() {
		return userProcess;
	}
	public void setUserProcess(String userProcess) {
		this.userProcess = userProcess;
	}
	public int getTotalCulture() {
		return totalCulture;
	}
	public void setTotalCulture(int totalCulture) {
		this.totalCulture = totalCulture;
	}
	public int getTotalCultureNecessary() {
		return totalCultureNecessary;
	}
	public void setTotalCultureNecessary(int totalCultureNecessary) {
		this.totalCultureNecessary = totalCultureNecessary;
	}
	public int getTotalMajor() {
		return totalMajor;
	}
	public void setTotalMajor(int totalMajor) {
		this.totalMajor = totalMajor;
	}
	public int getTotalMajorNecessary() {
		return totalMajorNecessary;
	}
	public void setTotalMajorNecessary(int totalMajorNecessary) {
		this.totalMajorNecessary = totalMajorNecessary;
	}
	public int getTotalGraduate() {
		return totalGraduate;
	}
	public void setTotalGraduate(int totalGraduate) {
		this.totalGraduate = totalGraduate;
	}
	public int getTotalAbility() {
		return totalAbility;
	}
	public void setTotalAbility(int totalAbility) {
		this.totalAbility = totalAbility;
	}
	
	public adminScoreDTO() {}
	
	public adminScoreDTO(String userDepart, String userAdmission, String userProcess, int totalCulture, int totalCultureNecessary,
			int totalMajor, int totalMajorNecessary, int totalGraduate, int totalAbility, int totalFindMajor) {
		super();
		this.userDepart = userDepart;
		this.userAdmission = userAdmission;
		this.userProcess = userProcess;
		this.totalCulture = totalCulture;
		this.totalCultureNecessary = totalCultureNecessary;
		this.totalMajor = totalMajor;
		this.totalMajorNecessary = totalMajorNecessary;
		this.totalGraduate = totalGraduate;
		this.totalAbility = totalAbility;
		this.totalFindMajor = totalFindMajor;
	}
	
}
