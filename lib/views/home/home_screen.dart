import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/controllers/home_screen_controller.dart';
import 'package:personal_expense_tracker/routes/app_routes.dart';
import 'package:personal_expense_tracker/services/database_service.dart';

import 'package:personal_expense_tracker/utils/app_strings.dart';
import 'package:personal_expense_tracker/views/add_expense_screen.dart';
import 'package:personal_expense_tracker/views/home/widgets/expense_chart.dart';
import 'package:personal_expense_tracker/views/home/widgets/expense_listtile.dart';

import '../../utils/app_colors.dart';
import '../../utils/common_widgets.dart';

class HomeScreen extends GetView<HomeScreenController> {
  var controller = Get.put(HomeScreenController());
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          appTitle,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          ExpenseChart(), // categorywise expenses chart weekly
          bottomDetailsSheet(),  //list of all expenses sorted
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.ADDEXPENSE);
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: iconColorWhite,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget bottomDetailsSheet() {
    return DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
      return gradientContainer(Obx(
        () => controller.isLoading.value
            ? loading()
            : controller.expenseList.isEmpty
                ? Center(child: Text(noExpenses))
                : CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 4,
                            width: 40,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Obx(
                              () => Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  key: const ValueKey(0),
                                  children: [
                                    //edit expense
                                    SlidableAction(
                                      onPressed: (context) {
                                        Get.toNamed(AppRoutes.EDITEXPENSE,
                                            arguments:
                                                controller.expenseList[index]);
                                      },
                                      icon: Icons.edit,
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: iconColorWhite,
                                    ),
                                    //delete expense
                                    SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return showDeleteAlert(deleteText,
                                                  onPressed: (() async {
                                                controller.expenseList.value =
                                                    await ExpenseRepository()
                                                        .removeTransaction(
                                                            expenseId: controller
                                                                    .expenseList[
                                                                        index]
                                                                    .id ??
                                                                "");
                                                Navigator.pop(context);
                                                controller.initCategoryLists();
                                              }));
                                            },
                                          );
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: iconColorWhite),
                                  ],
                                ),
                                child: gradientExpenseContainer(
                                  ExpenseListTile(
                                    title:
                                        controller.expenseList[index].title ??
                                            "",
                                    amount:
                                        (controller.expenseList[index].amount ??
                                                0.0)
                                            .toString(),
                                    category: controller.expenseList[index]
                                            .category?.name ??
                                        "",
                                    date: controller.expenseList[index].date,
                                  ),
                                ).paddingSymmetric(vertical: 8),
                              ),
                            );
                          },
                          childCount: controller.expenseList.length,
                        ),
                      ),
                    ],
                  ),
      ));
    });
  }
}
