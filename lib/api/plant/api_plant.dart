import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/image/md_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

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

        log('Plants fetched successfully', name: 'API PLANT');
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
        log('Plant fetched successfully', name: 'API PLANT');
        final result = jsonDecode(response.body);
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

  //====================================
  static Future<PlantModel?> uploadPlant({
    required PlantModel plant,
    required FormImageModel cover,
  }) async {
    String base = API_BASE.value;
    String url = '$base/api/v2/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      // Prepare multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      request.fields.addAll(plant.toJson());

      request.files.add(
        http.MultipartFile.fromBytes(
          'cover',
          cover.bytes!,
          filename: cover.name,
        ),
      );

      // Send the request and wait for the full response
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(responseData);
        log('Plant uploaded successfully', name: 'API PLANT UPLOAD');
        return PlantModel.fromJson(result['data']);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR PLANT UPLOAD');
      log(responseData, name: 'API ERROR DATA PLANT UPLOAD');
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT UPLOAD', error: e);
      return null;
    }
    return null;
  }

  //====================================

  static Future<AilmentModel?> uploadPlantAilment(AilmentModel ailment) async {
    String base = API_BASE.value;
    String url = '$base/api/v2/ailment/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    var body = ailment.toPlantJson();

    //
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Ailment uploaded successfully', name: 'API PLANT AILMENT UPLOAD');
        final result = jsonDecode(response.body);
        return AilmentModel.fromPlantJson(result['data']);
      }

      log(response.statusCode.toString(),
          name: 'API ERROR PLANT AILMENT UPLOAD');
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR CLIENT PLANT AILMENT UPLOAD');
      return null;
    }
  }

  //====================================

  static Future<ApiImageModel?> uploadPlantImage(
      PlantModel plant, FormImageModel image) async {
    String base = API_BASE.value;
    String url = '$base/api/v2/image/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      // Prepare multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      var imageDetail = ApiImageModel(name: plant.name, plant_id: plant.id);
      request.fields.addAll(imageDetail.toJson());

      request.files.add(
        http.MultipartFile.fromBytes(
          'path',
          image.bytes!,
          filename: image.name,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Image uploaded successfully', name: 'API PLANT IMAGE UPLOAD');
        final result = jsonDecode(responseData);
        return ApiImageModel.fromJson(result['data']);
      }
      log(response.statusCode.toString(), name: 'API ERROR PLANT IMAGE UPLOAD');

      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT IMAGE UPLOAD', error: e);
      return null;
    }
    return null;
  }
}
