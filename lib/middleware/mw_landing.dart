import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/rt_routers.dart';

class LandingMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  LandingMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (route != '/' || route != '/landing') {
      return const RouteSettings(name: '/error');
    } else {
      return const RouteSettings(name: '/');
    }
  }
}
