import 'dart:async';
import 'dart:convert';
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/pages/robot_deatil/widgets/test_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:flutter_app_rcs/constants/style.dart';

class CommandData extends StatefulWidget {
  final String serial;

  const CommandData({
    Key key,
    this.serial,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CommandDataState();
}

class _CommandDataState extends State<CommandData> {
  StreamController _streamController = StreamController();
  Timer _timer;
  var data;

  Future get_order_info() async {
    String urlData;
    urlData = api_server_ip + 'item/order_info/' + widget.serial;
    final url = Uri.parse(urlData);
    http.Response response = await http.get(url, headers: request_headers);
    if (response.statusCode == 200) {
      String jsonsDataString = response.body
          .toString(); // toString of Response's body is assigned to jsonDataString
      data = json.decode(jsonsDataString);
      //Add your data to stream
      _streamController.add(data);
    }
  }

  @override
  void initState() {
    get_order_info();
    _timer =
        Timer.periodic(const Duration(seconds: 5), (timer) => get_order_info());
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    TestInfo(
                      title: "Prvious Command",
                      amount: "${snapshot.data['prev_order'].toString()}\n",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TestInfo(
                      title: "Command Info",
                      amount: "${snapshot.data['order_info'].toString()}\n",
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    TestInfo(
                      title: "Present Command",
                      amount: "Command Name",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    TestInfo(
                      title: "Command Info",
                      amount: "Command Data",
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
