import 'package:admin/models/request/md_request_plant.dart';
import 'package:get/get.dart';

RxList<RequestPlantModel> REQUESTS = RxList<RequestPlantModel>([]);
RxList<RequestPlantModel> ACCEPTED_REQUESTS = RxList<RequestPlantModel>([]);
Rx<RequestPlantModel> SELECTED_REQUESTS =
    Rx<RequestPlantModel>(RequestPlantModel());
