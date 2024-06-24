class TravelDetailModel {
  String travelId;
  DateTime leavingAt;
  DateTime arrivingAt;
  String state;
  TravelCity2 leavingCity;
  TravelCity2 arrivalCity;
  DateTime createdAt;
  TravelCar2 travelCar;
  String travelAuthorCoop;
  String travelAuthorCoopMember;
  int placeCount;
  int availablePlaceCount;
  int prixUnitaire;

  TravelDetailModel({
    required this.travelId,
    required this.leavingAt,
    required this.arrivingAt,
    required this.state,
    required this.leavingCity,
    required this.arrivalCity,
    required this.createdAt,
    required this.travelCar,
    required this.travelAuthorCoop,
    required this.travelAuthorCoopMember,
    required this.availablePlaceCount,
    required this.placeCount,
    required this.prixUnitaire,
  });
}

class TravelCity2 {
  String cityId;
  String cityName;

  TravelCity2({required this.cityId, required this.cityName});
}

class TravelCar2 {
  String carId;
  String carMatriculate;

  TravelCar2({required this.carId, required this.carMatriculate});
}
