import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/constants/connection.dart';

Future<RobotList> getRobotList(String type, String name) async {
  String urlData;
  if (type == 'company') {
    urlData = api_server_ip + 'item/robot/' + '?company=' + name;
  } else if (type == 'factory') {
    urlData = api_server_ip + 'item/robot/' + '?factory=' + name;
  } else {
    throw Exception('Incorrect Parameter');
  }

  final url = Uri.parse(urlData);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return RobotList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<RobotDataList> getRobotData(String serial) async {
  String urlData;
  urlData = api_server_ip + 'realdata';
  Map<String, String> data = {"serial": serial};

  final url = Uri.parse(urlData);
  final response =
      await http.post(url, headers: request_headers, body: json.encode(data));

  if (response.statusCode == 200) {
    return RobotDataList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<FactoryList> getFactoryList(String company_name) async {
  String urlData;
  urlData = api_server_ip + 'item/factory/' + '?company=' + company_name;
  final url = Uri.parse(urlData);
  final response = await http.get(url);
  print('check2');
  if (response.statusCode == 200) {
    return FactoryList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<MethodList> getMethodList(String name) async {
  String urlData;
  if (name == null) {
    urlData = api_server_ip + 'item/method/';
  } else {
    urlData = api_server_ip + 'item/method/' + '?method_name=' + name;
  }

  final url = Uri.parse(urlData);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return MethodList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load method data');
  }
}

//http response

Future<http.Response> http_getRobotType() async {
  String urlData;
  urlData = api_server_ip + 'item/robottype/';

  final url = Uri.parse(urlData);
  final response = await http.get(url, headers: request_headers);

  return response;
}

Future<http.Response> http_getFactoryList(String company_name) async {
  String urlData;
  urlData = api_server_ip + 'item/factory/' + '?company=' + company_name;

  final url = Uri.parse(urlData);
  final response = await http.get(url, headers: request_headers);

  return response;
}

Future<http.Response> http_getMethodList(String name) async {
  String urlData;
  if (name == null) {
    urlData = api_server_ip + 'item/method/';
  } else {
    urlData = api_server_ip + 'item/method/' + '?method_name=' + name;
  }

  final url = Uri.parse(urlData);
  final response = await http.get(url);

  return response;
}
