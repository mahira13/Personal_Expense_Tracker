import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseEntity>> getExpensesList();
  Future<List<ExpenseEntity>> deleteExpense(String expenseId);
  Future<List<ExpenseEntity>> addExpense(ExpenseEntity expense);
}
