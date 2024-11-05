import 'package:admin/api/workplace/api_workplace.dart';
import 'package:admin/models/workplace/md_workplace.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WorkplaceController extends GetxController
    with DataSourceApi, GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    loadAllData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  late final TabController tabController;
  final RxList<WorkplaceModel> workplaceData = RxList<WorkplaceModel>([]);
  List<WorkplaceModel> get getInprogressStatus => filterByStatus("In Progress");
  List<WorkplaceModel> get getCompletedStatus => filterByStatus("Completed");

  //FUNCTIONS
  List<WorkplaceModel> filterByStatus(String status) {
    return workplaceData
        .where((workplace) =>
            workplace.status!.toLowerCase() == status.toLowerCase())
        .toList();
  }

  void loadAllData() async {
    workplaceData.value = await workplaceApiData() ?? [];
  }
}

mixin DataSourceApi {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  Future<List<WorkplaceModel>?> workplaceApiData() async {
    stateReset();

    isLoading.value = true;
    var value = await ApiWorkplace.fetchAllRequests();

    if (value == null) {
      isLoading.value = false;
      isError.value = true;
    } else {
      isLoading.value = false;
      isError.value = false;
    }
    return value;
  }

  void stateReset() {
    isLoading.value = false;
    isError.value = false;
  }
}
