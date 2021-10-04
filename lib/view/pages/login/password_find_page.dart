import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/util/validate.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import "package:http/http.dart" as http;

class PasswordFindPage extends StatefulWidget {
  @override
  _PasswordFindPage createState() => _PasswordFindPage();
}

class _PasswordFindPage extends State<PasswordFindPage> {
  TextEditingController? emailController;
  TextEditingController? nameController;
  bool isNextButtonDisabled = false;
  final emailFormKey = GlobalKey<FormState>();
  final nameFormKey = GlobalKey<FormState>();
  bool isNameValid = false;
  bool isEmailValid = false;

  void emailChange(String email) {
    if (email.length <= 30 && emailRegExp.hasMatch(email)) {
      setState(() {
        this.isEmailValid = true;
      });
    } else {
      setState(() {
        this.isEmailValid = false;
      });
    }
  }

  void nameChange(String name) {
    if (name.length <= 30) {
      setState(() {
        this.isNameValid = true;
      });
    } else {
      setState(() {
        this.isNameValid = false;
      });
    }
  }

  Future<bool> sendPasswordToUser() async {
    // 유저  이메일로 임시 비밀번호 보내는 api 불러오기.

    Map data = {
      "name": nameController!.text.toString().trim(),
      "email": emailController!.text.toString().trim()
    };
    var body = json.encode(data);
    var response = await http.Client().post(
      Uri.parse("https://${devMode()}.dalbodre.me/api/User/ChangePassword"),
      body: body,
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      return false;
    }
    print(data["email"]);
    print(data["email"].length);
    print("check your email");
    print(response.statusCode);
    print(json.decode(response.body));
    return true;
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
  }

  Widget inputUserInfoWidget(
      TextEditingController textEditingController,
      String infoName,
      String? Function(String?)? validatorFunction,
      void Function(String) changeFunction,
      GlobalKey<FormState> key) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 10.w),
          height: 16.h,
          width: 50.w,
          //         decoration: BoxDecoration(
          //   border: Border.all(color: const Color(0xff00276b)),

          // ),
          child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                infoName,
                style: TextStyle(
                    color: const Color(0xff222222),
                    fontFamily: "NotoSans",
                    fontSize: 14.0),
              ))),
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 240.w,
          height: 30.h,
          child: Form(
            key: key,
            child: TextFormField(
              onChanged: changeFunction,
              validator: validatorFunction,
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(36),
              ],
              controller: textEditingController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: infoName,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.3,
          centerTitle: true,
          title: Text("비밀번호 찾기",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
        ),
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
            child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff00276b)),
              borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              inputUserInfoWidget(emailController!, "이메일", emailValidate,
                  emailChange, this.emailFormKey),
              inputUserInfoWidget(nameController!, "이름", nameValidate,
                  nameChange, this.nameFormKey),
              ElevatedButton(
                  onPressed:  () async {
                          if (!this.emailFormKey.currentState!.validate() ||
                              !this.nameFormKey.currentState!.validate()) {
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 2500),
                              content: Text(
                                  "입력하신 이메일로 임시 비밀번호를 보내는 중입니다, 잠시만 기다려주세요.")));
                          final isSuccess = await this.sendPasswordToUser();
                          setState(() {
                            this.isNextButtonDisabled = true;
                          });
                          print("send email true");
                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(milliseconds: 1500),
                                content: Text("입력하신 이메일로 임시 비밀번호를 보냈습니다.")));
                            setState(() {
                              this.isNextButtonDisabled = false;
                            });
                            Get.off(LoginPage(),
                                transition: Transition.rightToLeft);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content:
                                    Text("입력하신 이메일과 이름을 가진 회원분은 존재하지 않습니다.")));
                            setState(() {
                              this.isNextButtonDisabled = false;
                            });
                          }
                        },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: const Color(0xff00276b), width: 1.w)),
                    backgroundColor: MaterialStateProperty.all(this.isEmailValid && this.isNameValid   ? Colors.grey
                                    : Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w))),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                      width: 150.w,
                      height: 20.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("다음",
                              style: TextStyle(
                                
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff00276b),
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0))))),
            ],
          ),
          width: 325.w,
          height: 300.h,
        )));
  }
}
