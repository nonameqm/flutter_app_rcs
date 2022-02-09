import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/constants/style.dart';

class RobotInfoCard extends StatefulWidget {
  final String title;
  final String serial;
  final String type;
  final String value;
  final Color topColor;
  final bool isActive;
  final Function onTap;

  const RobotInfoCard(
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
  State<StatefulWidget> createState() => _RobotInfoCardState();
}

class _RobotInfoCardState extends State<RobotInfoCard> {
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
                height: 136,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: lightGrey.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: widget.topColor ?? active,
                          height: 5,
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${widget.title}\n",
                          style: TextStyle(
                              fontSize: 16,
                              color: widget.isActive ? active : lightGrey)),
                      TextSpan(
                          text: "${snapshot.data.toString()}\n",
                          style: TextStyle(
                              fontSize: 40,
                              color: widget.isActive ? active : dark))
                    ]),
                  )
                ]),
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
