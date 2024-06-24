class CooperativeCreateModel {
  String nameCooperative;
  String emailCooperative;
  String address;
  List<String> phones;
  DateTime startOfActivity;
  String city;
  String license;

  CooperativeCreateModel({
    required this.nameCooperative,
    required this.emailCooperative,
    required this.address,
    required this.phones,
    required this.startOfActivity,
    required this.city,
    required this.license,
  });

  Map<String, dynamic> toJson() {
    return {
      "nameCooperative": nameCooperative,
      "emailCooperative": emailCooperative,
      "address": address,
      "phones": phones,
      "startOfActivity": startOfActivity.toIso8601String(),
      "city": city,
      "license": license
    };
  }
}
