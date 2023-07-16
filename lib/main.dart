import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/bindings/app_binding.dart';
import 'app/core/config/app_ui.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    title: 'Mots',
    initialRoute: AppPages.initial,
    theme: AppUi.theme,
    initialBinding: AppBinding(),
    getPages: AppPages.routes,
    // theme: ThemeData(primarySwatch: Colors.pink),
    debugShowCheckedModeBanner: false,
  ));
}
