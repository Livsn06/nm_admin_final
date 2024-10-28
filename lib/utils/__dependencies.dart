import 'package:admin/controllers/ct_drawer.dart';
import 'package:admin/controllers/ct_requestplant.dart';
import 'package:admin/controllers/ct_workplace.dart';
import 'package:get/get.dart';
import '../controllers/ct_landing.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    //CUSTOMS
    Get.lazyPut(() => CustomDrawerController());

    //FOR PAGES
    Get.lazyPut(() => LandingController());

    //FOR DATA
    Get.lazyPut(() => WorkplaceController());
    Get.lazyPut(() => RequestPlantController());
  }
}
