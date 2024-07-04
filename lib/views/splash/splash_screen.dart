import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/controllers/splash_controller.dart';
import 'package:personal_expense_tracker/utils/app_strings.dart';

import '../../utils/common_widgets.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
        body: gradientContainer( Center(
            child: Padding(
      padding:const EdgeInsets.all(48.0),
      child: Text(appTitle,  style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
    ))));
  }
}
