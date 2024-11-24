import 'dart:convert';
import 'dart:developer';
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
import '../../models/form/md_form_image.dart';

class ApiRemedy {
  //
  static Future<ResponseModel> fetchAllRemedies() async {
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

        log('Remedies fetched successfully', name: 'API Remedies');
        return ResponseModel.dataListFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API Remedies ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API Remedies CLIENT ERROR');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ///
  ///
  static Future<ResponseModel> getRemedy(int id) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/$id';
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
        log('Remedy fetched successfully', name: 'API GET REMEDY');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API GET REMEDY ERROR');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(
        result,
        success: false,
      );

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR GET REMEDY');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //=====================================================================================================

  static Future<ResponseModel> uploadRemedy(
      {required RemedyModel remedy}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: remedy.toCreateRemedyJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('remedy created successfully', name: 'API REMEDY CREATE');

        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR REMEDY CREATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR REMEDY CREATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR REMEDY CREATE');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadTeatment(
      {required RemedyTreatmentModel treatment}) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/treatment';
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
            name: 'API REMEDY TREATMENT CREATE');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(
        '${response.statusCode}',
        name: 'API ERROR REMEDY TREATMENT CREATE',
      );
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(
        e.toString(),
        name: 'API ERROR CLIENT REMEDY TREATMENT CREATE',
      );
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadCover(
      RemedyModel remedy, FormImageModel image) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/${remedy.id}/cover';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token'
      });

      request.fields.addAll({
        'name': remedy.name!,
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
        log('Cover uploaded successfully', name: 'API REMEDY COVER UPLOAD');
        final result = jsonDecode(responseData);
        return ResponseModel.dataFromJson(result, success: true);
      }
      log(response.statusCode.toString(),
          name: 'API ERROR REMEDY COVER UPLOAD');

      final result = jsonDecode(responseData);
      return ResponseModel.errorFromJson(result, success: false);
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY COVER UPLOAD');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadImage(
      RemedyModel remedy, FormImageModel image) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/image';
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
        'name': remedy.name!,
        'remedy_id': remedy.id.toString(),
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
        log('Image uploaded successfully', name: 'API REMEDY IMAGE UPLOAD');
        final result = jsonDecode(responseData);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log(response.statusCode.toString(), name: 'API ERROR PLANT IMAGE UPLOAD');
      final result = jsonDecode(responseData);
      return ResponseModel.errorFromJson(result, success: false);
      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY IMAGE UPLOAD', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadStep({required StepModel step}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/step';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: step.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Step uploaded successfully', name: 'API REMEDY STEP UPLOAD');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY STEP UPLOAD');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY STEP UPLOAD', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ============================================================================================

  static Future<ResponseModel> uploadIngredient(
      {required IngredientModel ingredient}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/ingredient';
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
            name: 'API REMEDY INGREDIENT UPLOAD');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY INGREDIENT UPLOAD');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY INGREDIENT UPLOAD', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////==================================================================================================================================

  ///
  static Future<ResponseModel> uploadUsage({required UsageModel usage}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/usage';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: usage.toJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Usage uploaded successfully', name: 'API REMEDY USAGE UPLOAD');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY USAGE UPLOAD');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY USAGE UPLOAD', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////====================================================================================================================================
  static Future<ResponseModel> deleteRemedy({required int id}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/$id';
    String? token = await SessionAccess.instance.getSessionToken();

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
        log('Remedy deleted successfully', name: 'API REMEDY DELETE');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY DELETE');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(': CLIENT ERROR', name: 'API REMEDY DELETE', error: e);
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //==================================================================================================================================

  static Future<ResponseModel> updateRemedy(
      {required RemedyModel remedy}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/${remedy.id}';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: remedy.toUpdateRemedyJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('REMEDY update successfully', name: 'API REMEDY UPDATE');

        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR REMEDY UPDATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR REMEDY UPDATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR',
          name: 'API CLIENT ERROR REMEDY UPDATE ${e.toString()}');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////============================================================================================

  Future<ResponseModel> updateStatus({required RemedyModel remedy}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/${remedy.id}';
    String? token = await SessionAccess.instance.getSessionToken();

    try {
      var response = await http.patch(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
          'Authorization': 'Bearer $token'
        },
        body: remedy.toUpdateStatusJson(),
      );

      //
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Plant status update successfully',
            name: 'API remedy STATUS UPDATE');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      // Log errors
      log('${response.statusCode}', name: 'API ERROR REMEDY STATUS UPDATE');
      final result = jsonDecode(response.body);
      log(result['message'], name: 'API ERROR REMEDY STATUS UPDATE');
      return ResponseModel.errorFromJson(result, success: false);
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR REMEDY STATUS UPDATE');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////============================================================================================

  static Future<ResponseModel> clearIngredient({required int remedyID}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/ingredient/$remedyID/clear';
    String? token = await SessionAccess.instance.getSessionToken();

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
        log('Ingredient cleared successfully',
            name: 'API REMEDY INGREDIENT CLEARED');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}',
          name: 'API ERROR REMEDY INGREDIENT CLEARED');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR REMEDY INGREDIENT CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////===========================================================================================
  static Future<ResponseModel> clearSteps({required int remedyId}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/step/$remedyId/clear';
    String? token = await SessionAccess.instance.getSessionToken();

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
        log('Step cleared successfully', name: 'API REMEDY STEP CLEARED');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY STEP CLEARED');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR REMEDY STEP CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  /////========================================================================================

  static Future<ResponseModel> clearUsages({required int remedyId}) async {
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/usage/$remedyId/clear';
    String? token = await SessionAccess.instance.getSessionToken();

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
        log('Usage cleared successfully', name: 'API REMEDY USAGE CLEARED');
        final result = jsonDecode(response.body);
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY USAGE CLEARED');
      final result = jsonDecode(response.body);
      return ResponseModel.errorFromJson(result, success: false);

      //  //
    } catch (e) {
      log('CLIENT ERROR', name: 'API CLIENT ERROR REMEDY USAGE CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  //============================================================================================

  static Future<ResponseModel> clearImages(
      {required RemedyModel remedy}) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/image/${remedy.id}/clear';
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
        log('Images cleared successfully', name: 'API remedy IMAGE CLEARED');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR remedy IMAGE CLEARED');
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR CLIENT remedy IMAGE CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }

  ////  ===========================================================================================

  static Future<ResponseModel> clearTreatments({required int id}) async {
    //
    String base = API_BASE.value;
    String url = '$base/api/v1/remedies/treatment/$id/clear';
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
            name: 'API Remedy TREATMENT CLEARED');
        final result = jsonDecode(response.body);
        print('${result['message']}');
        return ResponseModel.dataFromJson(result, success: true);
      }

      log('${response.statusCode}', name: 'API ERROR REMEDY TREATMENT CLEARED');
      final result = jsonDecode(response.body);
      print('${result['message']}');
      return ResponseModel.errorFromJson(result, success: false);

      //
    } catch (e) {
      log(e.toString(), name: 'API ERROR CLIENT REMEDY TREATMENT CLEARED');
      return ResponseModel.clientErrorFromJson(
        message: 'Cannot connect to server',
        success: false,
      );
    }
  }
}
