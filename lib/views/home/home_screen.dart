import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/controllers/home_screen_controller.dart';
import 'package:personal_expense_tracker/routes/app_routes.dart';

import 'package:personal_expense_tracker/utils/app_strings.dart';
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
          bottomDetailsSheet(), //list of all expenses sorted
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
            : controller.expenseList.isEmpty && controller.filterTitle.value=="All"
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
                      Obx(() => SliverAppBar(
                            backgroundColor: Colors.transparent,
                            title: Text(
                              controller.filterTitle.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            primary: false,
                            pinned: true,
                            centerTitle: false,
                            actions: [
                             PopupMenuButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                position: PopupMenuPosition.under,
                                icon: Icon(
                                  Icons.tune,
                                  color: iconColorWhite,
                                ),
                                color: scaffoldBackgroundColor,
                                onSelected: (value) {
                                  if (value == 0) {
                                    controller.resetFilter();
                                  }
                                  if (value == 1) {
                                    controller.selectDate(context);
                                  }
                                },
                                itemBuilder: (BuildContext bc) {
                                  return  [
                                    PopupMenuItem(
                                         value: 0,
                                      child: Text(
                                        "All",
                                        style: TextStyle(color:controller.filterTitle.value=="All"? primaryColor:bodyTextColor),
                                      ),
                                   
                                    ),
                                    PopupMenuItem(
                                       value: 1,
                                      child: Text(
                                        "Filter by date",
                                        style: TextStyle(color:controller.filterTitle.value!="All"? primaryColor:bodyTextColor),
                                      ),
                                     
                                    ),
                                  ];
                                },
                              )
                            ],
                          )),
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
                                                  onPressed: (() {
                                                controller.deleteExpense(
                                                  controller.expenseList[index]
                                                          .id ??
                                                      "",
                                                );
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
