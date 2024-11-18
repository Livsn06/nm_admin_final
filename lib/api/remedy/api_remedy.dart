import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/remedies/md_ingredient.dart';
import 'package:admin/models/remedies/md_remedy.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../../global/gb_variables.dart';

class ApiRemedy {
  //
  static Future<ResponseModel> fetchAllRemedy() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies';
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
        return ResponseModel.dataListFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API REMEDY ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API REMEDY CLIENT ERROR');
      return ResponseModel.clientErrorFromJson(
        message: 'Something went wrong',
        success: false,
      );
    }
  }
}
