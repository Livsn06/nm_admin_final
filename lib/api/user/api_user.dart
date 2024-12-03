import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;

import '../../global/gb_variables.dart';
import '../../models/response/md_response.dart';

class ApiUser {
  static Future<List<UserModel>?> fetchAllUser() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users';
    String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200) {
        log('User fetched successfully', name: 'API ALL USER');
        final result = jsonDecode(response.body);
        return UserModel.listFromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API ALL USER ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API ALL USER CLIENT ERROR');
    }
    return null;
  }

  //====================
  static Future<ResponseModel> getUser(int id) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/$id';
    String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('User get successfully', name: 'API USER BY ID');
        final result = jsonDecode(response.body);

        return ResponseModel.dataFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API USER BY ID ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //======================
  static Future<List<UserModel>?> fetchRoleUser(String role) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/$role/role';
    String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200) {
        log('User role fetched successfully', name: 'API USER BY ROLE');
        final result = jsonDecode(response.body);
        return UserModel.listFromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API USER BY ROLE ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API USER BY ROLE CLIENT ERROR');
    }
    return null;
  }

  //==================================
  static Future<ResponseModel> updateUserStatus(UserModel user) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/${user.id}';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: user.updateStatusToJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'USER STATUS API: ${response.statusCode}');

        //
        return ResponseModel.dataFromJson(result, success: true);
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'USER STATUS API: ${response.statusCode}');

        return ResponseModel.errorFromJson(result, success: false);
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API USER ERROR');
      //
      return ResponseModel.clientErrorFromJson(
        success: false,
        message: 'Client side error.',
      );
    }
    return ResponseModel.clientErrorFromJson(
      success: false,
      message: 'Cannot connect to server',
    );
  }
}
