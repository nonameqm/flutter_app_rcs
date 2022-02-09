import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class TestSectionSmall extends StatelessWidget {
  const TestSectionSmall({Key key}) : super(key: key);

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
                blurRadius: 12),
          ],
          border: Border.all(color: lightGrey, width: .5)),
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Defection Chart",
                  size: 20,
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
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
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
                      title: "Last 7 days",
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
                      title: "Last 30 days",
                      amount: "3,230",
                    ),
                    TestInfo(
                      title: "Last 12 months",
                      amount: "11,300",
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
