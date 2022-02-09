import 'package:flutter_app_rcs/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/command_button.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/robot_detail_head.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/overview_cards_large.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/overview_cards_medium.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/overview_cards_small.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/test_section_large.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/test_section_small.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class RobotDetailPage extends StatelessWidget {
  final Map argument;
  const RobotDetailPage({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(() => Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 48 : 6),
                child: CustomText(
                  text: menuController.activeItem.value +
                      ' - ' +
                      argument['serial'],
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          )),
      Expanded(
        child: ListView(
          children: [
            RobotDetailHead(),
            if (ResponsiveWidget.isLargeScreen(context))
              OverviewCardsLargeScreen(
                argument: argument,
              )
            else if (ResponsiveWidget.isMediumScreen(context))
              OverviewCardsMediumScreen(
                argument: argument,
              )
            else
              OverviewCardsSmallScreen(
                argument: argument,
              ),
            const CustomText(
              text: "Robot Command List",
              size: 20,
            ),
            CommandButtonList(
              serial: argument["serial"],
            ),
            if (!ResponsiveWidget.isSmallScreen(context))
              RobotTestSectionLarge(
                serial: argument["serial"],
              )
            else
              const TestSectionSmall(),
          ],
        ),
      )
    ]);
  }
}
