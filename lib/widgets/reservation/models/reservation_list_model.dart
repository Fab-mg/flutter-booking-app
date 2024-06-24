class ReservationListModel {
  String reservedPlace;
  String reservationAuthor;
  String CIN;
  String fullName;
  String reservationId;

  ReservationListModel({
    required this.CIN,
    required this.fullName,
    required this.reservationAuthor,
    required this.reservationId,
    required this.reservedPlace,
  });
}
