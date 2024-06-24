import 'dart:convert';

import 'package:smarta1/widgets/travel/place/models/place_list_model.dart';

import '../utils/api_response.dart';
import 'package:http/http.dart' as http;

import '../utils/db_link.dart';
import '../widgets/travel/place/models/place_details_model.dart';

db_link link = db_link();

class PlaceServices {
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<PlaceListModel>>> getPlaceList(
      String travelid) async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/place/travelPlace/${travelid}'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Place Api reached');
      var jsonData = jsonDecode(response.body);
      var placeList = <PlaceListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');
        var reservationId;
        var travelId;

        //Null counter
        if (item['reservationId'] != null) {
          reservationId = item['reservationId'];
        } else {
          reservationId = null;
        }

        if (item['travelId'] != null) {
          travelId = item['travelId'];
        } else {
          travelId = null;
        }

        PlaceListModel place = PlaceListModel(
          isAvailable: item['isAvailable'],
          number: item['number'].toString(),
          placeId: item['_id'],
          reservationId: reservationId,
          travelId: travelId,
        );

        print('check number 2: model created!');
        placeList.add(place);
        print('check number 3: model added to main list!');
      }
      print('Place List returned');
      return APIResponse<List<PlaceListModel>>(data: placeList);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewPlace({required String placeId}) async {
    final _uri = Uri.parse('${link.mobile}:3000/api/place/' + placeId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('Place ID  $placeId');

    if (response.statusCode == 200) {
      print('Place Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');

      //Null counter
      var reservationId;
      var travelId;

      if (jsonData['reservationId'] != null) {
        reservationId = jsonData['reservationId'];
      } else {
        reservationId = null;
      }

      if (jsonData['travelId'] != null) {
        travelId = jsonData['travelId'];
      } else {
        travelId = null;
      }

      PlaceDetailsModel place = PlaceDetailsModel(
        isAvailable: jsonData['isAvailable'],
        number: jsonData['number'].toString(),
        placeId: placeId,
        reservationId: reservationId,
        travelId: travelId,
      );

      print('PLace returned in view function');
      return APIResponse<PlaceDetailsModel>(data: place);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
