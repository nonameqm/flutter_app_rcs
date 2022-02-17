import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/factory_detail/widgets/pie_chart.dart';
import 'package:flutter_app_rcs/pages/factory_detail/widgets/test_section_large.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

import 'widgets/factory_detail_head.dart';
import 'widgets/robot_list_data.dart';

class FactoryDetailPage extends StatelessWidget {
  final Map argument;
  const FactoryDetailPage({Key key, this.argument}) : super(key: key);

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
                      argument['factory_name'],
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          )),
      Expanded(
        child: ListView(
          children: [
            const FactoryDetailHead(),
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 48 : 6),
            ),
            const CustomText(
              text: "Factory Status",
              size: 20,
            ),
            FactoryTestSectionLarge(
              argument: argument,
            ),
            const CustomText(
              text: "Robot List",
              size: 20,
            ),
            RobotDataFactory(
              factory_name: argument['factory_name'],
            ),
            // if (!ResponsiveWidget.isSmallScreen(context))
            //   RobotTestSectionLarge(
            //     serial: argument["serial"],
            //   )
            // else
            //   const TestSectionSmall(),
          ],
        ),
      )
    ]);
  }
}
