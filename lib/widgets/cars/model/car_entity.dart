class Car {
  String carId;
  String matriculate;
  String model;
  DateTime createdAt;
  String color;
  int nbrPlace;
  String state_car;
  List<CarTravel>? travel;
  CarCooperative? cooperative;
  DateTime? deletedAt;
  DateTime? updatedAt;

  Car({
    required this.carId,
    required this.matriculate,
    required this.model,
    required this.createdAt,
    required this.color,
    required this.nbrPlace,
    required this.state_car,
    List<CarTravel>? travel,
    CarCooperative? cooperative,
    DateTime? deletedAt,
    DateTime? updatedAt,
  }) {
    if (cooperative != null) {
      this.cooperative = cooperative;
    }
    if (travel != null) {
      this.deletedAt = deletedAt;
    }
    if (updatedAt != null) {
      this.updatedAt = updatedAt;
    }
    if (travel != null) {
      this.travel = travel;
    }
  }
}

class CarCooperative {
  String cooperativeId;
  String name;

  CarCooperative({required this.cooperativeId, required this.name});
}

class CarTravel {
  late String travelId;
  late String travelDate;
  DateTime? isDeleted;

  CarTravel({
    required this.travelId,
    required this.travelDate,
    DateTime? isDeleted,
  }) {
    if (isDeleted != null) {
      this.isDeleted = isDeleted;
    }
  }
}
