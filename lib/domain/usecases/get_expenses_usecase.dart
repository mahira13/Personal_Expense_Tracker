import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';
import 'package:personal_expense_tracker/domain/repository/expense_repository.dart';
import 'package:personal_expense_tracker/utils/usecase/usecase.dart';

class GetExpensesUsecase implements UseCase<List<ExpenseEntity>, void>{
  final ExpenseRepository expenseRepository;
  GetExpensesUsecase({required this.expenseRepository});
  @override
  Future<List<ExpenseEntity>> call({ void params}) {
    return expenseRepository.getExpensesList();
  }

}