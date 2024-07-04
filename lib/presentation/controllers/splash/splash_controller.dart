import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/config/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offAndToNamed(AppRoutes.HOME);
    });
  }
}
