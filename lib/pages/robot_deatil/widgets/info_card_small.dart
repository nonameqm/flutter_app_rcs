import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class RobotInfoCardSmall extends StatefulWidget {
  final String title;
  final String serial;
  final String type;
  final String value;
  final Color topColor;
  final bool isActive;
  final Function onTap;

  const RobotInfoCardSmall(
      {Key key,
      this.title,
      this.value,
      this.topColor,
      this.isActive,
      this.onTap,
      this.serial,
      this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RobotInfoCardSmallState();
}

class _RobotInfoCardSmallState extends State<RobotInfoCardSmall> {
  @override
  StreamController _streamController = StreamController();
  Timer _timer;
  var data;
  Future getRealData() async {
    String urlData;
    urlData = api_server_ip + 'item/realdata/';
    final url = Uri.parse(urlData);
    Map<String, dynamic> data = {
      "serial": widget.serial,
      "data_type": widget.type,
      "limit": 1
    };
    http.Response response =
        await http.post(url, headers: request_headers, body: json.encode(data));

    String jsonsDataString = response.body
        .toString(); // toString of Response's body is assigned to jsonDataString
    data = json.decode(jsonsDataString);
    //Add your data to stream
    _streamController.add(data[widget.type][0]['robot_current1'] ??
        data[widget.type][0]['robot_voltage1']);
  }

  @override
  void initState() {
    getRealData();
    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => getRealData());
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: widget.isActive ? active : lightGrey,
                        width: .5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: widget.title,
                      size: 24,
                      weight: FontWeight.w300,
                      color: widget.isActive ? active : lightGrey,
                    ),
                    CustomText(
                      text: snapshot.data.toString(),
                      size: 24,
                      weight: FontWeight.bold,
                      color: widget.isActive ? active : lightGrey,
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
