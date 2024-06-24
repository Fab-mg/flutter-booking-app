import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:smarta1/widgets/travel/models/travel_filter.dart';
import 'package:smarta1/widgets/travel/models/travel_list_model.dart';

import '../utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../utils/db_link.dart';
import '../widgets/travel/models/travel_detail_model.dart';

db_link link = db_link();

class TravelService {
  final header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<TravelListModel>>> getTravels() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/travel/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Travel Api reached');
      var jsonData = jsonDecode(response.body);
      var travels = <TravelListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');

        TravelCity leavingCity = TravelCity(
            cityId: item["leaving"]["cityId"],
            cityName: item["leaving"]["cityName"]);

        TravelCity arrivalCity = TravelCity(
            cityId: item["arrive"]["cityId"],
            cityName: item["arrive"]["cityName"]);

        TravelCar travelCar = TravelCar(
            carId: item["travelCar"]["carId"],
            carMatriculate: item["travelCar"]["carMatriculate"]);

        print('check number 2: sub-model creation!');

        TravelListModel travel = TravelListModel(
          travelId: item["_id"],
          leavingAt: DateTime.parse(item["leavingAt"]),
          arrivingAt: DateTime.parse(item["arrivingAt"]),
          state: item["state"],
          leavingCity: leavingCity,
          arrivalCity: arrivalCity,
          createdAt: DateTime.parse(item["createdAt"]),
          travelCar: travelCar,
          travelAuthorCoop: item["travelAuthor"]["cooperativeName"],
          availablePlaceCount: item["avalaiblePlaceCount"],
          placeCount: item["placeCount"],
          prixUnitaire: item["prixUnitaire"],
        );

        print('check number 3: models created!');
        travels.add(travel);
        print('check number 4: model added to main list!');
      }
      print('Travel returned');
      return APIResponse<List<TravelListModel>>(data: travels);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<List<TravelListModel>>> getFilteredTravels(
      TravelFilter filter) async {
    print('filter function initiated : ${filter.travelDate}');

    var timeOne = DateFormat('y-MM-dd').format(filter.travelDate).toString() +
        'T00:00:00.384+00:00';
    print('uri filter query set : ${timeOne}');
    var timeTwo = DateFormat('dd').format(filter.travelDate);
    var newDay = int.parse(timeTwo) + 1;
    timeTwo = DateFormat('y-MM').format(filter.travelDate).toString() +
        '-' +
        newDay.toString() +
        'T00:00:00.384+00:00';

    final uri = Uri.parse('${link.mobile}:3000/api/travel/query').replace(
      queryParameters: {
        "destinationCityId": filter.destinationCityId,
        "departCityId": filter.departCityId,
        "leavingDate": timeOne,
        "leavingDateMax": timeTwo,
      },
    );

    http.Response response;
    response = await http
        .get(
      uri,
      headers: header,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Travel Api reached');
      var jsonData = jsonDecode(response.body);
      var travels = <TravelListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');

        TravelCity leavingCity = TravelCity(
            cityId: item["leaving"]["cityId"],
            cityName: item["leaving"]["cityName"]);

        TravelCity arrivalCity = TravelCity(
            cityId: item["arrive"]["cityId"],
            cityName: item["arrive"]["cityName"]);

        TravelCar travelCar = TravelCar(
            carId: item["travelCar"]["carId"],
            carMatriculate: item["travelCar"]["carMatriculate"]);

        print('check number 2: sub-model creation!');

        TravelListModel travel = TravelListModel(
          travelId: item["_id"],
          leavingAt: DateTime.parse(item["leavingAt"]),
          arrivingAt: DateTime.parse(item["arrivingAt"]),
          state: item["state"],
          leavingCity: leavingCity,
          arrivalCity: arrivalCity,
          createdAt: DateTime.parse(item["createdAt"]),
          travelCar: travelCar,
          travelAuthorCoop: item["travelAuthor"]["cooperativeName"],
          availablePlaceCount: item["avalaiblePlaceCount"],
          placeCount: item["placeCount"],
          prixUnitaire: item["prixUnitaire"],
        );

        print('check number 3: models created!');
        travels.add(travel);
        print('check number 4: model added to main list!');
      }
      print('Travel returned');
      return APIResponse<List<TravelListModel>>(data: travels);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<TravelDetailModel?>> viewTravelDetails(
      String travelId) async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/travel/${travelId}'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Travel Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1: model creation!');

      TravelCity2 leavingCity = TravelCity2(
          cityId: jsonData["leaving"]["cityId"],
          cityName: jsonData["leaving"]["cityName"]);

      TravelCity2 arrivalCity = TravelCity2(
          cityId: jsonData["arrive"]["cityId"],
          cityName: jsonData["arrive"]["cityName"]);

      TravelCar2 travelCar = TravelCar2(
          carId: jsonData["travelCar"]["carId"],
          carMatriculate: jsonData["travelCar"]["carMatriculate"]);

      print('check number 2: sub-model creation!');

      TravelDetailModel travel = TravelDetailModel(
        travelId: jsonData["_id"],
        leavingAt: DateTime.parse(jsonData["leavingAt"]),
        arrivingAt: DateTime.parse(jsonData["arrivingAt"]),
        state: jsonData["state"],
        leavingCity: leavingCity,
        arrivalCity: arrivalCity,
        createdAt: DateTime.parse(jsonData["createdAt"]),
        travelCar: travelCar,
        travelAuthorCoop: jsonData["travelAuthor"]["cooperativeName"],
        availablePlaceCount: jsonData["avalaiblePlaceCount"],
        placeCount: jsonData["placeCount"],
        prixUnitaire: jsonData["prixUnitaire"],
        travelAuthorCoopMember: jsonData["travelAuthor"]["guichetMemberId"],
      );

      print('check number 3: models created!');
      print('Travel returned');
      return APIResponse<TravelDetailModel>(data: travel);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
