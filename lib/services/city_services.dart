import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smarta1/widgets/city/model/city_list.dart';
import 'package:smarta1/widgets/city/model/city_view.dart';

import '../utils/api_response.dart';
import '../utils/db_link.dart';

db_link link = db_link();

class CityServices {
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<CityListModel>>> getCities() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/city/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('City Api reached');
      var jsonData = jsonDecode(response.body);
      var cities = <CityListModel>[];
      for (var item in jsonData) {
        print('check number 1! loop iteration');

        CityListModel city = CityListModel(
          nameCity: item['nameCity'],
          cityId: item['_id'],
          postalCode: item['postalCode'].toString(),
        );

        print('check number 2! city created in loop');
        cities.add(city);
        print('check number 3! city added to main city list');
      }
      print('Cities returned');
      return APIResponse<List<CityListModel>>(data: cities);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewCity({required String cityId}) async {
    final _uri = Uri.parse('${link.mobile}:3000/api/city/' + cityId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('City ID  $cityId');
    if (response.statusCode == 200) {
      print('City Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');
      CityViewModel city = CityViewModel(
        nameCity: jsonData['nameCity'],
        cityId: cityId,
        postalCode: jsonData['postalCode'].toString(),
      );

      print('City returned in view function');
      return APIResponse<CityViewModel>(data: city);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
