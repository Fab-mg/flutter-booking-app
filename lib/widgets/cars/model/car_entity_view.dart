class CarView {
  String carId;
  String matriculate;
  String model;
  DateTime createdAt;
  String color;
  int nbrPlace;
  String state_car;
  List<CarTravelView>? travel;
  CarCooperativeView? cooperative;
  DateTime? deletedAt;
  DateTime? updatedAt;

  CarView({
    required this.carId,
    required this.matriculate,
    required this.model,
    required this.createdAt,
    required this.color,
    required this.nbrPlace,
    required this.state_car,
    List<CarTravelView>? travel,
    CarCooperativeView? cooperative,
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

class CarCooperativeView {
  String cooperativeId;
  String name;

  CarCooperativeView({required this.cooperativeId, required this.name});
}

class CarTravelView {
  late String travelId;
  DateTime travelDate;
  DateTime? isDeleted;

  CarTravelView({
    required this.travelId,
    required this.travelDate,
    DateTime? isDeleted,
  }) {
    if (isDeleted != null) {
      this.isDeleted = isDeleted;
    }
  }
}
