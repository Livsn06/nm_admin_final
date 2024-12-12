import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/request/md_request_plant.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<List<RequestPlantModel>?> fetchAllRequests() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plantsAdditions';

    String? token = await SessionAccess.instance.getSessionToken();
    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Request fetched successfully', name: 'API PLANT REQUEST');
        final result = jsonDecode(response.body);
        return RequestPlantModel.listFromJson(result['data']);
      }
      return null;
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return null;
    }
  }
}
