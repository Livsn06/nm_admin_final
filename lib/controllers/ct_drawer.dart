import 'package:admin/models/drawer/md_drawer.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawerController extends GetxController {
  Rx<List<DrawerModel>> drawerItems = Rx([
    DrawerModel(
      title: 'Dashboard',
      isActive: true,
      icon: Icons.dashboard,
      route: CustomRoute.path.dashboard,
    ),
    DrawerModel(
      title: 'Requests',
      isActive: false,
      icon: Icons.event_note,
      route: CustomRoute.path.requests,
    ),
    DrawerModel(
      title: 'Plants',
      isActive: false,
      icon: Icons.local_florist,
      route: CustomRoute.path.plants,
    ),
    DrawerModel(
      title: 'Users',
      isActive: false,
      icon: Icons.person_search,
      route: CustomRoute.path.users,
    ),
    DrawerModel(
      title: 'Settings',
      isActive: false,
      icon: Icons.settings,
      route: CustomRoute.path.settings,
    ),
  ]);

  selectActiveButton(String title) {
    drawerItems.value = drawerItems.value
        .map((item) => DrawerModel(
              title: item.title,
              isActive: item.title == title,
              icon: item.icon,
              route: item.route,
            ))
        .toList();
  }
}
