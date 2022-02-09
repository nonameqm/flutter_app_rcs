import 'package:flutter/cupertino.dart';
import 'package:flutter_app_rcs/helpers/responsiveness.dart';
import 'package:flutter_app_rcs/widgets/horizontal_menu_item.dart';
import 'package:flutter_app_rcs/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;

  const SideMenuItem({Key key, this.itemName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
    return HorizontalMenuItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
