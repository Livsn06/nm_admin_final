import 'package:admin/global/gb_variables.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'utils/__dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  initEnv();
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
      initialBinding: InitBinding(),
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
    );
  }
}
