import 'dart:convert';
import 'dart:developer';

import 'package:admin/models/image/md_image.dart';

import '../../global/gb_variables.dart';

import '../../sessions/sn_access.dart';
import 'package:http/http.dart' as http;

class ApiImage {
  static Future<ImageModel?> getImage(String image) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/images/$image';
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
        log('Plant Image fetched successfully', name: 'API GET IMAGES');
        final result = jsonDecode(response.body);
        return ImageModel.fromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API GET IMAGES ERROR');

      return null;
      //
    } catch (e) {
      log(e.toString(), name: 'API IMAGES CLIENT ERROR');
      return null;
    }
  }
}
