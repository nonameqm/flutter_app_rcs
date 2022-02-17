import 'package:flutter/material.dart';

import 'info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final Map argument;
  const OverviewCardsLargeScreen({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        RobotInfoCard(
          title: "Current",
          serial: argument['serial'],
          type: "current",
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
          isActive: false,
          onTap: () {},
          topColor: Colors.green,
        ),
        SizedBox(
          width: _width / 64,
        ),
        RobotInfoCard(
          title: "Status",
          serial: argument['serial'],
          type: "status",
          isActive: false,
          onTap: () {},
          topColor: Colors.green,
        ),
        SizedBox(
          width: _width / 64,
        ),
        RobotInfoCard(
          title: "Error",
          serial: argument['serial'],
          type: "error",
          isActive: false,
          onTap: () {},
          topColor: Colors.green,
        ),
      ],
    );
  }
}
