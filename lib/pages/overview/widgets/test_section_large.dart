// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class TestSectionLarge extends StatelessWidget {
  const TestSectionLarge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 600,
                height: 200,
                child: SimpleBarChart.withSampleData(),
              )
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
                children: const [
                  TestInfo(
                    title: "Today\'s Defection",
                    amount: "230",
                  ),
                  TestInfo(
                    title: "Last 1 day",
                    amount: "1,100",
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  TestInfo(
                    title: "Last 1 week",
                    amount: "3,230",
                  ),
                  TestInfo(
                    title: "Last 1 month",
                    amount: "11,300",
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
