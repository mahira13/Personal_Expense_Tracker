import 'package:get/get.dart';
import 'package:personal_expense_tracker/views/add_expense_screen.dart';
import 'package:personal_expense_tracker/views/edit_expense_screen.dart';
import 'package:personal_expense_tracker/views/home/home_screen.dart';

import 'app_routes.dart';

class AppPages {
  static var routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => HomeScreen(),
      //binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.ADDEXPENSE,
        page: () => AddNewExpenseScreen(),
        // binding: RosterFormBinding(),
        fullscreenDialog: true),
    GetPage(
        name: AppRoutes.EDITEXPENSE,
        page: () => EditExpenseScreen(),
        // binding: RosterFormBinding(),
        fullscreenDialog: true),
  ];
}
