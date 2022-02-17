// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/pie_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class FactoryTestSectionLarge extends StatelessWidget {
  final Map argument;

  const FactoryTestSectionLarge({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<FactoryOverview> overview =
        getFactoryOverView(argument['factory_name']);
    return FutureBuilder(
        future: overview,
        builder: (context, snapshot) {
          FactoryOverview data = snapshot.data;
          int pass = data.success;
          int defection = data.total_test - snapshot.data.success;
          if (snapshot.hasData) {
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
                      if (snapshot.data.success != 0 &&
                          snapshot.data.defection != 0)
                        Container(
                            width: 600,
                            height: 200,
                            child:
                                ResultPieChart.withGivenData([pass, defection]))
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
                            amount: (pass + defection).toString(),
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
                            amount: defection.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
