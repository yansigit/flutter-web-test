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

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordExp = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  RegExp phoneNumberExp = RegExp(r'^(0[12]0)([0-9]{3,4})([0-9]{4})$');
  @override
  void initState() {
    super.initState();
  }

  bool isValidFormat(
      String email, String password, String name, String phoneNumber) {
    if (email.length >= 31 || !emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text("형식에 맞지 않는 이메일입니다. 다시 입력해 주세요.")));
      return false;
    }
    if (password.length >= 101 || !passwordExp.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text(
              "형식에 맞지 않는 비밀번호입니다. 영어 소문자를 적어도 1개 이상, 숫자를 적어도 1개 이상 포함하는 8자리 글자를 입력해주세요.")));
      return false;
    }
    if (name.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text("이름을 입력해주세요.")));
      return false;
    }
    if (!phoneNumberExp.hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text("형식에 맞지 않는 휴대폰 번호입니다.'-' 없이 숫자를 입력해주세요.")));
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
          child: Container(
            width: 325.w,
            height: 400.h,
            child: Column(children: <Widget>[
              inputUserInfoWidget(emailController, "이메일"),
              inputUserInfoWidget(passwordController, "비밀번호",
                  isSensitiveInfo: true),
              inputUserInfoWidget(nameControlller, "이름"),
              inputUserInfoWidget(phoneNumberController, "휴대폰 번호"),
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                child: Row(
                  children: <Widget>[
                    Container(
                        height: 30.h,
                        margin: EdgeInsets.only(top: 8.h),
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
                                      borderRadius: BorderRadius.circular(
                                          15.h))),
                            ),
                            onPressed: () async {
                              var email =
                                  emailController.text.toString().trim();
                              var password = passwordController.text.toString()
                                ..trim();
                              var name = nameControlller.text.toString().trim();
                              var phoneNumber =
                                  phoneNumberController.text.toString().trim();
                              if (!isValidFormat(
                                  email, password, name, phoneNumber)) {
                                return;
                              }
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      content: Text("회원가입이 완료되셨습니다.")));
                              emailController.text = "";
                              passwordController.text = "";
                              phoneNumberController.text = "";
                              nameControlller.text = "";

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
          ),
        ));
  }

  Widget inputUserInfoWidget(
      TextEditingController textEditingController, String infoName,
      {isSensitiveInfo: false}) {
    return Row(children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 60.w,
          height: 20.h,
          child: FittedBox(fit: BoxFit.fitHeight, child: Text(infoName))),
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 240.w,
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
