import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/plant/md_plant_local_name.dart';
import 'package:admin/models/plant/md_plant_treatment.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../global/gb_variables.dart';

// "message": "Plant fetch successfully",
//     "data": [
//         {
//             "id": 5,
//             "name": "Aloe vera",
//             "scientific_name": "Aloe barbadensis miller",
//             "local_name": "[\"Sabila\"]",
//             "description": "Aloe vera, often called the \"plant of immortality,\" is a succulent plant known for its thick, fleshy leaves filled with a gel-like substance. Native to arid regions, it thrives in warm climates and has been used for centuries in traditional medicine, skincare, and wellness practices.",
//             "status": "inactive",
//             "image_path": "[\"plant_image\\/1733209455_Aloe vera1.jpg\",\"plant_image\\/1733209456_Aloe vera2.jpg\",\"plant_image\\/1733209456_Aloe vera3.jpg\",\"plant_image\\/1733209456_Aloe vera4.jpg\"]",
//             "uploader_id": null,
//             "created_at": "2024-12-03T07:04:16.000000Z",
//             "updated_at": "2024-12-03T07:04:16.000000Z"
//         }
//     ]
class ApiPlant {
  //
  static Future<List<PlantModel>?> fetchAllPlants() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
      'Authorization': 'Bearer $token'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      //
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        log('Plants fetched successfully', name: 'API PLANT');
        // log(result['data'], name: 'API PLANT');
        return PlantModel.listFromJson(result['data']);
      }

      log(response.statusCode.toString(), name: 'API PLANT ERROR');
      final result = jsonDecode(response.body);
      return null;

      //
    } catch (e) {
      log(e.toString(), name: 'API PLANT CLIENT ERROR');
    }
    return null;
  }

  ///
  ///
  static Future<ResponseModel> getPlant(int id) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/$id';
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
        log('Plant fetched successfully', name: 'API GET PLANT');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API GET PLANT ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(
        result,
        success: false,
      );

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //=====================================================================================================

  static Future<bool> uploadPlant(
      {required PlantModel plant, required List<FormImageModel> images}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      request.fields.addAll(plant.toCreatePlantJson());

      for (var image in images) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'images[]',
            image.bytes!,
            filename: image.name,
          ),
        );
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('plant uploaded successfully', name: 'API PLANT UPLOADED');

        //
        final result = jsonDecode(responseData);
        return true;
      }

      //
      log(response.statusCode.toString(), name: 'API ERROR PLANT UPLOAD');
      return false;
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT UPLOAD');
      return false;
    }
  }

  ////  ============================================================================================

  static Future<PlantTreatmentModel?> uploadTeatment(
      PlantTreatmentModel treatment) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/treatments';
    String? token = await SessionAccess.instance.getSessionToken();

    //
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: treatment.toCreateJson(),
      );

      //
      if (response.statusCode == 200) {
        log('Treatment uploaded successfully',
            name: 'API PLANT TREATMENT CREATE');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return PlantTreatmentModel.fromJson(result['data']);
      }

      log(
        '${response.statusCode}',
        name: 'API ERROR PLANT TREATMENT CREATE',
      );
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return null;

      //
    } catch (e) {
      log(
        e.toString(),
        name: 'API ERROR CLIENT PLANT TREATMENT CREATE',
      );
      return null;
    }
  }

  //==================================================================================================================================

  static Future<ResponseModel> updatePlant({required PlantModel plant}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/${plant.id}';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        // body: plant.toUpdatePlantJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Plant update successfully', name: 'API PLANT UPDATE');

        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR PLANT UPDATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR PLANT UPDATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR PLANT UPDATE');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////============================================================================================

  static Future<ResponseModel> updateStatus({required PlantModel plant}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/${plant.id}';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: plant.toUpdatePlantStatusJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Plant status update successfully',
            name: 'API PLANT STATUS UPDATE');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR PLANT STATUS UPDATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR PLANT STATUS UPDATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR PLANT STATUS UPDATE');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //============================================================================================

  static Future<ResponseModel> clearLocalNames(PlantModel plant) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/local_name/${plant.id}/clear';
    String? token = await SessionAccess.instance.getSessionToken();

    //
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Local names cleared successfully',
            name: 'API PLANT LOCAL NAME CLEARED');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(
        '${response.statusCode}',
        name: 'API ERROR PLANT LOCAL NAME CLEARED',
      );
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(
        e.toString(),
        name: 'API ERROR CLIENT PLANT LOCAL NAME CLEARED',
      );
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> clearImages(PlantModel plant) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/image/${plant.id}/clear';
    String? token = await SessionAccess.instance.getSessionToken();

    //
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Images cleared successfully', name: 'API PLANT IMAGE CLEARED');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR PLANT IMAGE CLEARED');
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR CLIENT PLANT IMAGE CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ===========================================================================================
  //! not yet changed

  static Future<ResponseModel> clearTreatments(int id) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/treatment/$id/clear';
    String? token = await SessionAccess.instance.getSessionToken();

    //
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Treatments cleared successfully',
            name: 'API PLANT TREATMENT CLEARED');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR PLANT TREATMENT CLEARED');
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR CLIENT PLANT TREATMENT CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }
}
