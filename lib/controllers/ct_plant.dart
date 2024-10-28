import 'package:admin/data/dummy/dt_dummy_data.dart';
import 'package:admin/models/plants/md_plant.dart';
import 'package:get/get.dart';

class PlantController extends GetxController with DummyDataSource {
  @override
  void onInit() {
    super.onInit();
    setPlantData = dummyData();
  }

  final RxList<PlantsModel> _data = RxList<PlantsModel>([]);

  //SETTERS
  List<PlantsModel> get getPlantData => _data.value;

  set setPlantData(List<PlantsModel> value) {
    _data.value = value;
  }

  //FUNCTIONS
}

mixin DummyDataSource {
  List<PlantsModel> dummyData() {
    return PLANTS_DUMMY_DATA;
  }
}
