// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_rcs/constants/controllers.dart';
import 'package:flutter_app_rcs/constants/style.dart';
import 'package:flutter_app_rcs/logic/function/auth.dart';
import 'package:flutter_app_rcs/routings/routes.dart';
import 'package:flutter_app_rcs/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    menuController.activeItem = OverViewPageDisplayName.obs;
    GetStorage().remove('company');
    GetStorage().remove('user_type');
    GetStorage().remove('token');
    GetStorage().remove('email');
    final emailController = TextEditingController();
    final pwController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(children: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 12),
              //     child: Image.asset("assets/icons/logo.png"),
              //   ),
              //   Expanded(
              //     child: Container(),
              //   )
              // ]),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome to RCS",
                    color: lightGrey,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
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
              InkWell(
                //login method
                onTap: () {
                  isLoginPermit(emailController, pwController);
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
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Do not have credentials? "),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAllNamed(EnrollPageRoute);
                        },
                      text: "Enroll your account!",
                      style: TextStyle(color: active))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void isLoginPermit(TextEditingController email, TextEditingController pw) {
  if (email.text == null ||
      pw.text == null ||
      email.text == '' ||
      pw.text == '') {
    Get.snackbar(
      "Wrong Input",
      "please Fill both email or password.",
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
    );

    email.text = '';
    pw.text = '';

    return;
  }
  Future<http.Response> httpResponse = login(email.text, pw.text);
  httpResponse.then((val) {
    if (val.statusCode == 200) {
      var authInfo = json.decode(val.body);
      var companyName = authInfo['company'];
      var userType = authInfo['user_type'];
      var authToken = authInfo['authorization'];
      GetStorage('session').write('company', companyName);
      GetStorage('session').write('user_type', userType);
      GetStorage('session').write('token', authToken);
      GetStorage('session').write('email', email.text);
      Get.offAllNamed(RootRoute);
    } else {
      Get.snackbar(
        "No match User",
        "Please check your email or password again",
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
      email.text = '';
      pw.text = '';
    }
  }).catchError((error) {
    print('error: ' + error.toString());
  });
}
