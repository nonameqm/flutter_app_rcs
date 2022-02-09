import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:flutter_app_rcs/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        color: light,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: _width / 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset("assets/icons/logo.png"),
                      ),
                      Flexible(
                          child: CustomText(
                        text: "RCS",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      )),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  )
                ],
              ),
            Divider(
              color: lightGrey.withOpacity(.1),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((item) => SideMenuItem(
                        itemName: item.name,
                        onTap: () {
                          if (item.route == AuthenticationPageRoute) {
                            menuController
                                .changeActiveItemTo(OverViewPageDisplayName);
                            Get.offAllNamed(AuthenticationPageRoute);
                          }
                          if (!menuController.isActive(item.name)) {
                            menuController.changeActiveItemTo(item.name);
                            if (ResponsiveWidget.isSmallScreen(context)) {
                              Get.back();
                            }
                            navigationController.navigateTo(item.route, {});
                          }
                        },
                      ))
                  .toList(),
            )
          ],
        ));
  }
}
