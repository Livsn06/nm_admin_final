import 'dart:convert';

import 'package:admin/models/plant/md_plant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/plant/api_plant.dart';

class SessionPlant {
  static const _prefsKey_Edit = 'edit_plant';

  static Future<void> addEditPlant(PlantModel plant) async {
    removeEditPlant();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    await prefs.setInt(_prefsKey_Edit, plant.id!);
  }

  //

  static Future<PlantModel?> getEditPlant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    int? id = prefs.getInt(_prefsKey_Edit);

    if (id != null) {
      var response = await ApiPlant.getPlant(id);

      if (response.success == false ||
          response.errors != null ||
          response.data == null ||
          response.clientError == true) {
        Get.showSnackbar(const GetSnackBar(message: 'Failed to open plant'));
        return null;
      }

      var plant = PlantModel.fromJson(response.data!);
      print('Plant id:${plant.id}');
      return plant;
    }
    return null;
  }

  static void removeEditPlant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey_Edit);
  }
}
