import 'package:personal_expense_tracker/domain/entities/expense_entity.dart';

import '../../utils/constants/app_constants.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel(
      {required this.id,
      required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : super(
            id: id,
            amount: amount,
            date: date,
            title: title,
            category: category);

  String? id;
  String? title;
  double? amount;
  late DateTime date;
  Category? category;

  get formattedDate {
    return formatter.format(date);
  }

  factory ExpenseModel.fromMap(Map<dynamic, dynamic> map) {
    return ExpenseModel(
        id: map['id'].toString(),
        title: map['title'],
        category: map['category'] == "food"
            ? Category.food
            : map['category'] == "travel"
                ? Category.travel
                : Category.misc,
        amount: double.tryParse(map['amount']) ?? 0.0,
        date: DateTime.fromMillisecondsSinceEpoch(map['date']));
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id.toString(),
      'title': title,
      'amount': amount.toString(),
      'date': date.millisecondsSinceEpoch,
      'category': category?.name.toString()
    };

    return map;
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
        id: entity.id,
        title: entity.title,
        amount: entity.amount,
        category: entity.category,
        date: entity.date);
  }
}
