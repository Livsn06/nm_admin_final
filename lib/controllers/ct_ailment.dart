import 'package:admin/api/ailments/api_ailment.dart';
import 'package:admin/models/ailments/md_ailment.dart';
import 'package:get/get.dart';

class AilmentController extends GetxController with DataSourceApi {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  final RxList<AilmentModel> data = RxList<AilmentModel>([]);

  //FUNCTIONS
  // List<PlantModel> filterByStatus(String status) {
  //   return data.value
  //       .where((plant) => data.status!.toLowerCase() == status.toLowerCase())
  //       .toList();
  // }

  // List<PlantModel> filterByPlantName(String name) {
  //   if (name.trim().isEmpty) return plantBackupData.value;

  //   return plantBackupData.value
  //       .where((plant) =>
  //           plant.name!.trim().isCaseInsensitiveContains(name.trim()))
  //       .toList();
  // }

  void loadData() async {
    data.value = await apiData() ?? [];
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

  Future<List<AilmentModel>?> apiData() async {
    stateReset();

    //
    isLoading.value = true;
    var response = await AilmentApi.fetchAllAilment();

    if (response != null) {
      isLoading.value = false;
      isError.value = false;
      return response;
    } else {
      isLoading.value = false;
      isError.value = true;
      return null;
    }
  }

  // Future<PlantModel?> getApiDataById(int id) async {
  //   stateReset();

  //   isLoading.value = true;

  //   var response = await ApiPlant.getPlant(id);

  //   if (response.success && response.data != null) {
  //     isLoading.value = false;
  //     isError.value = false;
  //     return PlantModel.fromJson(response.data!);
  //   } else {
  //     isLoading.value = false;
  //     isError.value = true;
  //     return null;
  //   }
  // }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
