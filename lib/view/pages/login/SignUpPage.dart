import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:save_order/consts/RegExp.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/view/pages/login/email_login_page.dart';
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
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isNameValid = false;
  bool isPhoneNumberValid = false;
  String SUCCESS_MESSAGE = "성공적으로 일반 가입되었습니다";

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RegExp passwordExp = RegExp(r'^(?=.*?[a-z])([A-Z])*(?=.*?[0-9]).{8,}$');
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
    if (name.length < 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text("이름을 입력해주세요.")));
      return false;
    }
    if (!phoneNumberExp.hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text(
              "형식에 맞지 않는 휴대폰 번호입니다.'-' 없이 010 혹은 020 로 시작하는 숫자 11자리 혹은 12자리를 입력해주세요.")));
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
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff00276b))),
            width: 325.w,
            height: 400.h,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 60.w,
                    height: 20.h,
                    child:
                        FittedBox(fit: BoxFit.fitHeight, child: Text("이메일"))),
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 200.w,
                    height: 40.h,
                    child: TextField(
                      onChanged: (email) {
                        if (email.length <= 30 && emailRegExp.hasMatch(email)) {
                          setState(() {
                            this.isEmailValid = true;
                          });
                        } else {
                          setState(() {
                            this.isEmailValid = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(KOREAN_WORD_REGEXP)
                      ],
                      controller: this.emailController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "이메일",
                          hintStyle: TextStyle(fontSize: 14)),
                    ))
              ]),
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 60.w,
                    height: 20.h,
                    child:
                        FittedBox(fit: BoxFit.fitHeight, child: Text("비밀번호"))),
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 200.w,
                    height: 40.h,
                    child: TextField(
                      onChanged: (password) {
                        if (password.length <= 30 &&
                            passwordExp.hasMatch(password)) {
                          setState(() {
                            this.isPasswordValid = true;
                          });
                        } else {
                          setState(() {
                            this.isPasswordValid = false;
                          });
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(KOREAN_WORD_REGEXP)
                      ],
                      obscureText: true,
                      controller: this.passwordController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "비밀번호",
                          hintStyle: TextStyle(fontSize: 14)),
                    ))
              ]),
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 60.w,
                    height: 20.h,
                    child: FittedBox(fit: BoxFit.fitHeight, child: Text("이름"))),
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 240.w,
                    height: 40.h,
                    child: TextField(
                       onChanged: (name) {
                        if (name.length <= 30) {
                          setState(() {
                            this.isNameValid = true;
                          });
                        } else {
                          setState(() {
                            this.isNameValid = false;
                          });
                        }
                      },
                      controller: this.nameControlller,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "이름",
                          hintStyle: TextStyle(fontSize: 14)),
                    ))
              ]),
              Row(children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 60.w,
                    height: 20.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight, child: Text("휴대폰 번호"))),
                Container(
                    margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                    width: 240.w,
                    height: 40.h,
                    child: TextField(
                       onChanged: (phoneNumber) {
                        if (phoneNumber.length <= 30 &&
                           phoneNumberExp.hasMatch(phoneNumber)) {
                          setState(() {
                            this.isPhoneNumberValid = true;
                          });
                        } else {
                          setState(() {
                            this.isPhoneNumberValid = false;
                          });
                        }
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: this.phoneNumberController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "휴대폰 번호",
                          hintStyle: TextStyle(fontSize: 14)),
                    ))
              ]),
              Container(
                  height: 60.h,
                  width: 200.w,
              
                    // : isEmailValid &&
                    //                               isPasswordValid &&
                    //                               isNameValid &&
                    //                               isPhoneNumberValid
                    //                           ? Colors.grey
                    //                           : Colors.white,
                  margin: EdgeInsets.only(top: 8.h),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                          
                                width: 1.w)),
                        backgroundColor:
                            MaterialStateProperty.all(
                              isEmailValid &&
                                                  isPasswordValid &&
                                                  isNameValid &&
                                                  isPhoneNumberValid
                                              ? Colors.grey
                                              : Colors.white,
                            ),
                        shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15.h))),
                      ),
                      onPressed: () async {
                        var email = emailController.text
                            .toString()
                            .replaceAll(' ', '');
                        var password = passwordController.text
                            .toString()
                            .replaceAll(' ', '');
                        var name = nameControlller.text
                            .toString()
                            .replaceAll(' ', '');
                        print(name);
                        print("nname");
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
                        Map<String, dynamic> decodedData =
                            json.decode(response.body);

                        print("response");
                        print(decodedData);

                        if (!decodedData.containsKey("msg") ||
                            decodedData["msg"] != SUCCESS_MESSAGE) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration:
                                  const Duration(milliseconds: 1000),
                              content: Text(
                                  "이미 회원 가입이 된 이메일 혹은 휴대전화입니다. 다시 입력해주세요.")));
                          return;
                        }
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

                        Get.off(() => EmailLoginPage(),
                            transition: Transition.rightToLeft);
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
                                      
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff00276b),
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.0))))))
            ]),
          ),
        ));
  }

 
}
