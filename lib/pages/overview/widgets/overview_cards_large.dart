import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';

import 'info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final Overview overview;
  const OverviewCardsLargeScreen({Key key, this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        OverviewInfoCard(
          title: "User in Company",
          value: overview.total_user.toString(),
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        OverviewInfoCard(
          title: "Factory in Company",
          value: overview.total_factory.toString(),
          onTap: () {},
          topColor: Colors.green,
        ),
        SizedBox(
          width: _width / 64,
        ),
        OverviewInfoCard(
          title: "Robot in Company",
          value: overview.total_robot.toString(),
          onTap: () {},
          topColor: Colors.redAccent,
        ),
        SizedBox(
          width: _width / 64,
        ),
        OverviewInfoCard(
          title: "Total Test Executed",
          value: overview.total_test.toString(),
          onTap: () {},
        ),
      ],
    );
  }
}
