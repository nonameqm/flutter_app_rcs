// ignore_for_file: sized_box_for_whitespace

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/pie_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class TestSectionLarge extends StatelessWidget {
  final Overview overview;
  const TestSectionLarge({Key key, this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total_test = overview.total_test;
    int pass = overview.total_success;
    int defect = total_test - pass;
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          )
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Test Data Chart",
                size: 26,
                weight: FontWeight.bold,
                color: lightGrey,
              ),
              if (pass != 0 && defect != 0)
                Container(
                    width: 600,
                    height: 200,
                    child: ResultPieChart.withGivenData([pass, defect]))
              else
                Container(
                    width: 600,
                    height: 200,
                    child: ResultPieChart.withSampleData())
            ],
          ),
        ),
        Container(
          width: 1,
          height: 200,
          color: lightGrey,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  TestInfo(
                    title: "Total Test",
                    amount: total_test.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  TestInfo(
                    title: "Total Pass",
                    amount: pass.toString(),
                  ),
                  TestInfo(
                    title: "Total Defection",
                    amount: defect.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
