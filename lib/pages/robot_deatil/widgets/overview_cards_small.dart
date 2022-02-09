// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  final Map argument;
  const OverviewCardsSmallScreen({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          RobotInfoCardSmall(
            title: "Current",
            serial: argument['serial'],
            type: "current",
            value: "7",
            isActive: false,
            onTap: () {},
            topColor: Colors.orange,
          ),
          SizedBox(
            width: _width / 64,
            height: _width / 64,
          ),
          RobotInfoCardSmall(
            title: "Voltage",
            serial: argument['serial'],
            type: "voltage",
            value: "17",
            isActive: false,
            onTap: () {},
            topColor: Colors.green,
          ),
          SizedBox(
            height: _width / 64,
            width: _width / 64,
          ),
        ],
      ),
    );
  }
}
