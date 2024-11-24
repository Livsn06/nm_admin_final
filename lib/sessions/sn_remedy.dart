import 'dart:convert';

import 'package:admin/api/remedy/api_remedy.dart';
import 'package:admin/models/remedies/md_remedy.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRemedy {
  static const _prefsKey_Edit = 'edit_remedy';

  static Future<void> addEditRemedy(RemedyModel remedy) async {
    removeEditRemedy();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    await prefs.setInt(_prefsKey_Edit, remedy.id!);
  }

  //

  static Future<RemedyModel?> getEditRemedy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    int? id = prefs.getInt(_prefsKey_Edit);

    if (id != null) {
      var response = await ApiRemedy.getRemedy(id);

      if (response.success == false ||
          response.errors != null ||
          response.data == null ||
          response.clientError == true) {
        Get.showSnackbar(const GetSnackBar(message: 'Failed to open plant'));
        return null;
      }

      var remedy = RemedyModel.fromJsonWithPlant(response.data!);
      print('Remedy id:${remedy.id}');
      return remedy;
    }
    return null;
  }

  static void removeEditRemedy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey_Edit);
  }
}
