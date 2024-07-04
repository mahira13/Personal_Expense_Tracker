import 'package:get/get.dart';

import 'package:personal_expense_tracker/presentation/controllers/add_expense/add_expense_controller.dart';

import '../../data/repository/expense_repository_impl.dart';
import '../../domain/usecases/add_expense_usecase.dart';

class AddExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewExpenseController(addExpenseUsecase: Get.find()));

    Get.lazyPut(() => AddExpenseUsecase(
        expenseRepository: Get.find<ExpenseRepositoryImpl>()));
  }
}
