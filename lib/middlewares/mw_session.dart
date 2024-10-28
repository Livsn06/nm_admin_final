import 'package:admin/global/gb_variables.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/rt_routers.dart';

class SessionMiddleware extends GetMiddleware {
  SessionMiddleware(int priority) : super(priority: priority);

  var checkSession = SessionAccess.instance.isActiveSession();

  @override
  RouteSettings? redirect(String? route) {
    checkSession.then((value) {
      SESSION.value = value;
      if (value) {
        Get.snackbar('Hello', 'Redirecting to dashboard...');
        Get.offAllNamed(CustomRoute.path.dashboard);
        return null;
      } else {
        return null;
      }
    });
    return null;
  }
}
