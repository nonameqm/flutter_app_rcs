import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';

class TestInfo extends StatelessWidget {
  final String title;
  final String amount;

  const TestInfo({Key key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: "$title \n\n",
              style: TextStyle(color: lightGrey, fontSize: 16)),
          TextSpan(
              text: "$amount \n\n",
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
