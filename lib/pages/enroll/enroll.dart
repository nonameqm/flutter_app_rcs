// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/auth.dart';
import 'package:flutter_app_rcs/pages/authentication/authentication.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_dialog.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class EnrollPage extends StatefulWidget {
  const EnrollPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnrollPage();
}

class _EnrollPage extends State<EnrollPage> {
  @override
  void initState() {
    super.initState();
  }

  final _company_list = ['AICO', 'SKKU'];
  final _usertype_list = ['User', 'Developer'];
  String _selected_company = 'AICO';
  String _selected_usertype = 'User';
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      iconSize: 24,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.offAllNamed(AuthenticationPageRoute);
                      },
                    )),
                Expanded(
                  child: Container(),
                )
              ]),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Enroll",
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "abc@domain.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: pwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "1234",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "010-0000-0000",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  child: Row(children: [
                CustomText(text: "Company"),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: _selected_company,
                    items: _company_list.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selected_company = value;
                      });
                    },
                    style: GoogleFonts.roboto(fontSize: 20),
                  ),
                ),
              ])),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  child: Row(children: [
                CustomText(text: "User-Type"),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: _selected_usertype,
                    items: _usertype_list.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selected_usertype = value;
                      });
                    },
                    style: GoogleFonts.roboto(fontSize: 20),
                  ),
                ),
              ])),
              SizedBox(
                height: 15,
              ),
              InkWell(
                //login method
                onTap: () {
                  UserRegister reg_info = UserRegister(
                      email: emailController.text,
                      pw: pwController.text,
                      company: _selected_company,
                      user_type: _selected_usertype,
                      phone_number: phoneController.text);
                  isEnrollPermit(reg_info);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomText(
                    text: "Enroll",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isEnrollPermit(UserRegister reg_info) {
    if (reg_info.email == '' || reg_info.email == null) {
      Get.snackbar(
        "Wrong Input",
        "Please Input email correctly",
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
      return;
    }

    if (reg_info.pw == '' || reg_info.pw == null) {
      Get.snackbar(
        "Wrong Input",
        "Please Input password correctly",
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
      return;
    }

    if (reg_info.phone_number == '' || reg_info.phone_number == null) {
      Get.snackbar(
        "Wrong Input",
        "Please Input phone_number correctly",
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
      return;
    }
    Future<http.Response> httpResponse = enroll(reg_info);
    httpResponse.then((val) {
      if (val.statusCode == 200) {
        Get.dialog(CustomDialog(
          yesTap: () {
            Get.offAllNamed(AuthenticationPageRoute);
          },
          title: 'Enroll Success',
          message: 'Move to Auth Page',
          noTap: false,
        ));
      } else {
        String msg = json.decode(val.body)['msg'].toString();
        Get.snackbar(
          "Enroll Error!",
          msg,
          snackPosition: SnackPosition.TOP,
          isDismissible: true,
        );
        return;
      }
    }).catchError((error) {
      print('error: ' + error.toString());
    });
  }
}
