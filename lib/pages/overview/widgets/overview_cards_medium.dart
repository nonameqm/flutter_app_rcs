import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          OverviewInfoCard(
            title: "Rides in Progress",
            value: "7",
            onTap: () {},
            topColor: Colors.orange,
          ),
          SizedBox(
            width: _width / 64,
          ),
          OverviewInfoCard(
            title: "Packages delivered",
            value: "17",
            onTap: () {},
            topColor: Colors.green,
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          OverviewInfoCard(
            title: "Cancelled Delivery",
            value: "3",
            onTap: () {},
            topColor: Colors.redAccent,
          ),
          SizedBox(
            width: _width / 64,
          ),
          OverviewInfoCard(
            title: "Scheduled Delivery",
            value: "24",
            onTap: () {},
          ),
        ],
      ),
    ]);
  }
}
