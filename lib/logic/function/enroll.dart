import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/constants/connection.dart';

Future<http.Response> register_factory(Object reg_info) async {
  const String url_detail = 'register/factory';
  final url = Uri.parse(api_server_ip + url_detail);

  final response = await http.post(url,
      headers: request_headers, body: json.encode(reg_info));

  return response;
}

Future<http.Response> register_robot(Object reg_info) async {
  const String url_detail = 'register/robot';
  final url = Uri.parse(api_server_ip + url_detail);

  final response = await http.post(url,
      headers: request_headers, body: json.encode(reg_info));

  return response;
}

Future<http.Response> send_command(
    String command_type, Object command_data) async {
  String url_detail = 'robot/send_command/' + command_type;
  final url = Uri.parse(api_server_ip + url_detail);

  final response = await http.post(url,
      headers: request_headers, body: json.encode(command_data));
  return response;
}
