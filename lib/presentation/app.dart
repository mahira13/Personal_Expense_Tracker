import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/routes/app_pages.dart';
import '../config/routes/app_routes.dart';
import '../config/themes/app_theme.dart';
import '../utils/constants/app_strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: AppTheme.light,
      initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.routes,
    );
  }
}