import 'package:admin/screens/auth/sc_login.dart';
import 'package:admin/screens/auth/sc_signup.dart';
import 'package:admin/screens/dashboard/sc_dashboard.dart';
import 'package:admin/screens/error/sc_unknown.dart';
import 'package:admin/screens/notification/sc_notification.dart';
import 'package:admin/screens/plants/sc_plant.dart';
import 'package:admin/screens/requests/sc_request.dart';
import 'package:admin/screens/settings/sc_settings.dart';
import 'package:admin/screens/start/sc_landing.dart';
import 'package:admin/screens/users/sc_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/rt_routers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteSetting.root.name,
      getPages: AppRoute.all,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
    );
  }
}
