import 'package:admin/models/request/md_request_plant.dart';
import 'package:get/get.dart';

class RequestPlantController extends GetxController {
  final RxList<RequestPlantModel> _data = RxList<RequestPlantModel>([]);
  final RxList<RequestPlantModel> _pendingStatus =
      RxList<RequestPlantModel>([]);

  //SETTERS
  List<RequestPlantModel> get getRequestPlantData => _data.value;
  List<RequestPlantModel> get getPendingStatus => filterByStatus("Pending");

  set setRequestPlantData(List<RequestPlantModel> value) {
    _data.value = value;
  }

  //FUNCTIONS
  List<RequestPlantModel> filterByStatus(String status) {
    return _data
        .where(
            (request) => request.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }
}

// mixin DummyDataSource {
//   List<RequestPlantModel> dummyData() {
//     return REQUEST_DUMMY_DATA;
//   }
// }
