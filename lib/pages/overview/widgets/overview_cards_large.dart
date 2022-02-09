import 'package:flutter/material.dart';

import 'info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  const OverviewCardsLargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "Rides in Progress",
          value: "7",
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Packages delivered",
          value: "17",
          onTap: () {},
          topColor: Colors.green,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Cancelled Delivery",
          value: "3",
          onTap: () {},
          topColor: Colors.redAccent,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Scheduled Delivery",
          value: "24",
          onTap: () {},
        ),
      ],
    );
  }
}
