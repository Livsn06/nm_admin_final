import 'package:admin/controllers/ct_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customDrawer() {
  var drawer = Get.put(CustomDrawerController());
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(),
          child: Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Nature',
                    style: TextStyle(
                      color: Color(0xFF007E62),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: ' Medix',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ...drawer.drawerItems.value.map((item) {
          return ListTile(
            onTap: () {
              drawer.selectActiveButton(item.title);
              Get.toNamed(item.route, preventDuplicates: true);
            },
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              item.icon,
              color: item.isActive ? Colors.white : Colors.black,
            ),
            textColor: item.isActive ? Colors.white : Colors.black,
            tileColor: item.isActive ? const Color(0xFF007E62) : null,
            title: Text(item.title),
          );
        }),
      ],
    ),
  );
}
