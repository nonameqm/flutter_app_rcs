import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get_storage/get_storage.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    title: Container(
      child: Row(
        children: [
          Visibility(
              child: CustomText(
            text: "RCS",
            color: lightGrey,
            size: 20,
            weight: FontWeight.bold,
          )),
          Expanded(
            child: Container(),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: dark,
            ),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  )),
              Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)),
                  )),
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),
          CustomText(
            text: GetStorage('session').read('company'),
            color: lightGrey,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: active.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: light,
              child: Icon(
                Icons.person_outline,
                color: dark,
              ),
            ),
          )
        ],
      ),
    ),
    iconTheme: IconThemeData(color: dark),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
