// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/controllers/menu_controller.dart';
import 'package:flutter_app_rcs/controllers/navigation_controller.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/main_page.dart';
import 'package:flutter_app_rcs/pages/authentication/authentication.dart';
import 'package:flutter_app_rcs/pages/enroll/enroll.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  await GetStorage.init();
  GetStorage session_storage = GetStorage('session');
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(App());
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fadeUpwardsPageTransitionBuilder = FadeUpwardsPageTransitionsBuilder();

    return GetMaterialApp(
      title: 'Robot Control System',
      initialRoute: AuthenticationPageRoute,
      getPages: [
        GetPage(
            name: RootRoute,
            page: () {
              return MainPage();
            },
            transition: Transition.zoom),
        GetPage(
            name: AuthenticationPageRoute,
            page: () {
              return AuthenticationPage();
            }),
        GetPage(
            name: EnrollPageRoute,
            page: () {
              return EnrollPage();
            })
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: fadeUpwardsPageTransitionBuilder,
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.purple),
    );
  }
}
