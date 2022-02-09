// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/enroll.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CustomDialog extends StatelessWidget {
  final Function yesTap;

  final bool noTap;
  final String title;
  final String message;

  const CustomDialog(
      {Key key, this.yesTap, this.noTap = true, this.title, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
      title: CustomText(
        color: Colors.black,
        text: title,
        size: 18,
        weight: FontWeight.bold,
      ),
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                color: Colors.black,
                text: message,
                size: 16,
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = yesTap,
                      text: "Confirm     ",
                      style: TextStyle(color: active, fontSize: 14)),
                  if (noTap)
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                        text: "Close",
                        style: TextStyle(color: active))
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// class DropdownMenu extends StatefulWidget {
//   final List<dynamic> target_list;
//   final String target_indicator;
//   final String selected;
//   const DropdownMenu(
//       {Key key, this.target_list, this.target_indicator, this.selected})
//       : super(key: key);
//   @override
//   State<DropdownMenu> createState() => _DropdownMenuState();
// }

// class _DropdownMenuState extends State<DropdownMenu> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String _selected = widget.selected;
//     if (widget.target_indicator == 'factory') {
//       return SizedBox(
//           child: Row(
//         children: [
//           CustomText(text: "Factory"),
//           SizedBox(
//             width: 40,
//           ),
//           DropdownButton(
//             borderRadius: BorderRadius.circular(20),
//             value: widget.selected,
//             items: widget.target_list.map((value) {
//               return DropdownMenuItem(
//                   value: value.name, child: Text(value.name));
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selected = value.name;
//               });
//             },
//             style: GoogleFonts.roboto(fontSize: 20),
//           ),
//         ],
//       ));
//     } else {
//       return SizedBox(
//           child: Row(
//         children: [
//           CustomText(text: "RobotType"),
//           SizedBox(
//             width: 40,
//           ),
//           DropdownButton(
//             borderRadius: BorderRadius.circular(20),
//             value: widget.selected,
//             items: widget.target_list.map((value) {
//               return DropdownMenuItem(
//                   value: value.type, child: Text(value.type));
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selected = value.type;
//               });
//             },
//             style: GoogleFonts.roboto(fontSize: 20),
//           ),
//         ],
//       ));
//     }
//   }
// }

class RobotRegisterDialog extends StatelessWidget {
  final List<String> input_list;
  final bool noTap;
  final String message;
  final List<RobotType> robottype_list;
  final List<Factory> factory_list;
  const RobotRegisterDialog(
      {Key key,
      this.input_list,
      this.noTap,
      this.message,
      this.robottype_list,
      this.factory_list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllers = List();

    String _selected_factory = factory_list[0].name;
    String _selected_robottype = robottype_list[0].type;

    return SimpleDialog(
      title: CustomText(
        color: Colors.black,
        text: "Register New Robot",
        size: 18,
        weight: FontWeight.bold,
      ),
      children: [
        Container(
          height: 350,
          width: MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                color: Colors.black,
                text: message,
                size: 16,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: input_list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    _controllers.add(new TextEditingController());
                    return SizedBox(
                      width: 200,
                      child: Column(children: [
                        TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: input_list[index],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ]),
                    );
                  },
                ),
              )),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Map<String, String> new_robot_data = {
                            "type": _controllers[1].text ?? 'X-ARM6',
                            "serial": _controllers[2].text,
                            "ip": _controllers[3].text,
                            "factory": _controllers[0].text,
                            "method": null,
                          };
                          Future<http.Response> httpResponse =
                              register_robot(new_robot_data);
                          httpResponse.then((val) {
                            if (val.statusCode == 200) {
                              Get.offAllNamed(RobotPageRoute);
                            } else {
                              Get.snackbar(
                                "Register failed",
                                json.decode(val.body)['msg'].toString(),
                                snackPosition: SnackPosition.TOP,
                                isDismissible: true,
                              );
                              _controllers.map((val) => val.text = '');
                            }
                          }).catchError((error) {
                            print('error: ' + error.toString());
                          });
                        },
                      text: "Confirm     ",
                      style: TextStyle(color: active, fontSize: 14)),
                  if (noTap)
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                        text: "Close",
                        style: TextStyle(color: active))
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class InputDialog extends StatelessWidget {
  final String type;
  final bool noTap;
  final List<String> input_list;
  final String title;
  final String message;

  const InputDialog(
      {Key key,
      this.type,
      this.noTap,
      this.input_list,
      this.title,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllers = new List();
    return SimpleDialog(
      title: CustomText(
        color: Colors.black,
        text: title,
        size: 18,
        weight: FontWeight.bold,
      ),
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                color: Colors.black,
                text: message,
                size: 16,
              ),
              Expanded(
                  child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: input_list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    _controllers.add(new TextEditingController());
                    return SizedBox(
                      width: 200,
                      child: Column(children: [
                        TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: input_list[index],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ]),
                    );
                  },
                ),
              )),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (type == 'factory') {
                            Map<String, String> new_factory_data = {
                              "name": _controllers[0].text,
                              "company": GetStorage('session').read('company'),
                              "loc": _controllers[1].text
                            };
                            Future<http.Response> httpResponse =
                                register_factory(new_factory_data);
                            httpResponse.then((val) {
                              if (val.statusCode == 200) {
                                Get.offAllNamed(FactoryPageRoute);
                              } else {
                                Get.snackbar(
                                  "Register failed",
                                  json.decode(val.body)['msg'].toString(),
                                  snackPosition: SnackPosition.TOP,
                                  isDismissible: true,
                                );
                                _controllers.map((val) => val.text = '');
                              }
                            }).catchError((error) {
                              print('error: ' + error.toString());
                            });
                          }
                        },
                      text: "Confirm     ",
                      style: TextStyle(color: active, fontSize: 14)),
                  if (noTap)
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                        text: "Close",
                        style: TextStyle(color: active))
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class MethodDataDialog extends StatefulWidget {
  final String method_name;
  final String robot_type;
  final String subject_type;
  final Map<dynamic, dynamic> method_data;

  const MethodDataDialog(
      {Key key,
      this.method_name,
      this.robot_type,
      this.subject_type,
      this.method_data})
      : super(key: key);

  @override
  State<MethodDataDialog> createState() => _MethodDataDialog();
}

class _MethodDataDialog extends State<MethodDataDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data_list = widget.method_data[widget.method_name] as List;
    var methoddatalist = MethodDataList.fromJson(data_list);
    return SimpleDialog(
        title: CustomText(
          color: Colors.black,
          text: "Method Data",
          size: 18,
          weight: FontWeight.bold,
        ),
        children: [
          Container(
              height: 500,
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: Colors.black,
                        text: widget.method_name + ".json",
                        size: 16,
                      ),
                      CustomText(
                        color: Colors.black,
                        text: 'Stage Conut : ' +
                            methoddatalist.methoddataList.length.toString(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: Colors.black,
                        text: 'Robot : ' + widget.robot_type,
                      ),
                      CustomText(
                        color: Colors.black,
                        text: 'Subject : ' + widget.subject_type,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemCount: methoddatalist.methoddataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var time_delay = methoddatalist
                                  .methoddataList[index].time_delay;
                              var pose =
                                  methoddatalist.methoddataList[index].pose;
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            style: BorderStyle.solid,
                                            width: 2)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Pose",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${pose[0]}\n${pose[1]}\n${pose[2]}\n${pose[3]}\n${pose[4]}\n${pose[5]}',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Delay",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                        Text(
                                          time_delay.toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              text: "Confirm     ",
                              style: TextStyle(color: active, fontSize: 14)),
                        ]),
                      )
                    ],
                  )
                ],
              ))
        ]);
  }
}
