import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;

import '../../global/gb_variables.dart';

class ApiPlant {
  //
  static Future<List<PlantModel>?> fetchAllPlants() async {
    String base = API_BASE.value;
    String url = '$base/api/v2/plants';
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

        log(result['data'].toString(), name: 'API');
        return PlantModel.listFromJson(result['data']);
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
  static Future<PlantModel?> getPlants(int id) async {
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
        final result = jsonDecode(response.body);

        log(result['data'].toString(), name: 'API');
        return PlantModel.fromJson(result['data']);
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
