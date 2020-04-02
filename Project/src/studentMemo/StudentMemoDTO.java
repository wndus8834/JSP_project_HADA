package studentMemo;

public class StudentMemoDTO {
   private String userID;
   private String adminID;
   private String memoContent;
   private String memoTime;
   
   
   public String getUserID() {
      return userID;
   }
   public void setUserID(String userID) {
      this.userID = userID;
   }
   public String getAdminID() {
      return adminID;
   }
   public void setAdminID(String adminID) {
      this.adminID = adminID;
   }
   public String getMemoContent() {
      return memoContent;
   }
   public void setMemoContent(String memoContent) {
      this.memoContent = memoContent;
   }
   public String getMemoTime() {
      return memoTime;
   }
   public void setMemoTime(String memoTime) {
      this.memoTime = memoTime;
   }
}