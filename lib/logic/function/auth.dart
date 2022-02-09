// ignore_for_file: non_constant_identifier_names

import 'package:flutter_app_rcs/constants/connection.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_rcs/logic/view/model.dart';
import 'package:flutter_app_rcs/logic/function/auth.dart';
import 'dart:convert';

Future<http.Response> login(String email, String password) async {
  const String url_detail = 'auth/login/email';
  Map<String, String> data = {"email": email, "pw": password};
  final url = Uri.parse(api_server_ip + url_detail);

  final response =
      await http.post(url, headers: request_headers, body: json.encode(data));

  return response;
}

Future<http.Response> enroll(UserRegister reg_info) async {
  const String url_detail = 'register/user/email';
  Map<String, String> data = {
    "email": reg_info.email,
    "pw": reg_info.pw,
    "company": reg_info.company,
    "phone_number": reg_info.phone_number,
    "user_type": reg_info.user_type
  };

  final url = Uri.parse(api_server_ip + url_detail);
  final response =
      await http.post(url, headers: request_headers, body: json.encode(data));

  return response;
}

class UserRegister {
  String email;
  String pw;
  String company;
  String phone_number;
  String user_type;

  UserRegister(
      {this.email, this.pw, this.company, this.phone_number, this.user_type});
}
