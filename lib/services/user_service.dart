import 'dart:convert';

import 'package:smarta1/widgets/profile/models/user_details_model.dart';

import '../utils/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/custom_keys.dart';
import '../utils/db_link.dart';

db_link link = db_link();

class UserService {
  final header = {'Content-Type': 'application/json'};

  Future<String?> userParse() async {
    final storage = new FlutterSecureStorage();
    String? user = await storage.read(key: CustomKeys().authKey);
    if (user != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(user);
      String userId = decodedToken['_id'];
      return userId;
    }
    return null;
  }

  Future<APIResponse<UserDetailsModel?>> viewProfile() async {
    String? userId = await userParse();
    if (userId == null) {
      print('Parsing got null');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error: userParsing level 1'));
    }

    final _uri = Uri.parse('${link.mobile}:3000/api/user-fab/${userId}');
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('User-fab id ' + userId);

    if (response.statusCode == 200) {
      print('CM Api reached');
      var jsonData = jsonDecode(response.body);
      print('check number 1! : json decode');

      var updatedAt;
      if (jsonData['updatedAt'] != null) {
        updatedAt = DateTime.parse(jsonData['updatedAt']);
      } else {
        updatedAt = null;
      }

      bool boolParse(String x) {
        if (x.toLowerCase() == "true") {
          return true;
        } else {
          return false;
        }
      }

      UserDetailsModel user = UserDetailsModel(
        isCoopMember: jsonData['isCoopMember'],
        userId: userId,
        firstName: jsonData['firstName'],
        lastName: jsonData['lastName'],
        email: jsonData['email'],
        createdAt: DateTime.parse(jsonData['createdAt']),
        updatedAt: updatedAt,
        activatedAccount: jsonData['activatedAccount'],
        userStatus: jsonData['userStatus'],
      );

      print('User returned in view function');
      print(user.createdAt);
      return APIResponse<UserDetailsModel>(data: user);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  // Future<APIResponse> viewUser(String userId) async {
  //   final _uri = Uri.parse('${link.mobile}:3000/api/user-fab/${userId}');
  //   http.Response response;
  //   response = await http
  //       .get(_uri, headers: header)
  //       .timeout(const Duration(seconds: 10), onTimeout: () {
  //     return http.Response('Error', 408);
  //   });
  //   print('User-fab id ' + userId);

  //   if (response.statusCode != 200) {
  //     return APIResponse(
  //         data: 'data',
  //         error: true,
  //         errorMessage: response.statusCode.toString());
  //   } else {
  //     print('User Api reached');
  //     var jsonData = jsonDecode(response.body);
  //     print('check number 1! : json decode');
  //     UserDetailsModel user = UserDetailsModel(
  //       isCoopMember: jsonData['isCoopMember'],
  //       userId: jsonData['isCoopMember'],
  //       firstName: jsonData['_id'],
  //       lastName: jsonData['lastName'],
  //       email: jsonData['email'],
  //       createdAt: DateTime.parse(jsonData['createdAt']),
  //       activatedAccount: jsonData['activatedAccount'],
  //       userStatus: jsonData['userStatus'],
  //     );

  //     print('User returned in view function');
  //     return APIResponse<UserDetailsModel>(data: user);
  //   }
  // }

  bool boolParse(String x) {
    if (x.toLowerCase() == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future<APIResponse> viewUserDetails({required String userId}) async {
    final _uri = Uri.parse('${link.mobile}:3000/api/user-fab/' + userId);
    http.Response response;
    response = await http
        .get(_uri, headers: header)
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Error', 408);
    });
    print('User-fab ID  $userId');
    if (response.statusCode == 200) {
      print('User Api reached');
      var jsonData = jsonDecode(response.body);
      print('User number 1! : json decode');

      UserDetailsModel user = UserDetailsModel(
        isCoopMember: jsonData['isCoopMember'],
        userId: userId,
        firstName: jsonData['firstName'],
        lastName: jsonData['lastName'],
        email: jsonData['email'],
        createdAt: DateTime.parse(jsonData['createdAt']),
        // updatedAt: updatedAt,
        activatedAccount: jsonData['activatedAccount'],
        userStatus: jsonData['userStatus'],
      );

      print('UserFab returned in view function');
      return APIResponse<UserDetailsModel>(data: user);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }
}
