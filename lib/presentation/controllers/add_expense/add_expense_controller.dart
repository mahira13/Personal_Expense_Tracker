import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/expense_model.dart';
import '../../../data/data_sources/database_service.dart';
import '../../../domain/usecases/add_expense_usecase.dart';
import '../../../utils/constants/app_constants.dart';
import '../home/home_screen_controller.dart';

class AddNewExpenseController extends GetxController {
  AddExpenseUsecase addExpenseUsecase;
  AddNewExpenseController({required this.addExpenseUsecase});
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final titleFocus = FocusNode();
  final amountFocus = FocusNode();
  final dateFocus = FocusNode();

  DateTime _selectedDate = DateTime.now();
  var selectedCategory = "misc".obs;
  Future<Null> selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(1900, 1),
        lastDate: today,
        builder: (BuildContext? context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffE84C28),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != _selectedDate) {
      // setState(() {
      _selectedDate = pickedDate;
      dateController.value =
          TextEditingValue(text: DateFormat('d/M/y').format(pickedDate));
      //});
    }
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void onSubmit() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final txnTitle = titleController.text;
      final txnAmount = double.parse(amountController.text);
      final txnDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );

      _addNewTransaction(
        txnTitle,
        txnAmount,
        txnDateTime,
      );
      Get.back();
    }
  }

  Future<void> _addNewTransaction(
      String title, double amount, DateTime chosenDate) async {
    final newTxn = ExpenseModel(
      id: uuid.v4(),
      amount: amount,
      title: title,
      category: selectedCategory.value == "food"
          ? Category.food
          : selectedCategory.value == "travel"
              ? Category.travel
              : Category.misc,
      date: chosenDate,
    );
    HomeScreenController homeController = Get.find();
    homeController.expenseListMain.value =
        await addExpenseUsecase(params: newTxn);
    // await DatabaseService().addTransaction(addT: newTxn);
    homeController.resetFilter();
    homeController.initCategoryLists();
  }
}
