// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_dialog.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FactoryData extends StatelessWidget {
  final Map arguments;
  const FactoryData({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var company = GetStorage('session').read('company');
    Future<FactoryList> factoryList = getFactoryList(company);

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
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            const SizedBox(width: 10),
            CustomText(
              text: "Factory List",
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
                          Get.dialog(InputDialog(
                            type: 'factory',
                            noTap: false,
                            input_list: const ['factory name', 'factory loc'],
                            title: 'Enroll New Factory',
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
        FutureBuilder<FactoryList>(
            future: factoryList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                FactoryList data = snapshot.data;
                return DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(label: Text("Factory Name")),
                      DataColumn2(label: Text("Factory Loc")),
                      DataColumn2(label: Text("Running Robots")),
                      DataColumn2(label: Text('Average Data')),
                    ],
                    rows: List<DataRow>.generate(
                      data.factoryList.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                              CustomText(text: data.factoryList[index].name),
                              onTap: () {
                            navigationController.navigateTo(
                                FactoryDetailPageRoute,
                                {'factory_name': data.factoryList[index].name});
                          }),
                          DataCell(CustomText(
                            text:
                                data.factoryList[index].loc ?? 'Not Specified',
                          )),
                          DataCell(CustomText(
                            text: data.factoryList[index].run_robot.toString() +
                                '/' +
                                data.factoryList[index].total_robot.toString(),
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: active, width: .5),
                                color: light,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: CustomText(
                              text: "Operation ING",
                              color: active.withOpacity(.7),
                              weight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                    ));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            }),
      ]),
    );
  }
}
