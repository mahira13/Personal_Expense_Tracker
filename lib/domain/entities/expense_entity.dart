

import '../../utils/constants/app_constants.dart';

class ExpenseEntity {
  ExpenseEntity(
      {required this.id,
      required this.amount,
      required this.date,
      required this.title,
      required this.category});

  String? id;
  String? title;
  double? amount;
  late DateTime date;
  Category? category;

  get formattedDate {
    return formatter.format(date);
  }
}
