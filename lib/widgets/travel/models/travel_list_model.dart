class TravelListModel {
  String travelId;
  DateTime leavingAt;
  DateTime arrivingAt;
  String state;
  TravelCity leavingCity;
  TravelCity arrivalCity;
  DateTime createdAt;
  TravelCar travelCar;
  String travelAuthorCoop;
  int placeCount;
  int availablePlaceCount;
  int prixUnitaire;

  TravelListModel({
    required this.travelId,
    required this.leavingAt,
    required this.arrivingAt,
    required this.state,
    required this.leavingCity,
    required this.arrivalCity,
    required this.createdAt,
    required this.travelCar,
    required this.travelAuthorCoop,
    required this.availablePlaceCount,
    required this.placeCount,
    required this.prixUnitaire,
  });
}

class TravelCity {
  String cityId;
  String cityName;

  TravelCity({required this.cityId, required this.cityName});
}

class TravelCar {
  String carId;
  String carMatriculate;

  TravelCar({required this.carId, required this.carMatriculate});
}
