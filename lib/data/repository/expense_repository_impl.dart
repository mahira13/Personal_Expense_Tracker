import 'package:personal_expense_tracker/data/data_sources/database_service.dart';
import 'package:personal_expense_tracker/data/models/expense_model.dart';
import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';
import 'package:personal_expense_tracker/domain/repository/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
   final DatabaseService databaseService=DatabaseService();
  // ExpenseRepositoryImpl({required this.databaseService});
  @override
  Future<List<ExpenseModel>> getExpensesList() async {
    final response = await databaseService.loadTransactions();
    return response;
  }
   @override
  Future<List<ExpenseModel>> deleteExpense(String expenseId) async {
    final response = await databaseService.removeTransaction(expenseId:expenseId );
    return response;
  }
   @override
  Future<List<ExpenseModel>> addExpense(ExpenseEntity expense) async {
    final response = await databaseService.addTransaction(addT:ExpenseModel.fromEntity(expense)  );
    return response;
  }
}
