import 'package:admin/data/dummy/dt_dummy_data.dart';
import 'package:admin/models/workplace/md_workplace.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WorkplaceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    // setWorkplaceData = dummyData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  late final TabController tabController;
  final RxList<WorkplaceModel> _data = RxList<WorkplaceModel>([]);
  final RxList<WorkplaceModel> _inprogressStatus = RxList<WorkplaceModel>([]);

  //SETTERS
  List<WorkplaceModel> get getWorkplaceData => _data.value;

  set setWorkplaceData(List<WorkplaceModel> value) {
    _data.value = value;
  }

  //FUNCTIONS
  List<WorkplaceModel> filterByStatus(String status) {
    return _data
        .where((workplace) =>
            workplace.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }
}

// mixin _DummyDataSource {
//   List<WorkplaceModel> dummyData() {
//     return WORKPLACE_DUMMY_DATA;
//   }
// }
