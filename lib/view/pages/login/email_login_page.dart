import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import "package:http/http.dart" as http;
import 'package:save_order/model/model.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';
import 'package:save_order/widget/bottom_nav.dart';

class EmailLoginPage extends StatefulWidget {
  EmailLoginPage({Key? key}) : super(key: key);

  @override
  _EmailLoginPage createState() => _EmailLoginPage();
}

class _EmailLoginPage extends State<EmailLoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  String? userInfo = ""; //user의 정보를 저장하기 위한 변수
  String? token = "";

  static final storage = new FlutterSecureStorage();
  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)

    userInfo = await storage.read(key: "login");
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      var email = userInfo!.split(" ")[1];
      var password = userInfo!.split(" ")[3];
      var token = userInfo!.split(" ")[5];
      emailController!.text = email;
      passwordController!.text = password;
      this.token = token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
                width: 230.w,
                height: 30.h,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                   hintText: "이메일을 입력하세요."),
                )),
            Container(
              margin: EdgeInsets.only(right: 10.w, bottom: 8.h),
              width: 230.w,
              height: 30.h,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                   hintText: "비밀번호를 입력하세요."),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: const Color(0xff00276b), width: 1.w)),
                  backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(loginRaiusSize))),
                ),
                onPressed: () async {
                  // write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                  //{"login" : "id id_value password password_value"}
                  //와 같은 형식으로 저장이 된다고 생각을 하면 됩니다.

                  if (userInfo == null) {
                    Map data = {
                      "email": emailController!.text.toString(),
                      "password": passwordController!.text.toString()
                    };
               
                    var body = json.encode(data);
                    var response = await http.Client().post(
                        Uri.parse(
                            "http://${devMode()}.dalbodre.me/api/User/Login"),
                        headers: <String, String>{
                                  'Content-Type': 'application/json'
                                },
                        body: body);
                
                    final decodedToken = json.decode(response.body);
                    this.token = decodedToken["token"];
                    if (this.token!.length == 0) {
                    
                      return;
                    }
                    await storage.write(
                        key: "login",
                        value: "id " +
                            emailController!.text.toString() +
                            " " +
                            "password " +
                            passwordController!.text.toString() +
                            " " +
                            "token " +
                            this.token!);
                  }
                  Get.to(() => BottomNav(initialValue: 0));

                  // Navigator.pushReplacement(/
                  //   context,
                  //   CupertinoPageRoute(
                  //       builder: (context) => LogOutPage(
                  //             id: idController.text,
                  //             pass: passController.text,
                  //           )),
                  // );
                },
                child: Container(
                    margin: EdgeInsets.only(
                        right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                    width: 250.w,
                    height: 25.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("로그인",
                            style: TextStyle(
                                backgroundColor: Colors.white,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0)))))
          ],
        ),
      ),
    );
  }
}
