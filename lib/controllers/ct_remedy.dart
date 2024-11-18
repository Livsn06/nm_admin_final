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
    var response = await ApiRemedy.fetchAllRemedy();

    if (response.success && response.dataList != null) {
      isLoading.value = false;
      isError.value = false;
      return RemedyModel.fromJsonList(response.dataList!);
    } else {
      isLoading.value = false;
      isError.value = true;
      return null;
    }
  }

  Future<PlantModel?> getApiDataById(int id) async {
    stateReset();

    isLoading.value = true;

    var response = await ApiPlant.getPlant(id);

    if (response.success && response.data != null) {
      isLoading.value = false;
      isError.value = false;
      return PlantModel.fromJson(response.data!);
    } else {
      isLoading.value = false;
      isError.value = true;
      return null;
    }
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
