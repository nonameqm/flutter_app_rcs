import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:get/get.dart';
import 'package:flutter_app_rcs/routings/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = OverViewPageDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case OverViewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case FactoryPageDisplayName:
        return _customIcon(Icons.apartment, itemName);
      case RobotPageDisplayName:
        return _customIcon(Icons.memory_rounded, itemName);
      case MethodPageDisplayName:
        return _customIcon(Icons.cloud_circle_outlined, itemName);
      case AuthenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
