import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/remedies/md_remedy.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;

import '../../global/gb_variables.dart';

class ApiRemedy {
  //
  static Future<List<RemedyModel>?> fetchAllRemedy() async {
    String base = API_BASE.value;
    String url = '$base/api/v2/remedies';
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
        final result = jsonDecode(response.body);

        log('Remedy fetched successfully', name: 'API REMEDY');
        return RemedyModel.fromJsonList(result['data']);
      }

      log(response.statusCode.toString(), name: 'API ERROR');
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return null;
    }
  }

  ///
  ///
  static Future<RemedyModel?> getRemedy(int id) async {
    String base = API_BASE.value;
    String url = '$base/api/v2/plants/$id';
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
        log('Plant fetched successfully', name: 'API PLANT');
        final result = jsonDecode(response.body);
        return RemedyModel.fromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API ERROR');
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return null;
    }
  }
}
