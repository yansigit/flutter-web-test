import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:save_order/util/validate.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/view/pages/login/email_login_page.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
 
  String errorMsg = "";
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  final _phoneNumberFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  bool isValidFormat(
      String email, String password, String name, String phoneNumber) {
    
    if (errorMsg != "") {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff00276b))),
              width: 325.w,
              height: 400.h,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 60.w,
                          height: 20.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight, child: Text("이메일"))),
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 200.w,
                          height: 50.h,
                          child: Form(
                            key: this._emailFormKey,
                            child: TextFormField(
                              validator: (email) {
                                if (email!.length > 30 ||
                                    !emailRegExp.hasMatch(email)) {
                                  return "이메일 형식이 잘못되었습니다.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (email) {
                                if (email.length <= 30 &&
                                    emailRegExp.hasMatch(email)) {
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
                                FilteringTextInputFormatter.deny(
                                    KOREAN_WORD_REGEXP)
                              ],
                              controller: this.emailController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "이메일",
                                  hintStyle: TextStyle(fontSize: 14)),
                            ),
                          ))
                    ]),
                    Row(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 60.w,
                          height: 20.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight, child: Text("비밀번호"))),
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 200.w,
                          height: 70.h,
                          child: Form(
                            key: this._passwordFormKey,
                            child: TextFormField(
                              onChanged: (password) {
                                if (password.length <=20 &&
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
                              validator: (password) {
                                if (password!.length > 30 ||
                                    !passwordExp.hasMatch(password)) {
                                  return " 영어 소문자  혹은 대문자 1개 이상, 숫자 1개 이상 포함하는 8자리 이상의 글자를 입력해주세요.";
                                } else {
                                  return null;
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    KOREAN_WORD_REGEXP)
                              ],
                              obscureText: true,
                              controller: this.passwordController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                  border: OutlineInputBorder(),
                                  hintText: "비밀번호",
                                  hintStyle: TextStyle(fontSize: 14)),
                            ),
                          ))
                    ]),
                    Row(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 60.w,
                          height: 20.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight, child: Text("이름"))),
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 200.w,
                          height: 50.h,
                          child: Form(
                            key: this._nameFormKey,
                            child: TextFormField(
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
                              validator: (name) {
                                if (name!.length < 1) {
                                  return "이름을 한 글자 이상 적어주세요.";
                                } else {
                                  return null;
                                }
                              },
                              controller: this.nameControlller,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "이름",
                                  hintStyle: TextStyle(fontSize: 14)),
                            ),
                          ))
                    ]),
                    Row(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              right: 10.w, bottom: 8.h, left: 3.w),
                          width: 60.w,
                          height: 20.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight, child: Text("휴대폰 번호"))),
                      Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                          width: 200.w,
                          height: 60.h,
                          child: Form(
                            key: this._phoneNumberFormKey,
                            child: TextFormField(
                              validator: (phoneNumber) {
                                if (!phoneNumberExp.hasMatch(phoneNumber!)) {
                                  return '"-" 없이 010 혹은 020 으로 시작하는 숫자 11자리 혹은 12자리를 입력해주세요';
                                } else {
                                  return null;
                                }
                              },
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: this.phoneNumberController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  border: OutlineInputBorder(),
                                  hintText: "휴대폰 번호",
                                  hintStyle: TextStyle(fontSize: 14)),
                            ),
                          ))
                    ]),
                    Container(
                        height: 60.h,
                        width: 200.w,
                       
                        margin: EdgeInsets.only(top: 8.h),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(width: 1.w)),
                              backgroundColor: MaterialStateProperty.all(
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
                              if (!this
                                      ._emailFormKey
                                      .currentState!
                                      .validate() ||
                                  !this
                                      ._passwordFormKey
                                      .currentState!
                                      .validate() ||
                                  !this._nameFormKey.currentState!.validate() ||
                                  !this
                                      ._phoneNumberFormKey
                                      .currentState!
                                      .validate()) {
                                return;
                              }
                           
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

                              
                              Map<String, dynamic> decodedData =
                                  json.decode(response.body);

                              if (!decodedData.containsKey("msg") ||
                                  decodedData["msg"] != SUCCESS_MESSAGE) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    content: Text(
                                        "이미 회원 가입이 된 이메일 혹은 휴대전화입니다. 다시 입력해주세요.")));
                                return;
                              }
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  "signUpToken", decodedData["token"]);

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
                                 decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff00276b))),
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
          ),
        ));
  }
}
