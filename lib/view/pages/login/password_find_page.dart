import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import "package:http/http.dart" as http;

class PasswordFindPage extends StatefulWidget {
  @override
  _PasswordFindPage createState() => _PasswordFindPage();
}

class _PasswordFindPage extends State<PasswordFindPage> {
  TextEditingController? emailController;
  TextEditingController? nameController;

  Future<bool> sendPasswordToUser() async {
    // 유저  이메일로 임시 비밀번호 보내는 api 불러오기.
    Map data = {
      "name": nameController!.text.toString(),
      "email": emailController!.text.toString()
    };
    var body = json.encode(data);
    var response = await http.Client().post(
        Uri.parse("http://${devMode}.dalbodre.me/api/User/ChangePassword"));
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
    TextEditingController textEditingController, String infoName,
  ) {
   return Row(children: <Widget>[
      Container(
              margin: EdgeInsets.only(right: 10.w),
                      height: 30.h,
                      width: 50.w,
          child: FittedBox(fit: BoxFit.fitHeight, child: Text(infoName))),
      Container(
          margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
          width: 200.w,
          height: 30.h,
          child: TextFormField(
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
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
            child: Container(
          child: Column(
            children: [
              inputUserInfoWidget(emailController!, "이메일"),
              inputUserInfoWidget(nameController!, "이름"),
              ElevatedButton(
                  onPressed: () async {
                    final isSuccess = await this.sendPasswordToUser();
                    print("send email true");
                    if (isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 500),
                          content: Text("입력하신 이메일로 임시 비밀번호를 보냈습니다.")));
                      Get.to(LoginPage());
                      // 로그인 페이지에서 로그인 후 임시 비밀번호인지 확인하고,
                      // 임시 비밀번호면 변경 view 보여주기
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 500),
                          content: Text("입력하신 이메일은 유효하지 않은 이메일입니다.")));
                    }
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: const Color(0xff00276b), width: 1.w)),
                    backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w))),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                      width: 250.w,
                      height: 25.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("다음",
                              style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0))))),
            ],
          ),
          width: 325.w,
          height: 300.h,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        )));
  }
}
