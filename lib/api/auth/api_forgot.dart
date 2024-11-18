import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/auth/md_login.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordApi {
  static final auth = ForgotPasswordApi();

  Future<ResponseModel?> searchEmail(LoginModel credentials) async {
    String base = API_BASE.value;
    String url = '$base/api/auth/searchEmail';
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true'
    };

    var body = credentials.toJson();

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Searching Email successful', name: 'API SEARCH EMAIL');
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
      log(e.toString(), name: 'API SEARCH EMAIL');
    }
    return null;
  }
}
