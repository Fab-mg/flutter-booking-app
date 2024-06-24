import 'dart:convert';

import 'package:smarta1/utils/custom_keys.dart';
import 'package:smarta1/utils/db_link.dart';
import 'package:smarta1/widgets/login/models/user_confirm_model.dart';
import 'package:smarta1/widgets/login/models/user_login_model.dart';
import 'package:smarta1/widgets/login/models/user_register_model.dart';

import '../utils/api_response.dart';
import 'package:http/http.dart' as http;
//DATA STORE PKG
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

db_link link = db_link();

class AuthService {
  final header = {'Content-Type': 'application/json'};
  Future<APIResponse<String?>> login(UserLoginInfo userInfo) async {
    http.Response response;
    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/user-fab/login/'),
      headers: header,
      body: jsonEncode(userInfo.toJson()),
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    if (response.statusCode == 201) {
      print('Login Api reached');
      var jsonData = jsonDecode(response.body);

      print('Json token: ${jsonData['access_token']}');
      bool tokenStored = await this.authSave(jsonData['access_token']);
      if (!tokenStored) {
        return APIResponse(
            data: null, error: true, errorMessage: ('failed to store token'));
      }
      print('token stored and returned');
      return APIResponse<String>(data: jsonData['access_token']);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> register(UserRegisterInfo user) async {
    http.Response response;
    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/user-fab/register/'),
      headers: header,
      body: jsonEncode(user.toJson()),
    )
        .timeout(const Duration(seconds: 5), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });
    if (response.statusCode == 201) {
      print('Register Api reached, email sent');
      return APIResponse(data: null);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  Future<APIResponse> confirmAccount({required UserConfirmModel info}) async {
    http.Response response;

    response = await http
        .post(
      Uri.parse('${link.mobile}:3000/api/user-fab/confirm'),
      headers: header,
      body: jsonEncode(info.toJson()),
    )
        .timeout(const Duration(seconds: 8), onTimeout: () {
      // Time has run out, do what you wanted to do.
      return http.Response(
          'Error', 408); // Request Timeout response status code
    });

    print('Confirm api reached');

    print(info.email);
    if (response.statusCode == 201) {
      print('Account confirmed');
      return APIResponse(data: null);
    } else {
      print('Connection error');
      return APIResponse(
          data: null,
          error: true,
          errorMessage: ('error ' + response.statusCode.toString()));
    }
  }

  //HELPER
  Future<bool> authSave(String accessToken) async {
    bool hasExpired = JwtDecoder.isExpired(accessToken);
    if (hasExpired) {
      print('Token expired!!');
      return false;
    }

    // Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    // print(decodedToken);
    final storage = new FlutterSecureStorage();
    // String? user = await storage.read(key: CustomKeys().authKey);

    // if (user == null) {
    //   return false;
    // }
    await storage.write(key: CustomKeys().authKey, value: accessToken);
    return true;
  }

  Future<bool> loggedinCheck() async {
    final storage = new FlutterSecureStorage();
    String? user = await storage.read(key: CustomKeys().authKey);
    if (user == null) {
      return false;
    }
    return true;
  }

  logout() async {
    final storage = new FlutterSecureStorage();
    String? user = await storage.read(key: CustomKeys().authKey);
    if (user == null) {
      return;
    }
    storage.delete(key: CustomKeys().authKey);
  }
}
