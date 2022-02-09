// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Rides in progress",
            value: "7",
            onTap: () {},
            topColor: Colors.orange,
            isActive: true,
          ),
          SizedBox(
            width: _width / 64,
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Packages delivered",
            value: "17",
            onTap: () {},
            topColor: Colors.green,
          ),
          SizedBox(
            width: _width / 64,
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Cancelled Delivery",
            value: "3",
            onTap: () {},
            topColor: Colors.redAccent,
          ),
          SizedBox(
            width: _width / 64,
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Scheduled Delivery",
            value: "24",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
