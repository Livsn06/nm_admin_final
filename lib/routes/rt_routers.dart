import 'package:admin/middlewares/mw_route.dart';
import 'package:admin/screens/auth/sc_forgot.dart';
import 'package:admin/screens/auth/sc_reset.dart';
import 'package:admin/screens/error/sc_unknown.dart';
import 'package:admin/screens/plants/sc_plant_create.dart';
import 'package:admin/screens/plants/sc_plant_table.dart';
import 'package:admin/screens/remedies/sc_remedy_create.dart';
import 'package:admin/screens/remedies/sc_remedy_table.dart';
import 'package:admin/screens/requests/sc_request_table.dart';
import 'package:admin/screens/settings/sc_setting_info.dart';
import 'package:admin/screens/settings/sc_settings.dart';
import 'package:admin/screens/start/sc_landing.dart';
import 'package:admin/screens/workplace/sc_workplace.dart';
import 'package:get/get.dart';

import '../middlewares/mw_auth.dart';
import '../middlewares/mw_session.dart';
import '../screens/auth/sc_login.dart';
import '../screens/auth/sc_signup.dart';
import '../screens/dashboard/sc_dashboard.dart';
import '../screens/notification/sc_notification.dart';
import '../screens/plants/sc_plant.dart';
import '../screens/requests/sc_request.dart';
import '../screens/users/sc_user_table.dart';

enum RouteSetting {
  root,
  landing,
  signup,
  resetPassword,
  searchEmail,
  login,
  dashboard,
  plants,
  plantTable,
  plantCreate,
  remedyTable,
  remedyCreate,
  requests,
  requestTable,
  workspace,
  users,
  notification,
  settings,
  myProfile;

  String get name {
    switch (this) {
      case root:
        return '/';
      case signup:
        return '/signup';
      case login:
        return '/login';
      case resetPassword:
        return '/resetPassword';
      case searchEmail:
        return '/searchEmail';
      case dashboard:
        return '/dashboard';
      case plants:
        return '/plants';
      case plantTable:
        return '/plantTable';
      case plantCreate:
        return '/plantCreate';
      case remedyTable:
        return '/remedyTable';
      case remedyCreate:
        return '/remedyCreate';
      case requests:
        return '/requests';
      case requestTable:
        return '/requestTable';
      case workspace:
        return '/workplace';
      case users:
        return '/users';
      case notification:
        return '/notifications';
      case settings:
        return '/settings';
      case myProfile:
        return '/myProfile';
      default:
        return '/error';
    }
  }
}

class CustomRoute {
  static final path = CustomRoute();

  String get root => '/';
  String get landing => '/landing';
  String get login => '/login';
  String get searchEmail => '/login/searchEmail';
  String get resetPassword => '/login/searchEmail/resetPassword';
  String get signup => '/signup';
  String get dashboard => '/dashboard';
  String get plants => '/dashboard/plants';
  String get plantsTable => '/dashboard/plants/plantTable';
  String get plantsCreate => '/dashboard/plants/plantTable/plantCreate';
  String get remediesTable => '/dashboard/plants/remedyTable';
  String get remediesCreate => '/dashboard/plants/remedyTable/remedyCreate';
  String get requests => '/dashboard/requests';
  String get requestsTable => '/dashboard/requests/requestTable';
  String get workplace => '/dashboard/requests/workplace';
  String get users => '/dashboard/users';
  String get notification => '/dashboard/notifications';
  String get settings => '/dashboard/settings';
  String get myProfile => '/dashboard/settings/myProfile';
  String get unknown => '/error';
}

class AppRoute {
  static List<GetPage> all = [
    //AUTH PAGES
    GetPage(
      name: RouteSetting.root.name,
      page: () => LandingScreen(),
      preventDuplicates: true,
      middlewares: [
        RouteMiddleware(5),
        SessionMiddleware(5),
      ],
      children: [
        GetPage(
          name: RouteSetting.signup.name,
          page: () => SignupScreen(),
          middlewares: [
            RouteMiddleware(5),
            SessionMiddleware(5),
          ],
        ),
        GetPage(
          name: RouteSetting.login.name,
          page: () => LoginScreen(),
          children: [
            GetPage(
                name: RouteSetting.searchEmail.name,
                page: () => ForgotPasswordScreen(),
                middlewares: [
                  RouteMiddleware(5),
                  SessionMiddleware(5),
                ],
                children: [
                  GetPage(
                    name: RouteSetting.resetPassword.name,
                    page: () => ResetPasswordScreen(),
                  ),
                ]),
          ],
        ),
      ],
    ),

    //HOMEPAGES
    GetPage(
      name: RouteSetting.dashboard.name,
      page: () => DashboardScreen(),
      preventDuplicates: true,
      middlewares: [
        RouteMiddleware(5),
        AuthMiddleware(10),
      ],
      children: <GetPage>[
        //
        //PLANTPAGES
        GetPage(
            name: RouteSetting.plants.name,
            page: () => const PlantScreen(),
            preventDuplicates: true,
            children: <GetPage>[
              GetPage(
                name: RouteSetting.plantTable.name,
                page: () => const PlantTableScreen(),
                preventDuplicates: true,
                children: [
                  GetPage(
                    name: RouteSetting.plantCreate.name,
                    page: () => PlantCreateScreen(),
                    preventDuplicates: true,
                  ),
                ],
              ),
              GetPage(
                  name: RouteSetting.remedyTable.name,
                  page: () => RemedyTableScreen(),
                  preventDuplicates: true,
                  children: [
                    GetPage(
                      name: RouteSetting.remedyCreate.name,
                      page: () => RemedyCreateScreen(),
                      preventDuplicates: true,
                    ),
                  ]),
            ]),

        //REQUESTPAGES
        GetPage(
            name: RouteSetting.requests.name,
            page: () => const RequestScreen(),
            preventDuplicates: true,
            children: <GetPage>[
              GetPage(
                name: RouteSetting.workspace.name,
                page: () => WorkplaceScreen(),
                preventDuplicates: true,
              ),
              GetPage(
                name: RouteSetting.requestTable.name,
                page: () => RequestTableScreen(),
                preventDuplicates: true,
              ),
            ]),

        //USERPAGES
        GetPage(
          name: RouteSetting.users.name,
          page: () => const UserTableScreen(),
        ),

        //NOTIFICATIONPAGES
        GetPage(
          name: RouteSetting.notification.name,
          page: () => const NotificationScreen(),
        ),

        //SETTINGPAGES
        GetPage(
          name: RouteSetting.settings.name,
          page: () => const SettingScreen(),
          preventDuplicates: true,
          children: [
            GetPage(
              name: RouteSetting.myProfile.name,
              page: () => const MyProfileScreen(),
              preventDuplicates: true,
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: '/error',
      page: () => const UnknownScreen(),
    ),
  ];
}
