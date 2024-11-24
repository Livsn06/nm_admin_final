import 'package:admin/models/plant/md_plant.dart';
import 'package:get/get.dart';

import '../api/plant/api_plant.dart';

class PlantController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    super.onInit();
    loadPlantData();
  }

  final RxList<PlantModel> plantData = RxList<PlantModel>([]);
  final RxList<PlantModel> plantBackupData = RxList<PlantModel>([]);
  final RxList<PlantModel> plantActive = RxList<PlantModel>([]);

  //FUNCTIONS
  List<PlantModel> filterByStatus(String status) {
    return plantData.value
        .where((plant) => plant.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  List<PlantModel> filterByPlantName(String name) {
    if (name.trim().isEmpty) return plantBackupData.value;

    return plantBackupData.value
        .where((plant) =>
            plant.name!.trim().isCaseInsensitiveContains(name.trim()))
        .toList();
  }

  void loadPlantData() async {
    plantBackupData.value = plantData.value = await plantApiData() ?? [];
    plantActive.value = filterByStatus('Active');
  }
}

// mixin DummyDataSource {
//   List<PlantModel> dummyData() {
//     return PLANTS_DUMMY_DATA;
//   }
// }

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future<List<PlantModel>?> plantApiData() async {
    stateReset();

    //
    isLoading.value = true;
    var response = await ApiPlant.fetchAllPlants();

    if (response.success && response.dataList != null) {
      isLoading.value = false;
      isError.value = false;
      return PlantModel.listFromJson(response.dataList!);
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
