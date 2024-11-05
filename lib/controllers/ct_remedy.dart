import 'package:admin/api/remedy/api_remedy.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/remedies/md_remedy.dart';
import 'package:get/get.dart';

import '../api/plant/api_plant.dart';

class RemedyController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  final RxList<RemedyModel> remedyData = RxList<RemedyModel>([]);
  final RxList<RemedyModel> remedyActiveData = RxList<RemedyModel>([]);

  //FUNCTIONS
  List<RemedyModel> filterByStatus(String status) {
    return remedyData.value
        .where((remedy) => remedy.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  void loadAllData() async {
    remedyData.value = await plantApiData() ?? [];
    remedyActiveData.value = filterByStatus('Active');
  }
}

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<List<RemedyModel>?> plantApiData() async {
    stateReset();

    //
    isLoading.value = true;
    var value = await ApiRemedy.fetchAllRemedy();

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }

    return value;
  }

  Future<PlantModel> getApiDataById(int id) async {
    stateReset();

    isLoading.value = true;

    var value = await ApiPlant.getPlants(id);

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }

    return value!;
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
