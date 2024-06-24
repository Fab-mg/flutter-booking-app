class UserConfirmModel {
  String email;
  String code;

  UserConfirmModel({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {"email": email, "code": code};
  }
}
