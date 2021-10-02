import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/view/pages/login/email_login_page.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:save_order/util/validate.dart';

class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChagePage createState() => _PasswordChagePage();
}

class _PasswordChagePage extends State<PasswordChangePage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Widget inputUserInfoWidget(
      TextEditingController textEditingController,
      String infoName,
      String? Function(String?)? validatorFunction,
      GlobalKey<FormState> key,
      {isSensitiveInfo: false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 10.w),
          height: 16.h,
          width: 50.w,
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
              validator: validatorFunction,
              obscureText: isSensitiveInfo,
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: [
                FilteringTextInputFormatter.deny(KOREAN_WORD_REGEXP),
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.3,
          centerTitle: true,
          title: Text("비밀번호 변경하기",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
        ),
        body: Center(
            child: Container(
          width: 325.w,
          height: 300.h,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff00276b)),
              borderRadius: BorderRadius.circular(15.h)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              inputUserInfoWidget(
                  emailController!, "이메일", emailValidate, emailFormKey),
              inputUserInfoWidget(passwordController!, "비밀번호", passwordValidate,
                  passwordFormKey,
                  isSensitiveInfo: true),
              // inputUserInfoWidget(passwordController, "비밀번호", passwordValidate,)
              //inputUserInfoWidget(passwordController!, "비밀번호", isSensitiveInfo: true),
              Container(
                  height: 30.h,
                  margin: EdgeInsets.only(top: 8.h),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: const Color(0xff00276b), width: 1.w)),
                        backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.h))),
                      ),
                      onPressed: () async {
                        // /api/User/ChangePassword/Token
                        // token 과 password 입력받음.
                        if (!this.emailFormKey.currentState!.validate() ||
                            !this.passwordFormKey.currentState!.validate()) {
                          return;
                        }
                        UserController userController = Get.find();

                        String? token = userController.userToken.toString();
                        if (token == "") {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          token = sharedPreferences.getString("signUpToken");
                        }

                        Map data = {
                          "token": token,
                          "password": passwordController!.text.toString().trim()
                        };

                        var body = json.encode(data);
                        var response = await http.Client().post(
                            Uri.parse(
                                "http://${devMode()}.dalbodre.me/api/User/ChangePassword/Token"),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: body);
                        print(response.body);
                        print(response.statusCode);
                        final decodedToken = json.decode(response.body);

                        if (response.statusCode != 200 ||
                            decodedToken["statis"] == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("이메일을 잘못 입력하셨습니다."),
                              duration: const Duration(milliseconds: 1000)));
                        } else {
                          print('new password');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("비밀번호 변경이 완료되었습니다."),
                              duration: const Duration(milliseconds: 1000)));
                          Get.off(() => LoginPage(),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                          width: 250.w,
                          height: 30.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text("비밀변호 변경 완료",
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff00276b),
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0))))))
            ],
          ),
        )));
  }
}
