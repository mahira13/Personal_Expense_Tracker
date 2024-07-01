import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/models/expense_model.dart';
import 'package:personal_expense_tracker/services/database_service.dart';

import '../utils/app_colors.dart';

class HomeScreenController extends GetxController {
  var expenseList = List<Expense>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  //for chart
  var showingBarGroups=List<BarChartGroupData>.empty(growable: true).obs;
  final double width = 7;
  List<double> expFood = List.generate(7, (index) => 0);
  List<double> expTravel = List.generate(7, (index) => 0);
  List<double> expMisc = List.generate(7, (index) => 0);

  initCategoryLists() {
     if (expFood.isNotEmpty) {
      expFood.clear();
      expFood = List.generate(7, (index) => 0);
    }
     if (expTravel.isNotEmpty) {
     expTravel .clear();
      expTravel = List.generate(7, (index) => 0);
    }
     if (expMisc.isNotEmpty) {
      expMisc.clear();
      expMisc = List.generate(7, (index) => 0);
    }
    for (Expense transaction in expenseList
        .where((expense) => expense.category == Category.food)
        .toList()) {
      expFood[transaction.date.weekday - 1] += transaction.amount ?? 0.0;
    }
    for (Expense transaction in expenseList
        .where((expense) => expense.category == Category.travel)
        .toList()) {
      expTravel[transaction.date.weekday - 1] += transaction.amount ?? 0.0;
    }
    for (Expense transaction in expenseList
        .where((expense) => expense.category == Category.misc)
        .toList()) {
      expMisc[transaction.date.weekday - 1] += transaction.amount ?? 0.0;
    }

    final barGroup1 = makeGroupData(0, expFood[0], expTravel[0], expMisc[0]);
    final barGroup2 = makeGroupData(1, expFood[1], expTravel[1], expMisc[1]);
    final barGroup3 = makeGroupData(2, expFood[2], expTravel[2], expMisc[2]);
    final barGroup4 = makeGroupData(3, expFood[3], expTravel[3], expMisc[3]);
    final barGroup5 = makeGroupData(4, expFood[4], expTravel[4], expMisc[4]);
    final barGroup6 = makeGroupData(5, expFood[5], expTravel[5], expMisc[5]);
    final barGroup7 = makeGroupData(6, expFood[6], expTravel[6], expMisc[6]);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    showingBarGroups.value = items;
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: gradientColor3,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: gradientColor1,
          width: width,
        ),
        BarChartRodData(
          toY: y3,
          color: gradientColor5,
          width: width,
        ),
      ],
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    expenseList.value = await ExpenseRepository().loadTransactions();
    isLoading.value = false;
    if (expenseList.isNotEmpty) {
      initCategoryLists();
    }
  }
}
