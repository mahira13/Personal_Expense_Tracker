import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/utils/app_colors.dart';
import '../controllers/edit_expense_controller.dart';
import '../models/expense_model.dart';
import '../utils/app_strings.dart';
import '../utils/common_widgets.dart';

class EditExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Expense? expenseItem = Get.arguments;
    var controller = Get.put(EditExpenseController(expenseItem));
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          editExpense,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              commonTextfieldCL(
                controller.titleController,
                "Enter the expense title",
                maxLength: 50,
                textInputAction: TextInputAction.next,
                onTap: (() {}),
                focusnode: controller.titleFocus,
                validationFunc: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title cannot be empty";
                  }

                  return null;
                },
                onFieldSubmitted: (_) => controller.fieldFocusChange(
                    context, controller.titleFocus, controller.amountFocus),
              ),

              commonTextfieldCL(
                controller.amountController,
                "Enter the amount",
                maxLength: 10,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onTap: (() {}),
                focusnode: controller.amountFocus,
                prefix: '\u{20B9} ',
                validationFunc: (value) {
                  RegExp regex = RegExp('[0-9]+(\.[0-9]+)?');
                  if (!regex.hasMatch(value!) ||
                      double.tryParse(value) == null) {
                    return "Please enter a valid amount";
                  }
                  return null;
                },
              ),
              Obx(() => Container(
                    height: 52,
                    padding: EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    child: DropdownButton<String>(
                      items: <String>['food', 'travel', 'misc']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10),
                      value: controller.selectedCategory.value,
                      isExpanded: true,
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedCategory.value = value;
                        }
                      },
                    ),
                  ).paddingOnly(bottom: 24)),
              // Date and Time Textfield

              Flexible(
                fit: FlexFit.loose,
                child: GestureDetector(
                  onTap: () => controller.selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller.dateController,
                      focusNode: controller.dateFocus,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                        labelText: 'Date',
                        hintText: 'Date of Transaction',
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: iconColorWhite,
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: iconColorWhite,
                        ),
                        labelStyle: TextStyle(color: bodyTextColor),
                      ),
                      //autovalidate: _autoValidateToggle,
                      validator: (value) {
                        if (value!.isEmpty) return "Please select a date";
                        return null;
                      },
                    ),
                  ),
                ),
              ),

              getElevatedButton(
                "EDIT",
                onPressed: (() {
                  controller.onSubmit();
                }),
              ).paddingOnly(top: 24)
            ],
          ),
        ),
      ),
    );
  }
}
