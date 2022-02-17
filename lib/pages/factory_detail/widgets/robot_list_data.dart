// ignore_for_file: prefer_const_constructors
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/controllers/navigation_controller.dart';
import 'package:flutter_app_rcs/logic/function/item.dart';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';

class RobotDataFactory extends StatelessWidget {
  final String factory_name;
  const RobotDataFactory({Key key, this.factory_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<RobotList> robotlist = getRobotList('factory', factory_name);

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
                                    text: data.robots[index].factory_name
                                        .toString(),
                                  ),
                                ),
                                DataCell(CustomText(
                                  text: data.robots[index].type,
                                )),
                                DataCell(CustomText(
                                  text: data.robots[index].ip,
                                )),
                                StatusDataCell(data.robots[index].status),
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

  DataCell StatusDataCell(int status) {
    if (status == 1) {
      return DataCell(Row(
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
      ));
    } else if (status == 2) {
      return DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: Colors.orange.shade400,
            size: 18,
          ),
          const SizedBox(width: 5),
          const CustomText(
            text: "Waiting",
          )
        ],
      ));
    } else if (status == 3) {
      return DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: Colors.yellow.shade400,
            size: 18,
          ),
          const SizedBox(width: 5),
          const CustomText(
            text: "Pause",
          )
        ],
      ));
    } else {
      return DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: Colors.red.shade400,
            size: 18,
          ),
          const SizedBox(width: 5),
          const CustomText(
            text: "Off",
          )
        ],
      ));
    }
  }
}
