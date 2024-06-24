class UserDetailsModel {
  bool isCoopMember;
  String? cooperativeId;
  String userId;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  DateTime? updatedAt;
  bool activatedAccount;
  int userStatus;

  UserDetailsModel({
    required this.isCoopMember,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    DateTime? updatedAt,
    required this.activatedAccount,
    required this.userStatus,
    String? cooperativeId,
  }) {
    if (updatedAt != null) {
      this.updatedAt = updatedAt;
    }
    if (cooperativeId != null) {
      this.cooperativeId = cooperativeId;
    }
  }
}
