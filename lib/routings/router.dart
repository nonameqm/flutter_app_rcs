// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/pages/authentication/authentication.dart';
import 'package:flutter_app_rcs/pages/factory/factory.dart';
import 'package:flutter_app_rcs/pages/method/methods.dart';
import 'package:flutter_app_rcs/pages/overview/overview.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/robot_detail.dart';
import 'package:flutter_app_rcs/pages/robots/robots.dart';
import 'package:flutter_app_rcs/routings/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverViewPage());
    case FactoryPageRoute:
      return _getPageRoute(FactoryPage());
    case RobotPageRoute:
      return _getPageRoute(RobotListPage(
        arguments: {},
      ));
    case MethodPageRoute:
      return _getPageRoute(MethodPage());

    case RobotDetailPageRoute:
      return _getPageRoute(RobotDetailPage(
        argument: settings.arguments,
      ));

    default:
      return _getPageRoute(AuthenticationPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
