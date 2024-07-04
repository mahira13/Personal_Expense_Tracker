import 'package:get/get.dart';

import '../data/repository/expense_repository_impl.dart';

class DependencyCreator {
  static init() {
   
    Get.lazyPut(() => ExpenseRepositoryImpl());
  }
}