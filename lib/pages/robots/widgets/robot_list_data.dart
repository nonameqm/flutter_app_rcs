// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/controllers/navigation_controller.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/robot_detail.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_dialog.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RobotListData extends StatelessWidget {
  const RobotListData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response> robottype_data = http_getRobotType();
    Future<http.Response> factory_data =
        http_getFactoryList(GetStorage('session').read('company'));
    RobotTypeList robottype_list;
    String _selected_robottype;
    FactoryList factory_list;
    String _selected_factory;

    robottype_data.then((val) {
      if (val.statusCode == 200) {
        robottype_list = RobotTypeList.fromJson(json.decode(val.body));
        _selected_robottype = robottype_list.robottypeList[0].type;
      }
    });

    factory_data.then((val) {
      if (val.statusCode == 200) {
        factory_list = FactoryList.fromJson(json.decode(val.body));
        _selected_factory = factory_list.factoryList[0].name;
      }
    });

    var company = GetStorage('session').read('company');
    Future<RobotList> robotlist = getRobotList('company', company);

    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12),
            ],
            border: Border.all(color: lightGrey, width: .5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Robot List",
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 25,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                            onPressed: () {
                              Get.dialog(RobotRegisterDialog(
                                factory_list: factory_list.factoryList,
                                robottype_list: robottype_list.robottypeList,
                                noTap: false,
                                input_list: const [
                                  'Factory',
                                  'Robot Type',
                                  'Serial',
                                  'Ip',
                                ],
                                message: 'Please input following info.',
                              ));
                            },
                            backgroundColor: Colors.grey,
                            child: const Icon(
                              Icons.add_rounded,
                              size: 20,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            FutureBuilder<RobotList>(
              future: robotlist,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RobotList data = snapshot.data;
                  return DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: const [
                        DataColumn2(
                            label: Text('Robot Serial'), size: ColumnSize.L),
                        DataColumn2(
                          label: Text('Factory'),
                        ),
                        DataColumn2(
                          label: Text('Robot Type'),
                        ),
                        DataColumn(
                          label: Text('Robot IP'),
                        ),
                        DataColumn(
                          label: Text('ON/OFF'),
                        ),
                        DataColumn(
                          label: Text('Running Method'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          data.robots.length,
                          (index) => DataRow(cells: [
                                DataCell(
                                    CustomText(
                                      text: data.robots[index].serial,
                                    ), onTap: () {
                                  navigationController.navigateTo(
                                      RobotDetailPageRoute,
                                      {'serial': data.robots[index].serial});
                                }),
                                DataCell(
                                  CustomText(
                                    text: data.robots[index].factory_name,
                                  ),
                                ),
                                DataCell(CustomText(
                                  text: data.robots[index].type,
                                )),
                                DataCell(CustomText(
                                  text: data.robots[index].ip,
                                )),
                                DataCell(
                                  data.robots[index].status == 1
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.green.shade400,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 5),
                                            const CustomText(
                                              text: "ON",
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red.shade400,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 5),
                                              const CustomText(
                                                text: "OFF",
                                              ),
                                            ]),
                                ),
                                DataCell(CustomText(
                                  text: data.robots[index].method_id ??
                                      'method undefined',
                                ))
                              ])));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ));
  }
}
