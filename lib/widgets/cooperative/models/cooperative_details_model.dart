class CooperativeDetailsModel {
  String cooperativeId;
  String nameCooperative;
  String emailCooperative;
  String address;
  List<String> phones;
  DateTime createdAt;
  DateTime updatedAt;
  String city;
  //
  List<String>? cars;
  List<String>? coopMembers;
  List<String>? ticketOffices;
  List<String>? posts;

  CooperativeDetailsModel({
    required this.cooperativeId,
    required this.nameCooperative,
    required this.emailCooperative,
    required this.address,
    required this.phones,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
    List<String>? cars,
    List<String>? coopMembers,
    List<String>? ticketOffices,
    List<String>? posts,
  }) {
    if (cars != null && cars.length > 0) {
      this.cars = cars;
    }
    if (coopMembers != null && coopMembers.length > 0) {
      this.coopMembers = coopMembers;
    }
    if (ticketOffices != null && ticketOffices.length > 0) {
      this.ticketOffices = ticketOffices;
    }
    if (posts != null && posts.length > 0) {
      this.posts = posts;
    }
  }
}

// class CooperativeDetailTravel {}

// class CooperativeDetailCoopMember {}

// class CooperativeDetailCars {}

// class CooperativeDetailTicketOffices {}

// class CooperativeDetailPosts {}
