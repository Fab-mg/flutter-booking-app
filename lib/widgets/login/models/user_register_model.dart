class UserRegisterInfo {
  String userEmail;
  String userPassword;
  String firstName;
  String lastName;

  UserRegisterInfo({
    required this.userEmail,
    required this.userPassword,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": userEmail,
      "password": userPassword,
      "firstName": firstName,
      "lastName": lastName
    };
  }
}
