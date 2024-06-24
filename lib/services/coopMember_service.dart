import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:smarta1/utils/api_response.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_create_model.dart';
import 'package:smarta1/widgets/cooperative/models/cooperative_details_model.dart';

import '../utils/db_link.dart';
import '../widgets/cooperative_member/models/coopMember_details_model.dart';
import '../widgets/cooperative_member/models/coopMember_list_model.dart';

db_link link = db_link();

class CoopMemberServices {
  static const header = {'Content-Type': 'application/json'};

  Future<APIResponse<List<CoopMemberListModel>>> getCoopMembers() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${link.mobile}:3000/api/coop-member/'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    });

    if (response.statusCode == 200) {
      print('CM Api reached');
      var jsonData = jsonDecode(response.body);
      var coopMembers = <CoopMemberListModel>[];
      for (var item in jsonData) {
        print('check number 1: model creation!');

        CoopMemberListModel coopMember = CoopMemberListModel(
          coopMemberId: item["_id"],
          matriculateCM: item["matriculateCM"],
          roleCM: item["roleCM"],
          userId: item["userId"],
        );

        print('check number 2: model created!');
        coopMembers.add(coopMember);
        print('check number 3: model added to main list!');
      }
      print('CM returned');
      return APIResponse<List<CoopMemberListModel>>(data: coopMembers);
    } else {
      print('Connection error');
      return APIResponse(
          data: [],
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> viewCoopMember(String coopMemberId) async {
    final _uri =
        Uri.parse('${link.mobile}:3000/api/coop-member/' + coopMemberId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('CM id ' + coopMemberId);
    if (response.statusCode == 200) {
      print('CM Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');

      CoopMemberDetailsModel coopMember = CoopMemberDetailsModel(
        coopMemberId: coopMemberId,
        matriculateCM: jsonData['matriculateCM'],
        roleCM: jsonData['roleCM'],
        userId: jsonData['userId'],
        createdAt: DateTime.parse(jsonData['createdAt']),
        cooperativeId: jsonData['cooperativeId'],
      );

      print('CM returned in view function');
      return APIResponse<CoopMemberDetailsModel>(data: coopMember);
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
