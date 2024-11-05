import 'dart:convert';
import 'dart:typed_data';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;
import 'package:admin/global/gb_variables.dart';

Future<Uint8List?> fetchApiImageBytes(String path) async {
  String base = API_BASE.value;
  String url = '$base/api/v2/storage/$path';
  String? token = await SessionAccess.instance.getSessionToken();
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(jsonDecode(response.body)['message']);
    print(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.bodyBytes;
    }
  } catch (e) {
    print('Error fetching image: $e');
  }
  return null;
}
