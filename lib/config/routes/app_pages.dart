import 'package:get/get.dart';
import 'package:personal_expense_tracker/presentation/bindings/home_binding.dart';
import 'package:personal_expense_tracker/presentation/pages/add_expense/add_expense_screen.dart';
import 'package:personal_expense_tracker/presentation/pages/edit_expense/edit_expense_screen.dart';
import 'package:personal_expense_tracker/presentation/pages/home/home_screen.dart';
import 'package:personal_expense_tracker/presentation/pages/splash/splash_screen.dart';

import '../../presentation/bindings/add_expense_binding.dart';
import 'app_routes.dart';

class AppPages {
  static var routes = [
     GetPage(
      name: AppRoutes.INITIAL,
      page: () => SplashScreen(),
      //binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.ADDEXPENSE,
        page: () => AddNewExpenseScreen(),
        binding: AddExpenseBinding(),
        fullscreenDialog: true),
    GetPage(
        name: AppRoutes.EDITEXPENSE,
        page: () => EditExpenseScreen(),
        // binding: RosterFormBinding(),
        fullscreenDialog: true),
  ];
}
