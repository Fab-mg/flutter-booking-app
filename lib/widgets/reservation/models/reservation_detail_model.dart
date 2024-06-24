class ReservationDetailsModel {
  String reservedPlace;
  String reservationAuthor;
  String CIN;
  String fullName;
  String reservationId;
  String phone;
  String relativePhone;

  ReservationDetailsModel({
    required this.CIN,
    required this.fullName,
    required this.reservationAuthor,
    required this.reservationId,
    required this.reservedPlace,
    required this.relativePhone,
    required this.phone,
  });
}
