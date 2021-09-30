import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/view/pages/login/login_page.dart';

class ShowForgatEmailPage extends StatefulWidget {
  String? email;

  ShowForgatEmailPage(String email) {
    this.email = email;
  }

  @override
  _ShowForgatEmailPage createState() => _ShowForgatEmailPage(email!);
}

class _ShowForgatEmailPage extends State<ShowForgatEmailPage> {
  String? forgotEmail;

  _ShowForgatEmailPage(String email) {
    print(email);
    print("email");
    this.forgotEmail = email;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
          child: Container(
            height: 130.h,
            width: 320.w,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 20.h,
                        margin: EdgeInsets.only(left: 10.w),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("나의 이메일: " + this.forgotEmail!,
                              style: TextStyle(
                                  color: const Color(0xff222222),
                                  fontFamily: "NotoSans",
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 28.h,
                  child: CupertinoButton(
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.w,
                      height: 15.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("이메일 복사",
                            style: TextStyle(
                                fontFamily: "NotoSans",
                                color: Colors.white,
                                fontSize: 12)),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    color: Colors.black,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: this.forgotEmail));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                         duration: const Duration(milliseconds: 1000),
                        content: Text("이메일이 클립보드에 복사되었습니다."),
                      ));
                      print("clip board");
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 38.h,
                  width: 160.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => LoginPage());
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: const Color(0xff00276b), width: 1.w)),
                        backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.w))),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                          width: 250.w,
                          height: 20.h,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text("로그인 하러 가기",
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0))))),
                ),
              ],
            ),
          ),
        ));
  }
}
