import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/utils/app_colors.dart';
import 'package:personal_expense_tracker/utils/common_widgets.dart';

class ExpenseListTile extends StatelessWidget {
  String title;
  String category;
  String amount;
  DateTime date;
  ExpenseListTile(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: categoryCircleWidget(category),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ).paddingOnly(bottom: 6, top: 14),
      subtitle: Text(DateFormat.yMMMd().format(date),
              style: Theme.of(context).textTheme.bodySmall)
          .paddingOnly(bottom: 8),
      trailing: Text(
        "\u{20B9} $amount",
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: primaryColor),
      ),
    );
  }
}
