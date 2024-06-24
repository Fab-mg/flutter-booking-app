class CarEntityCreate {
  String matriculate;
  String model;
  String color;
  int nbrPlace;
  String state_car;

  CarEntityCreate({
    required this.matriculate,
    required this.model,
    required this.color,
    required this.nbrPlace,
    required this.state_car,
  });

  Map<String, dynamic> toJson() {
    return {
      "matriculate": matriculate,
      "model": model,
      "color": color,
      "nbrPlace": nbrPlace,
      "state_car": state_car
    };
  }
}
