import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/auth/md_session.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SessionApi {
  static final auth = SessionApi();

  Future<SessionModel?> session(String token) async {
    String base = API_BASE.value;
    String url = '$base/api/auth/session';
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token',
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Session confirmed', name: 'API SESSION');
        final data = jsonDecode(response.body);
        return SessionModel.fromJson(data, success: true);
      }

      log('Session Declined', name: 'API SESSION');
      if (response.statusCode == 405) {
        final data = jsonDecode(response.body);
        return SessionModel.fromJson(data, success: false);
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return SessionModel.fromJson(data, success: false);
      }
      return null;
    } catch (e) {
      Get.close(1);
      throw Exception(e);
    }
  }
}
