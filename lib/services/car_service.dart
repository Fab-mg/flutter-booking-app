import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cars/model/car_entity_create.dart';
import 'package:smarta1/widgets/cars/model/car_entity_view.dart';
import '../utils/db_link.dart';
import '../widgets/cars/model/car_entity.dart';

db_link link = db_link();

class CarServices {
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<Car>>> getCars() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/car/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    if (response.statusCode == 200) {
      print('Car Api reached');
      var jsonData = jsonDecode(response.body);
      var cars = <Car>[];
      for (var item in jsonData) {
        print('check number 1!');
        // final cooperative = CarCooperative(
        //   cooperativeId:
        //       item['cooperative']['id'] ? item['cooperative']['id'] : null,
        //   name:
        //       item['cooperative']['name'] ? item['cooperative']['name'] : null,
        // );

        // var travels = <CarTravel>[];
        // for (var travelItem in item['travel']) {
        //   final travel = CarTravel(
        //     travelId: travelItem['travelId']!,
        //     travelDate: travelItem['travelDate']!,
        //   );
        //   travels.add(travel);
        // }

        Car car = Car(
          carId: item['_id'],
          matriculate: item['matriculate'],
          model: item['model'],
          createdAt: DateTime.parse(item['createdAt']),
          // updatedAt:
          //     item['updatedAt'] ? DateTime.parse(item['updatedAt']) : null,
          color: item['color'],
          nbrPlace: item['nbrPlace'],
          state_car: item['state_car'],
          // cooperative: cooperative,
          // travel: travels,
        );

        print('check number 2!');
        cars.add(car);
        print('check number 3!');
      }
      print('car returned');
      return APIResponse<List<Car>>(data: cars);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<CarView?>> viewCar(String carId) async {
    final _uri = Uri.parse('${link.mobile}:3000/api/car/' + carId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });
    print('car id ' + carId);
    if (response.statusCode == 200) {
      print('Car Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1!');
      var cooperative;
      if (jsonData['cooperative'] != null) {
        cooperative = CarCooperativeView(
          cooperativeId: jsonData['cooperative']['id'] != null
              ? jsonData['cooperative']['id']
              : null,
          name: jsonData['cooperative']['name'] != null
              ? jsonData['cooperative']['name']
              : null,
        );
      } else {
        cooperative = null;
      }
      List<CarTravelView> travels = [];
      if (jsonData['travel'] != null) {
        for (var travelItem in jsonData['travel']) {
          final travel = CarTravelView(
            travelId: travelItem['travelId'],
            travelDate: DateTime.parse(travelItem['travelDate']),
          );
          travels.add(travel);
        }
      }
      print('travels length:  ' + travels.length.toString());
      // else {
      //   travels = null;
      // }

      CarView car = CarView(
        carId: jsonData['_id'],
        matriculate: jsonData['matriculate'],
        model: jsonData['model'],
        createdAt: DateTime.parse(jsonData['createdAt']),
        updatedAt: jsonData['updatedAt'] != null
            ? DateTime.parse(jsonData['updatedAt'])
            : null,
        color: jsonData['color'],
        nbrPlace: jsonData['nbrPlace'],
        state_car: jsonData['state_car'],
        cooperative: cooperative,
        travel: travels.length > 0 ? travels : null,
      );
      print('car returned in view function');
      print(car.carId);
      return APIResponse<CarView>(data: car);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<bool>> createCar(CarEntityCreate car) async {
    http.Response response;
    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/car'),
      headers: header,
      body: jsonEncode(car.toJson()),
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    if (response.statusCode == 201) {
      return APIResponse<bool>(data: true);
    } else {
      print('Connection error');
      return APIResponse(
          data: false,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<bool>> updateCar(String carId, CarEntityCreate car) async {
    http.Response response;
    response = await http
        .put(
      Uri.parse('${link.mobile}:3000/api/car/' + carId),
      body: jsonEncode(car.toJson()),
      headers: header,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    if (response.statusCode == 200) {
      return APIResponse(data: true);
    } else {
      return APIResponse(
        data: false,
        error: true,
        errorMessage: 'error code: ' + response.statusCode.toString(),
      );
    }
  }
}
