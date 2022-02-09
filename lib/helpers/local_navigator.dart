import 'package:flutter/widgets.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/routings/router.dart';
import 'package:flutter_app_rcs/routings/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: OverViewPageRoute,
      onGenerateRoute: generateRoute,
    );
