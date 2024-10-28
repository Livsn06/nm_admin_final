import 'package:admin/sessions/sn_access.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/rt_routers.dart';

class AuthMiddleware extends GetMiddleware {
  AuthMiddleware(int priority) : super(priority: priority);

  var checkSession = SessionAccess.instance.isActiveSession();

  @override
  RouteSettings? redirect(String? route) {
    checkSession.then((value) {
      print(value);
      if (!value && route == CustomRoute.path.dashboard) {
        Get.snackbar('Authentication', 'You need to login first!');
        Get.toNamed(CustomRoute.path.login, preventDuplicates: true);
        return null;
      }
    });
    return null;
  }
}
