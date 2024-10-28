import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
  context, {
  required String title,
  bool? isPrimary,
  Function()? onBackTap,
  List<Widget>? actions,
}) {
  return AppBar(
    primary: isPrimary ?? false,
    toolbarHeight: 60,
    elevation: 2,
    backgroundColor: const Color(0xFF007E62),
    foregroundColor: Colors.white,
    automaticallyImplyLeading: false,
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    leading: isPrimary ?? false
        ? null
        : IconButton(
            onPressed: onBackTap,
            icon: const Icon(Icons.arrow_back),
          ),
    title: Text(title),
    actions: actions ?? [],
  );
}
