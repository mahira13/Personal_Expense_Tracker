import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/utils/app_strings.dart';


import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/notification_service.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(const MyApp());
}

Future<void> initNotifications() async {
  NotificationService notificationService = NotificationService();
  await notificationService.initializeNotification();
  if (Platform.isIOS) {
    notificationService.requestIOSPermissions();
  } else {
    notificationService.requestAndroidPermission();
  }
  notificationService.scheduledNotification(
      hour: 18, minutes: 30, id: UniqueKey().hashCode); // at 6:30 pm it will trigger reminder
}

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
