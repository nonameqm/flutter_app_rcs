// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/logic/function/enroll.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CommandDialog extends StatefulWidget {
  final String method_name;
  final String robot_serial;
  final MethodList method_list;

  CommandDialog(
      {Key key, this.method_name, this.robot_serial, this.method_list});

  @override
  State<CommandDialog> createState() => _CommandDialog();
}

class _CommandDialog extends State<CommandDialog> {
  TextEditingController controller = TextEditingController();
  var command_w_order = [
    "manual_start",
    "get_pos",
    "confirm_method",
    "set_method",
    "get_method",
  ];
  String _selected_method;
  @override
  void initState() {
    _selected_method = widget.method_list.methodList[0].name;

    super.initState();
  }

  Widget build(BuildContext context) {
    if (command_w_order.contains(widget.method_name)) {
      return SimpleDialog(
        title: CustomText(
          color: Colors.black,
          text: widget.method_name + " - Execute?",
          size: 16,
          weight: FontWeight.bold,
        ),
        children: [
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const CustomText(
                        color: Colors.black,
                        text:
                            "Please Press Confirm Button below to execute the method",
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CustomText(
                        color: Colors.black,
                        text: "Target Robot : ${widget.robot_serial}",
                        size: 16,
                      ),
                    ],
                  ),
                  if (widget.method_name == "manual_start")
                    Column(children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Name your new method",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ])
                  else if (widget.method_name == "get_pos")
                    Column(children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Input Time Delay",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ])
                  else if (widget.method_name == "confirm_method")
                    Column(children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Input Method name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ])
                  else if (widget.method_name == "get_method")
                    Column(children: [
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Input Method name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ])
                  else // set_method
                    Expanded(
                        child: SizedBox(
                      height: 80,
                      child: DropdownButton(
                          borderRadius: BorderRadius.circular(20),
                          value: _selected_method,
                          items: widget.method_list.methodList.map((value) {
                            return DropdownMenuItem(
                                value: value.name, child: Text(value.name));
                          }).toList(),
                          onChanged: ((value) {
                            setState(() {
                              _selected_method = value;
                            });
                          })),
                    )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Map<String, String> command_data;
                                  if (widget.method_name != 'set_method') {
                                    command_data = {
                                      "robot_serial": widget.robot_serial,
                                      "robot_param": controller.text,
                                      "email":
                                          GetStorage('session').read('email')
                                    };
                                  } else {
                                    command_data = {
                                      "robot_serial": widget.robot_serial,
                                      "robot_param": _selected_method + '.json'
                                    };
                                    print(_selected_method);
                                  }
                                  Future<http.Response> httpResponse =
                                      send_command(
                                          widget.method_name, command_data);

                                  httpResponse.then((val) {
                                    if (val.statusCode == 200) {
                                      Get.snackbar(
                                        "Command Succeed",
                                        json.decode(val.body).toString(),
                                      );
                                      // Get.offAllNamed(RobotDetailPageRoute,
                                      //     arguments: {
                                      //       'serial': widget.robot_serial
                                      //     });
                                    } else {
                                      Get.snackbar(
                                        "Command failed",
                                        json.decode(val.body)['msg'].toString(),
                                        snackPosition: SnackPosition.TOP,
                                        isDismissible: true,
                                      );
                                    }
                                  }).catchError((error) {
                                    print('error: ' + error.toString());
                                  });
                                },
                              text: "Confirm",
                              style: const TextStyle(
                                  color: const Color(0xFF3C19FF),
                                  fontSize: 16)),
                        ]),
                      )
                    ],
                  )
                ],
              ))
        ],
      );
    } else {
      return SimpleDialog(
        title: CustomText(
          color: Colors.black,
          text: widget.method_name + " - Execute?",
          size: 16,
          weight: FontWeight.bold,
        ),
        children: [
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const CustomText(
                        color: Colors.black,
                        text:
                            "Please Press Confirm Button below to execute the method",
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      CustomText(
                        color: Colors.black,
                        text: "Target Robot : ${widget.robot_serial}",
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Map<String, String> command_data = {
                                    "robot_serial": widget.robot_serial,
                                    "robot_param": null
                                  };
                                  Future<http.Response> httpResponse =
                                      send_command(
                                          widget.method_name, command_data);

                                  httpResponse.then((val) {
                                    if (val.statusCode == 200) {
                                      Get.snackbar(
                                        "Command Succeed",
                                        json.decode(val.body).toString(),
                                      );
                                      // Get.offAllNamed(RobotDetailPageRoute,
                                      //     arguments: {
                                      //       'serial': widget.robot_serial
                                      //     });
                                    } else {
                                      Get.snackbar(
                                        "Command failed",
                                        json.decode(val.body)['msg'].toString(),
                                        snackPosition: SnackPosition.TOP,
                                        isDismissible: true,
                                      );
                                    }
                                  }).catchError((error) {
                                    print('error: ' + error.toString());
                                  });
                                },
                              text: "Confirm",
                              style: const TextStyle(
                                  color: const Color(0xFF3C19FF),
                                  fontSize: 16)),
                        ]),
                      )
                    ],
                  )
                ],
              ))
        ],
      );
    }
  }
}
