import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';

class RobotDetailHead extends StatelessWidget {
  const RobotDetailHead({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                navigationController.goBack();
              },
              icon: Icon(
                Icons.arrow_back,
                color: dark.withOpacity(.7),
              ))
        ],
      ),
    );
  }
}
