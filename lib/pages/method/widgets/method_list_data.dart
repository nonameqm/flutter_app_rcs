// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/widgets/custom_dialog.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';

class MethodListData extends StatelessWidget {
  const MethodListData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<MethodList> method_list = getMethodList(null);
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
                text: "Method List",
                color: lightGrey,
                weight: FontWeight.bold,
              ),
              const SizedBox(width: 10),
            ],
          ),
          FutureBuilder<MethodList>(
            future: method_list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MethodList data = snapshot.data;
                return DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text("Name"),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(label: Text("Maker")),
                    DataColumn2(label: Text("Target Robot")),
                    DataColumn2(label: Text("Target Subject")),
                    DataColumn2(label: Text("Created Date")),
                  ],
                  rows: List<DataRow>.generate(
                      data.methodList.length,
                      (index) => DataRow(cells: [
                            DataCell(
                              CustomText(
                                text: data.methodList[index].name,
                                size: 12,
                              ),
                              onTap: () {
                                Get.dialog(MethodDataDialog(
                                  method_name: data.methodList[index].name,
                                  robot_type: data.methodList[index].robot_type,
                                  subject_type:
                                      data.methodList[index].subject_type,
                                  method_data: data.methodList[index].data,
                                ));
                              },
                            ),
                            DataCell(
                              CustomText(
                                text: data.methodList[index].maker,
                                size: 11,
                              ),
                            ),
                            DataCell(
                              CustomText(
                                text: data.methodList[index].robot_type,
                                size: 11,
                              ),
                            ),
                            DataCell(CustomText(
                              text: data.methodList[index].subject_type,
                              size: 11,
                            )),
                            DataCell(
                              CustomText(
                                text: data.methodList[index].created_at,
                                size: 11,
                              ),
                            ),
                          ])),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
