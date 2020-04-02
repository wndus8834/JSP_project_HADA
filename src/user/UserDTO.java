package user;

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userGrade;
	private String userSemester;
	private String userDepart;
	private String userName;
	private String userQuestion;
	private String userAnswer;
	private boolean adminChecked;
	private boolean adminApply;
	

	private boolean cultureReqSatisfy;
	private boolean majorReqSatisfy;
	private boolean graduPossible;
	private boolean cRSatisfy;
	private boolean cultureNeceSatisfy;
	private boolean majorNeceSatisfy;
	private boolean FindSatisfy;
	
	
	public boolean isFindSatisfy() {
		return FindSatisfy;
	}
	public void setFindSatisfy(boolean findSatisfy) {
		FindSatisfy = findSatisfy;
	}
	public boolean isAdminApply() {
		return adminApply;
	}
	public void setAdminApply(boolean adminApply) {
		this.adminApply = adminApply;
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
	public boolean isCultureReqSatisfy() {
		return cultureReqSatisfy;
	}
	public void setCultureReqSatisfy(boolean cultureReqSatisfy) {
		this.cultureReqSatisfy = cultureReqSatisfy;
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
	public boolean iscRSatisfy() {
		return cRSatisfy;
	}
	public void setcRSatisfy(boolean cRSatisfy) {
		this.cRSatisfy = cRSatisfy;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public boolean isAdminChecked() {
		return adminChecked;
	}
	public void setAdminChecked(boolean adminChecked) {
		this.adminChecked = adminChecked;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserGrade() {
		return userGrade;
	}
	public void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}
	public String getUserDepart() {
		return userDepart;
	}
	public void setUserDepart(String userDepart) {
		this.userDepart = userDepart;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserQuestion() {
		return userQuestion;
	}
	public void setUserQuestion(String userQuestion) {
		this.userQuestion = userQuestion;
	}
	public String getUserAnswer() {
		return userAnswer;
	}
	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}
	
	public String getUserSemester() {
		return userSemester;
	}
	public void setUserSemester(String userSemester) {
		this.userSemester = userSemester;
	}
	public UserDTO() {
		
	}
	public UserDTO(String userID, String userPassword, String userEmail, String userGrade, String userSemester,
			String userDepart, String userName, String userQuestion, String userAnswer, boolean adminChecked,
			boolean cultureReqSatisfy, boolean majorReqSatisfy, boolean graduPossible, boolean cRSatisfy,
			boolean cultureNeceSatisfy, boolean majorNeceSatisfy, boolean adminApply, boolean FindSatisfy) {
		this.userID = userID;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userGrade = userGrade;
		this.userSemester=userSemester;
		this.userDepart = userDepart;
		this.userName = userName;
		this.userQuestion = userQuestion;
		this.userAnswer = userAnswer;
		this.adminChecked = adminChecked;
		this.cultureReqSatisfy=cultureReqSatisfy;
		this.majorReqSatisfy = majorReqSatisfy;
		this.graduPossible = graduPossible;
		this.cRSatisfy = cRSatisfy;
		this.cultureNeceSatisfy = cultureNeceSatisfy;
		this.majorNeceSatisfy = majorNeceSatisfy;
		this.adminApply = adminApply;
		this.FindSatisfy = FindSatisfy;
	}
	
	
	
}
