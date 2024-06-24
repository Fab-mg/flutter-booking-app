class UserLoginInfo {
  String userEmail;
  String userPassword;

  UserLoginInfo({
    required this.userEmail,
    required this.userPassword,
  });

  Map<String, dynamic> toJson() {
    return {"email": userEmail, "password": userPassword};
  }
}
