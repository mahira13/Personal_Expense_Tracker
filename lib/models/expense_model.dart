import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  misc,
}

class Expense {
  Expense(
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

  Expense.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'].toString();
    title = map['title'];
    category = map['category'] == "food"
        ? Category.food
        : map['category'] == "travel"
            ? Category.travel
            : Category.misc;
    amount = double.tryParse(map['amount']) ?? 0.0;
    date = DateTime.fromMillisecondsSinceEpoch(map['date']);
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
}
