import 'dart:io';

import 'package:flutter/material.dart';
import 'presentation/app.dart';
import 'utils/services/notification_service.dart';
import 'utils/dependency.dart';

void main() async {
   DependencyCreator.init();
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


