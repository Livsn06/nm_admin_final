import 'package:admin/middleware/mw_landing.dart';
import 'package:admin/screens/error/sc_unknown.dart';
import 'package:admin/screens/start/sc_landing.dart';
import 'package:get/get.dart';

import '../screens/auth/sc_login.dart';
import '../screens/auth/sc_signup.dart';
import '../screens/dashboard/sc_dashboard.dart';
import '../screens/notification/sc_notification.dart';
import '../screens/plants/sc_plant.dart';
import '../screens/requests/sc_request.dart';
import '../screens/users/sc_user.dart';

enum RouteSetting {
  root,
  landing,
  signup,
  login,
  dashboard,
  plants,
  requests,
  users,
  notification,
  settings;

  String get name {
    switch (this) {
      case root:
        return '/';
      case signup:
        return '/signup';
      case login:
        return '/login';
      case dashboard:
        return '/dashboard';
      case plants:
        return '/plants';
      case requests:
        return '/requests';
      case users:
        return '/users';
      case notification:
        return '/notification';
      case settings:
        return '/settings';
      default:
        return '/error';
    }
  }
}

class AppRoute {
  static List<GetPage> all = [
    GetPage(
      name: RouteSetting.root.name,
      page: () => LandingScreen(),
      children: [
        GetPage(
          name: RouteSetting.signup.name,
          page: () => SignupScreen(),
        ),
        GetPage(
          name: RouteSetting.login.name,
          page: () => LoginScreen(),
        ),
      ],
    ),
    GetPage(
      name: RouteSetting.dashboard.name,
      page: () => const DashboardScreen(),
      children: <GetPage>[
        GetPage(
          name: RouteSetting.dashboard.name,
          page: () => const DashboardScreen(),
          preventDuplicates: true,
        ),
        GetPage(
          name: RouteSetting.plants.name,
          page: () => const PlantScreen(),
          preventDuplicates: true,
        ),
        GetPage(
          name: RouteSetting.requests.name,
          page: () => const RequestScreen(),
        ),
        GetPage(
          name: RouteSetting.users.name,
          page: () => const UserScreen(),
        ),
        GetPage(
          name: RouteSetting.notification.name,
          page: () => const NotificationScreen(),
        ),
      ],
    ),
    GetPage(
      name: '/error',
      page: () => const UnknownScreen(),
    ),
  ];
}
