import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/helpers/local_navigator.dart';
import 'package:flutter_app_rcs/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SideMenu(),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        ),
      ],
    );
  }
}
