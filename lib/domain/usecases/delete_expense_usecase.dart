import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';
import 'package:personal_expense_tracker/domain/repository/expense_repository.dart';
import 'package:personal_expense_tracker/utils/usecase/usecase.dart';

class DeleteExpenseUsecase implements UseCase<List<ExpenseEntity>, String>{
  final ExpenseRepository expenseRepository;
  DeleteExpenseUsecase({required this.expenseRepository});
  @override
  Future<List<ExpenseEntity>> call({ String? params}) {
    return expenseRepository.deleteExpense(params!);
  }

}