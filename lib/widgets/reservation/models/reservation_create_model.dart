class ReservationCreateModel {
  String reservedPlace;
  String reservationAuthor;
  String phone;
  String relativePhone;
  String CIN;
  String fullName;

  ReservationCreateModel(
      {required this.reservedPlace,
      required this.phone,
      required this.CIN,
      required this.fullName,
      required this.relativePhone,
      required this.reservationAuthor});

  String authorX = '63b2c82f8ddff619e0b13e28';

  Map<String, dynamic> toJson() {
    return {
      "reservedPlace": reservedPlace,
      "phone": phone,
      "relativePhone": relativePhone,
      "CIN": CIN,
      "fullName": fullName,
      "reservationAuthor": reservationAuthor
    };
  }
}
