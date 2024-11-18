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
      if (!value &&
          ![
            RouteSetting.login.name,
            RouteSetting.root.name,
            RouteSetting.landing.name,
            RouteSetting.signup.name,
          ].contains(route)) {
        Get.snackbar('Authentication', 'You need to login first!');
        Get.toNamed(CustomRoute.path.login, preventDuplicates: true);
        return null;
      }
    });
    return null;
  }
}
