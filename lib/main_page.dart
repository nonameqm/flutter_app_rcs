// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/widgets/large_screen.dart';
import 'package:flutter_app_rcs/widgets/side_menu.dart';
import 'package:flutter_app_rcs/widgets/small_screen.dart';
import 'package:flutter_app_rcs/widgets/top_nav.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: Drawer(
          child: SideMenu(),
        ),
        body: const ResponsiveWidget(
          largeScreen: LargeScreen(),
          smallScreen: SmallScreen(),
        ));
  }
}
