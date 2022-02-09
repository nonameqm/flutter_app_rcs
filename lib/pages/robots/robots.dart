// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/pages/robots/widgets/robot_list_data.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';

class RobotListPage extends StatelessWidget {
  final Map arguments;
  const RobotListPage({Key key, @required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        Expanded(
          child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [RobotListData()]),
        )
      ],
    );
  }
}
