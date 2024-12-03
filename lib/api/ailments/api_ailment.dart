import 'dart:convert';
import 'dart:developer';
import 'package:admin/global/gb_variables.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/ailments/md_ailment.dart';

class AilmentApi {
  static Future<List<AilmentModel>?> fetchAllAilment() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/ailments';
    String? token = await SessionAccess.instance.getSessionToken();
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Ailments fetch successful', name: 'API AILMENTS');
        return AilmentModel.listFromJson(data['data']);
      }

      if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        return null;
      }

      if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        return null;
      }
    } catch (e) {
      Get.close(1);
      log(e.toString(), name: 'API SEARCH EMAIL');
    }
    return null;
  }
}
