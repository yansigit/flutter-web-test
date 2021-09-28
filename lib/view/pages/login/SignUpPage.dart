import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/view/pages/login/login_page.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpPage createState() => SignUpPage();
}

class SignUpPage extends State<SignUp> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameControlller = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: new Container(
          margin: EdgeInsets.only(top: 50.h, left: 10.w, right: 10.w),
          child: Column(children: <Widget>[
            inputUserInfoWidget(emailController, "이메일"),
            inputUserInfoWidget(passwordController, "비밀번호", isSensitiveInfo: true),
            inputUserInfoWidget(nameControlller, "이름"),
            inputUserInfoWidget(phoneNumberController, "휴대폰 번호"),
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 30.w, right: 16.w),
              child: Row(
                children: <Widget>[
                  Container(
                      height: 30.h,
                      margin: EdgeInsets.only(left: 8.w, top: 8.h),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                    color: const Color(0xff00276b),
                                    width: 1.w)),
                            backgroundColor:
                                MaterialStateProperty.all(EMAIL_COLOR),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(loginRaiusSize))),
                          ),
                          onPressed: () async {
                            var email = emailController.text.toString();
                            var password = passwordController.text.toString();
                            var name = nameControlller.text.toString();
                            var phoneNumber =
                                phoneNumberController.text.toString();
                            print(email);
                            print(password);
                            Map data = {
                              "email": email,
                              "password": password,
                              "name": name,
                              "phoneNumber": phoneNumber
                            };
                            var body = json.encode(data);
                            var response = await http.Client().post(
                                Uri.parse(
                                    "http://${devMode()}.dalbodre.me/api/User/Register"),
                                headers: <String, String>{
                                  'Content-Type': 'application/json'
                                },
                                body: body);
                            print(response.statusCode);
                            print(json.decode(response.body));
                            Get.to(() => LoginPage());
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: 10.w,
                                  bottom: 8.h,
                                  top: 10.h,
                                  left: 10.w),
                              width: 250.w,
                              height: 30.h,
                              child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text("회원 가입 완료",
                                      style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.blue,
                                          fontFamily: "NotoSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0))))))
                ],
              ),
            )
          ]),
        ));
  }

  Widget inputUserInfoWidget(
      TextEditingController textEditingController, String infoName,
      {isSensitiveInfo: false}) {
    return Row(children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 100.w,
          height: 20.h,
          child: FittedBox(fit: BoxFit.fitHeight, child: Text(infoName))),
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 230.w,
          height: 30.h,
          child: TextField(
            obscureText: isSensitiveInfo,
            controller: textEditingController,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: infoName,
                hintStyle: TextStyle(fontSize: 14)),
          ))
    ]);
  }
}
