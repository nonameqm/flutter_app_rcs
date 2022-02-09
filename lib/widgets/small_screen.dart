import 'package:flutter/cupertino.dart';
import 'package:flutter_app_rcs/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: localNavigator(),
    );
  }
}
