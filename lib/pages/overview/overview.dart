// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_section_large.dart';
import 'package:flutter_app_rcs/pages/overview/widgets/test_section_small.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:get_storage/get_storage.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Overview> overview =
        getOverviewData(GetStorage('session').read('company'));
    return Column(children: [
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
      FutureBuilder(
          future: overview,
          builder: (context, snapshot) {
            Overview _overview = snapshot.data;
            return Expanded(
              child: ListView(
                children: [
                  if (ResponsiveWidget.isLargeScreen(context))
                    OverviewCardsLargeScreen(overview: _overview)
                  else if (ResponsiveWidget.isMediumScreen(context))
                    OverviewCardsMediumScreen()
                  else
                    OverviewCardsSmallScreen(),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    TestSectionLarge(overview: _overview)
                  else
                    const TestSectionSmall(),
                ],
              ),
            );
          })
    ]);
  }
}
