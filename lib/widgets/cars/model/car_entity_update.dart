class CarUpdate {
  String? carId;
  String? matriculate;
  String? model;
  DateTime? createdAt;
  String? color;
  int? nbrPlace;
  String? state_car;
  List<CarTravelView>? travel;
  CarCooperativeView? cooperative;
  DateTime? deletedAt;
  DateTime? updatedAt;

  CarUpdate({
    String? carId,
    String? matriculate,
    String? model,
    DateTime? createdAt,
    String? color,
    int? nbrPlace,
    String? state_car,
    List<CarTravelView>? travel,
    CarCooperativeView? cooperative,
    DateTime? deletedAt,
    DateTime? updatedAt,
  }) {
    if (matriculate != null) {
      this.matriculate = matriculate;
    }
    if (model != null) {
      this.model = model;
    }
    if (createdAt != null) {
      this.createdAt = createdAt;
    }
    if (color != null) {
      this.color = color;
    }
    if (nbrPlace != null) {
      this.nbrPlace = nbrPlace;
    }
    if (state_car != null) {
      this.state_car = state_car;
    }
    //
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
