import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:http/http.dart' as http;

import '../../models/user/md_user.dart';

class LoginApi {
  static final auth = LoginApi();

  // "message": "Login successful",
  //   "access_token": "1|yhRpWjpixotHVVD3NOa7Tqyiq1dPpvYF3nhRwk2W6c00f696",
  //   "data": {
  //       "id": 1,
  //       "name": "Joel Gutlay",
  //       "email": "jo@email.com",
  //       "email_verified_at": null,
  //       "role": "admin",
  //       "status": "active",
  //       "avatar": null,
  //       "phone": null,
  //       "address": null,
  //       "created_at": "2024-12-03T05:34:23.000000Z",
  //       "updated_at": "2024-12-03T05:34:23.000000Z"
  //   }
  Future<dynamic> login(UserModel user) async {
    String base = API_BASE.value;
    String url = '$base/api/auth/login';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true'
        },
        body: user.loginToJson(),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        //
        return UserModel.fromJson(
          result['data'],
          accessToken: result['access_token'],
        );
      }

      if (response.statusCode == 422) {
        var result = jsonDecode(response.body);
        log(result.toString(), name: 'LOGIN USER API: ${response.statusCode}');

        return result['message'].toString();
      }
    } catch (e) {
      log(e.toString(), name: 'CLIENT API LOGIN ERROR');
    }
    return 'Cannot connect to server';
  }
}
