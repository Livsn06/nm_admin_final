import 'dart:convert';
import 'dart:developer';
import 'package:admin/global/gb_variables.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/ailments/md_ailment.dart';
import '../../models/ingredient/md_ingredient.dart';

class IngredientApi {
  static Future<List<IngredientModel>?> fetchAllIngredients() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/ingredients';
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
        log('Ingrdients fetch successful', name: 'API Ingrdients');
        return IngredientModel.listFromJson(data['data']);
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
      log(e.toString(), name: 'API Ingrdients CLIENT ERROR');
    }
    return null;
  }

  ///====================
  ///

  static Future<IngredientModel?> uploadIngredient(
      {required IngredientModel ingredient}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/ingredients';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: ingredient.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Ingredient uploaded successfully',
            name: 'API MAIN INGREDIENT UPLOAD');
        final result = jsonDecode(response.body);
        return IngredientModel.fromJson(result['data']);
      }

      log('${response.statusCode}', name: 'API ERROR MAIN INGREDIENT UPLOAD');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API  INGREDIENT UPLOAD', error: e);
    }
    return null;
  }
}
