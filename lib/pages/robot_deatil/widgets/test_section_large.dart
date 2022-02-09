// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class RobotTestSectionLarge extends StatefulWidget {
  final String serial;
  const RobotTestSectionLarge({Key key, this.serial});

  @override
  State<StatefulWidget> createState() => _RobotTestSectionLargeState();
}

class _RobotTestSectionLargeState extends State<RobotTestSectionLarge> {
  StreamController _streamController = StreamController();
  Timer _timer;
  var data;

  Future getTestResult() async {
    String urlData =
        api_server_ip + 'item/result/' + '?serial=' + widget.serial;
    final url = Uri.parse(urlData);
    http.Response response = await http.get(url, headers: request_headers);

    TestResultList testlist =
        TestResultList.fromJson(json.decode(response.body));

    _streamController.add(testlist);
  }

  @override
  void initState() {
    getTestResult();
    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => getTestResult());
    super.initState();
  }

  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var defection = 0;
          snapshot.data.result_list.map((item) {
            if (item.result == 0) {
              defection += 1;
            }
          });

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
                      children: [
                        TestInfo(
                          title: "Today's Test",
                          amount: snapshot.data.result_list.length.toString(),
                        ),
                        TestInfo(
                          title: "Today\'s Defection",
                          amount: defection.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ]),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
