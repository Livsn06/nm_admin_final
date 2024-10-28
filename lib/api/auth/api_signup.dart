import 'dart:convert';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/models/auth/md_signup.dart';
import 'package:http/http.dart' as http;

class SignupApi {
  static final auth = SignupApi();

  Future<ResponseModel?> register(SignupModel credentials) async {
    String base = API_BASE.value;
    String url = '$base/api/auth/register';
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
        return ResponseModel.fromJson(data, success: true);
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return ResponseModel.fromJson(data, success: false);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
