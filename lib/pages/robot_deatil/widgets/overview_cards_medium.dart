import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  final Map argument;
  const OverviewCardsMediumScreen({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          RobotInfoCard(
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
          ),
          RobotInfoCard(
            title: "Voltage",
            serial: argument['serial'],
            type: "voltage",
            value: "17",
            isActive: false,
            onTap: () {},
            topColor: Colors.green,
          ),
          SizedBox(
            width: _width / 64,
          ),
        ],
      ),
    ]);
  }
}
