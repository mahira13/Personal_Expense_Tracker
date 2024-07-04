import 'package:get/get.dart';
import 'package:personal_expense_tracker/domain/usecases/get_expenses_usecase.dart';
import 'package:personal_expense_tracker/presentation/controllers/home/home_screen_controller.dart';

import '../../data/repository/expense_repository_impl.dart';
import '../../domain/usecases/add_expense_usecase.dart';
import '../../domain/usecases/delete_expense_usecase.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetExpensesUsecase(
        expenseRepository: Get.find<ExpenseRepositoryImpl>()));
    Get.lazyPut(() => HomeScreenController(
        getExpensesUsecase: Get.find(), deleteExpenseUsecase: Get.find()));
    Get.lazyPut(() => DeleteExpenseUsecase(
        expenseRepository: Get.find<ExpenseRepositoryImpl>()));
    Get.lazyPut(() => AddExpenseUsecase(
        expenseRepository: Get.find<ExpenseRepositoryImpl>()));
  }
}
