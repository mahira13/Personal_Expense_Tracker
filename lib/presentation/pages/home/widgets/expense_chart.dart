import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/presentation/controllers/home/home_screen_controller.dart';
import 'package:personal_expense_tracker/utils/constants/app_strings.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_constants.dart';

class ExpenseChart extends StatelessWidget {
  HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeScreenController.showingBarGroups.isEmpty
        ? Text(noChart).paddingSymmetric(vertical: 100, horizontal: 16)
        : AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundColor: gradientColor3,
                          radius: 4,
                        ),
                        Text(Category.food.name)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundColor: gradientColor1,
                          radius: 4,
                        ),
                        Text(Category.travel.name)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundColor: gradientColor5,
                          radius: 4,
                        ),
                        Text(Category.misc.name)
                      ],
                    ),
                  ).paddingOnly(bottom: 16),
                  Expanded(
                    child: Obx(() => BarChart(
                          BarChartData(
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: bottomTitles,
                                  reservedSize: 42,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups:
                                homeScreenController.showingBarGroups.value,
                            gridData: const FlGridData(show: false),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
