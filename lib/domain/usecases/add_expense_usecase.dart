import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';
import 'package:personal_expense_tracker/domain/repository/expense_repository.dart';
import 'package:personal_expense_tracker/utils/usecase/usecase.dart';

class AddExpenseUsecase implements UseCase<List<ExpenseEntity>, ExpenseEntity>{
  final ExpenseRepository expenseRepository;
  AddExpenseUsecase({required this.expenseRepository});
  @override
  Future<List<ExpenseEntity>> call({ ExpenseEntity? params}) {
    return expenseRepository.addExpense(params!);
  }

}