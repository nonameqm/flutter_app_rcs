import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/test_info.dart';
import 'package:flutter_app_rcs/widgets/command_dialog.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommandButtonList extends StatelessWidget {
  final String serial;
  const CommandButtonList({Key key, this.serial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          )
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(children: [
        Expanded(
            child: SizedBox(
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: method_type_not_dev.length,
              itemBuilder: (context, index) {
                return commandButton(method_type_not_dev[index]);
              }),
        )),
        Container(
          width: 1,
          height: 150,
          color: lightGrey,
        ),
      ]),
    );
  }

  Widget commandButton(String method_name) {
    MethodList methodlist;
    Future<http.Response> response = http_getMethodList(null);
    response.then((val) {
      if (val.statusCode == 200) {
        methodlist = MethodList.fromJson(json.decode(val.body));
      }
    }).catchError((error) => print('$error{}'));
    return TextButton(
        onPressed: () {
          Get.dialog(CommandDialog(
            method_name: method_name,
            method_list: methodlist,
            robot_serial: serial,
          ));
        },
        child: CustomText(
          text: method_name,
          color: active,
          size: 20,
          weight: FontWeight.w300,
        ));
  }
}
