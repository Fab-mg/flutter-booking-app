import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smarta1/widgets/reservation/models/reservation_create_model.dart';
import 'package:smarta1/widgets/reservation/models/reservation_detail_model.dart';
import 'package:smarta1/widgets/reservation/models/reservation_user_model.dart';

import '../utils/api_response.dart';
import '../utils/db_link.dart';
import '../widgets/reservation/models/reservation_list_model.dart';

db_link link = db_link();

class ReservationService {
  final header = {'Content-Type': 'application/json'};

  Future<APIResponse<bool>> createReservation(
      ReservationCreateModel reservation) async {
    http.Response response;
    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/reservation'),
      headers: header,
      body: jsonEncode(reservation.toJson()),
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    if (response.statusCode == 201) {
      print('Connection OKKK');
      return APIResponse<bool>(data: true);
    } else {
      print('Connection error');
      return APIResponse(
          data: false,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<List<ReservationListModel>>> getReservationsList() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/reservation/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Reservation Api reached');
      var jsonData = jsonDecode(response.body);
      var reservations = <ReservationListModel>[];
      for (var item in jsonData) {
        print('check number 1! loop iteration');

        ReservationListModel reservation = ReservationListModel(
          CIN: item['CIN'],
          fullName: item['fullName'],
          reservationAuthor: item['reservationAuthor'],
          reservationId: item['_id'],
          reservedPlace: item['reservedPlace'],
        );

        print('check number 2! reservation created in loop');
        reservations.add(reservation);
        print('check number 3! reservation added to main reservations list');
      }
      print('Cities returned');
      return APIResponse<List<ReservationListModel>>(data: reservations);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<List<ReservationListModel>>> getReservationsListForUser(
      String userId) async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/reservation/author/$userId'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Reservation Api reached');
      var jsonData = jsonDecode(response.body);
      var reservations = <ReservationListModel>[];
      for (var item in jsonData) {
        print('check number 1! loop iteration');

        ReservationListModel reservation = ReservationListModel(
          CIN: item['CIN'],
          fullName: item['fullName'],
          reservationAuthor: item['reservationAuthor'],
          reservationId: item['_id'],
          reservedPlace: item['reservedPlace'],
        );

        print('check number 2! reservation created in loop');
        reservations.add(reservation);
        print('check number 3! reservation added to main reservations list');
      }
      print('Reservations returned');
      return APIResponse<List<ReservationListModel>>(data: reservations);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewReservation({required String reservationId}) async {
    final _uri =
        Uri.parse('${link.mobile}:3000/api/reservation/' + reservationId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('REsevation ID  $reservationId');

    if (response.statusCode == 200) {
      print('reservation Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');

      ReservationDetailsModel reservation = ReservationDetailsModel(
          CIN: jsonData["CIN"],
          fullName: jsonData["fullName"],
          reservationAuthor: jsonData["reservationAuthor"],
          reservationId: jsonData["_id"],
          reservedPlace: jsonData["reservedPlace"],
          phone: jsonData["phone"],
          relativePhone: jsonData["relativePhone"]);

      print('REservation returned in view function');
      return APIResponse<ReservationDetailsModel>(data: reservation);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> deleteReservation(String reservationId) async {
    final _uri =
        Uri.parse('${link.mobile}:3000/api/reservation/' + reservationId);
    http.Response response;
    response = await http
        .delete(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('REsevation ID  $reservationId');

    if (response.statusCode == 200) {
      print('reservation deleted successfully');
      return APIResponse(data: '');
    } else {
      print('Delete error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<bool>> updateReservationUser(
      ReservationUser reservationUser, String reservationId) async {
    http.Response response;
    response = await http
        .put(
      Uri.parse('${link.mobile}:3000/api/reservation/${reservationId}'),
      headers: header,
      body: jsonEncode(reservationUser.toJson()),
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });
    print('Update function launched');

    if (response.statusCode == 200) {
      print('Connection OKKK');
      return APIResponse<bool>(data: true);
    } else {
      print('Connection error');
      return APIResponse(
          data: false,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
