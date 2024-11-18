import 'dart:convert';
import 'dart:developer';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/plant/md_plant_local_name.dart';
import 'package:admin/models/plant/md_plant_treatment.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../global/gb_variables.dart';

class ApiPlant {
  //
  static Future<ResponseModel> fetchAllPlants() async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants';
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
        return ResponseModel.dataListFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API PLANT ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API PLANT CLIENT ERROR');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
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

  static Future<ResponseModel> uploadPlant({required PlantModel plant}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: plant.toCreatePlantJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Plant created successfully', name: 'API PLANT CREATE');

        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR PLANT CREATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR PLANT CREATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR PLANT CREATE');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadTeatment(
      PlantTreatmentModel treatment) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/treatment';
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
        body: treatment.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Treatment uploaded successfully',
            name: 'API PLANT TREATMENT CREATE');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(
        '${response.statusCode}',
        name: 'API ERROR PLANT TREATMENT CREATE',
      );
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(
        e.toString(),
        name: 'API ERROR CLIENT PLANT TREATMENT CREATE',
      );
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadLocalName(
      PlantLocalNameModel localName) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/local_name';
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
        body: localName.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Local name uploaded successfully',
            name: 'API PLANT LOCAL NAME CREATE');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(
        '${response.statusCode}',
        name: 'API ERROR PLANT LOCAL NAME CREATE',
      );
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(
        e.toString(),
        name: 'API ERROR CLIENT PLANT LOCAL NAME CREATE',
      );
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadCover(
      PlantModel plant, FormImageModel image) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/${plant.id}/cover';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      request.fields.addAll({
        'name': plant.name!,
      });
      request.files.add(
        http.MultipartFile.fromBytes(
          'cover',
          image.bytes!,
          filename: image.name,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Cover uploaded successfully', name: 'API PLANT COVER UPLOAD');
        final result = jsonDecode(responseData);
        return ResponseModel.dataFromJson(result, success: true);
      }
      log(response.statusCode.toString(), name: 'API ERROR PLANT COVER UPLOAD');
      final result = jsonDecode(responseData);
      return ResponseModel.errorFromJson(result, success: false);
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT COVER UPLOAD');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadImage(
      PlantModel plant, FormImageModel image) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/plants/image';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      //
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      request.fields.addAll({
        'name': plant.name!,
        'plant_id': plant.id.toString(),
      });

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image.bytes!,
          filename: image.name,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Image uploaded successfully', name: 'API PLANT IMAGE UPLOAD');
        final result = jsonDecode(responseData);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API ERROR PLANT IMAGE UPLOAD');
      final result = jsonDecode(responseData);
      return ResponseModel.errorFromJson(result, success: false);
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API PLANT IMAGE UPLOAD', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
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
        body: plant.toUpdatePlantJson(),
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
