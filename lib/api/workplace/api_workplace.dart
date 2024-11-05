import 'dart:convert';
import 'dart:developer';

import 'package:admin/global/gb_variables.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/models/workplace/md_workplace.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;

class ApiWorkplace {
  static Future<List<WorkplaceModel>?> fetchAllRequests() async {
    String base = API_BASE.value;
    UserModel admin = await SessionAccess.instance.getSessionData();
    String? token = await SessionAccess.instance.getSessionToken();

    String url = '$base/api/v2/workplace/${admin.id}';

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Workplace fetched successfully', name: 'API WORKPLACE');
        final result = jsonDecode(response.body);
        return WorkplaceModel.listFromJson(result['data']);
      }
      return null;
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return null;
    }
  }
}
