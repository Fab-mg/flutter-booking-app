class ReservationUser {
  late String fullName;
  late String phone;
  late String CIN;
  late String relativePhone;

  ReservationUser(
      {required this.CIN,
      required this.fullName,
      required this.phone,
      required this.relativePhone});

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "relativePhone": relativePhone,
      "CIN": CIN,
      "fullName": fullName
    };
  }
}
