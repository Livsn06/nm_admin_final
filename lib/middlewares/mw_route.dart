import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/rt_routers.dart';

class RouteMiddleware extends GetMiddleware {
  RouteMiddleware(int priority) : super(priority: priority);

/*************  ✨ Codeium Command ⭐  *************/
  /// ****  d0582cf6-c8d1-433c-8308-ecf03b20680c  ******
  bool checkRoute(String route) {
    print(route);
    if (route == CustomRoute.path.root ||
        route == CustomRoute.path.landing ||
        route == CustomRoute.path.landing ||
        route == CustomRoute.path.signup ||
        route == CustomRoute.path.login ||
        route == CustomRoute.path.searchEmail ||
        route == CustomRoute.path.resetPassword ||
        route == CustomRoute.path.dashboard ||
        route == CustomRoute.path.plants ||
        route == CustomRoute.path.plantsTable ||
        route == CustomRoute.path.remediesTable ||
        route == CustomRoute.path.remediesCreate ||
        route == CustomRoute.path.requests ||
        route == CustomRoute.path.requestsTable ||
        route == CustomRoute.path.workplace ||
        route == CustomRoute.path.users ||
        route == CustomRoute.path.notification ||
        route == CustomRoute.path.settings ||
        route == CustomRoute.path.plantsCreate ||
        route == CustomRoute.path.myProfile) {
      return true;
    } else {
      return false;
    }
  }

  @override
  RouteSettings? redirect(String? route) {
    if (checkRoute(route ?? '')) {
      return null;
    } else {
      return const RouteSettings(name: '/error');
    }
  }
}
