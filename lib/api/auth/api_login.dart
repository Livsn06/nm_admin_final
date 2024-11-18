import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/auth/md_login.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/user/md_user.dart';

class LoginApi {
  static final auth = LoginApi();

  Future<ResponseModel> login(UserModel user) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true'
        },
        body: user.loginToJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        //
        return ResponseModel.dataFromJson(result, success: true);
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        return ResponseModel.errorFromJson(result, success: false);
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API LOGIN ERROR');
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
