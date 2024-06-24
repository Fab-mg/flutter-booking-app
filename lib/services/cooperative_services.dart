import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_create_model.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_details_model.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_list_model.dart';

import '../utils/db_link.dart';

db_link link = db_link();

class CooperativeServices {
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<CooperativeListModel>>> getCooperatives() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/cooperative/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Coop Api reached');
      var jsonData = jsonDecode(response.body);
      var cooperatives = <CooperativeListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');
        var array = item['phones'];
        List<String> phones = List<String>.from(array);

        CooperativeListModel cooperative = CooperativeListModel(
          cooperativeId: item["_id"],
          nameCooperative: item["nameCooperative"],
          address: item["address"],
          phones: phones,
        );

        print('check number 2: model created!');
        cooperatives.add(cooperative);
        print('check number 3: model added to main list!');
      }
      print('Coop returned');
      return APIResponse<List<CooperativeListModel>>(data: cooperatives);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<List<CooperativeListModel>>> searchCooperatives(
      {required String query}) async {
    http.Response response;
    response = await http
        .get(Uri.parse(
            '${link.mobile}:3000/api/cooperative/find?keyword=$query'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Coop Search $query Api reached');
      var jsonData = jsonDecode(response.body);
      var cooperatives = <CooperativeListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');
        var array = item['phones'];
        List<String> phones = List<String>.from(array);

        CooperativeListModel cooperative = CooperativeListModel(
          cooperativeId: item["_id"],
          nameCooperative: item["nameCooperative"],
          address: item["address"],
          phones: phones,
        );

        print('check number 2: model created!');
        cooperatives.add(cooperative);
        print('check number 3: model added to main list!');
      }
      print('Filtered Coop returned');
      return APIResponse<List<CooperativeListModel>>(data: cooperatives);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewCooperative(String cooperativeId) async {
    final _uri =
        Uri.parse('${link.mobile}:3000/api/cooperative/' + cooperativeId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('coop id ' + cooperativeId);
    if (response.statusCode == 200) {
      print('Cooperative Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');

      var arrayPhones = jsonData['phones'];
      List<String> phones = List<String>.from(arrayPhones);

      var arrayCars = jsonData['cars'] == null ? [] : jsonData['cars'];
      List<String> cars = List<String>.from(arrayCars);

      var arrayTicketOffices =
          jsonData['ticketOffices'] == null ? [] : jsonData['ticketOffices'];
      List<String> ticketOffices = List<String>.from(arrayTicketOffices);

      var arrayPosts = jsonData['posts'] == null ? [] : jsonData['posts'];
      List<String> posts = List<String>.from(arrayPosts);

      CooperativeDetailsModel cooperative = CooperativeDetailsModel(
        cooperativeId: cooperativeId,
        nameCooperative: jsonData["nameCooperative"],
        emailCooperative: jsonData["emailCooperative"],
        address: jsonData["address"],
        phones: phones,
        createdAt: DateTime.parse(jsonData["createdAt"]),
        updatedAt: DateTime.parse(jsonData["createdAt"]),
        city: jsonData["city"],
        cars: cars,
        ticketOffices: ticketOffices,
        posts: posts,
      );
      print('Cooperative returned in view function');
      return APIResponse<CooperativeDetailsModel>(data: cooperative);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<bool>> createCooperative(
      CooperativeCreateModel cooperative) async {
    http.Response response;
    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/cooperative'),
      headers: header,
      body: jsonEncode(cooperative.toJson()),
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response('Error', 408);
    });

    if (response.statusCode == 201) {
      return APIResponse<bool>(data: true);
    } else {
      print('Connection error ${response.statusCode.toString()}');
      print('Connection error ${response.body.toString()}');
      return APIResponse(
          data: false,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse<bool>> updateCooperative(
      {required String cooperativeId,
      required CooperativeCreateModel cooperative}) async {
    http.Response response;
    response = await http
        .put(
      Uri.parse('${link.mobile}:3000/api/cooperative/${cooperativeId}'),
      body: jsonEncode(cooperative.toJson()),
      headers: header,
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('Update successful with ${response.statusCode}');
      print('Update data ${response.body}');

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
