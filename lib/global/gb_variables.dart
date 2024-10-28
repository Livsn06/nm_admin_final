import 'dart:developer';

import 'package:admin/main.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Rx<String> API_BASE = ''.obs;
Rx<String> API_VERSION = ''.obs;
Rx<bool> SESSION = false.obs;

void initEnv() {
  API_BASE.value = dotenv.env['API_BASE'] ?? 'http://localhost:8000';
  API_VERSION.value = dotenv.env['API_VERSION'] ?? 'v1';
  //

  log('API_BASE: ${API_BASE.value}', name: 'ENV');
  log('API_VERSION: ${API_VERSION.value}', name: 'ENV');
}

Future<bool> initSession() async {
  bool isActive = await SessionAccess.instance.isActiveSession();
  log('Active Session: $isActive', name: 'SESSION');
  return isActive;
}
