import 'package:flutter/material.dart';

class DrawerModel {
  String title;
  bool isActive;
  IconData icon;
  String route;
  DrawerModel({
    required this.title,
    required this.icon,
    required this.isActive,
    required this.route,
  });
}
