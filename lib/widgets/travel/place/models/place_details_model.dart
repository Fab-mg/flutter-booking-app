class PlaceDetailsModel {
  String number;
  String placeId;
  bool isAvailable;
  String? reservationId;
  String? travelId;

  PlaceDetailsModel({
    required this.isAvailable,
    required this.number,
    required this.placeId,
    String? reservationId,
    String? travelId,
  }) {
    if (reservationId != null) {
      this.reservationId = reservationId;
    }
    if (travelId != null) {
      this.travelId = travelId;
    }
  }
}
