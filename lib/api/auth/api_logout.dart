import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/auth/md_login.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogoutApi {
  static final auth = LogoutApi();

  Future<ResponseModel?> logoutAccount() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/logout';
    String? token = await SessionAccess.instance.getSessionToken();

    //
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('LOGOUT successful', name: 'API LOGOUT');
        // return ResponseModel.fromEmailOnlyJson(data, success: true);
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return ResponseModel.fromJson(data, success: false);
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return ResponseModel.fromJson(data, success: false);
      }
      return null;
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API LOGOUT');
    }
    return null;
  }
}
