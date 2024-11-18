import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:http/http.dart' as http;

class SignupApi {
  static final auth = SignupApi();

  Future<ResponseModel> register(UserModel user) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/users/register';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true'
        },
        body: user.registerToJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        log(result.toString(),
            name: 'REGISTER USER API: ${response.statusCode}');

        //
        return ResponseModel.dataFromJson(result, success: true);
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(),
            name: 'REGISTER USER API: ${response.statusCode}');

        return ResponseModel.errorFromJson(result, success: false);
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API REGISTER ERROR');
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
