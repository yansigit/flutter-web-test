import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import "package:http/http.dart" as http;
import 'package:save_order/model/model.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/util/validate.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';
import 'package:save_order/view/pages/login/email_find_page.dart';
import 'package:save_order/view/pages/login/password_chage_page.dart';
import 'package:save_order/view/pages/login/password_find_page.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailLoginPage extends StatefulWidget {
  EmailLoginPage({Key? key}) : super(key: key);

  @override
  _EmailLoginPage createState() => _EmailLoginPage();
}

class _EmailLoginPage extends State<EmailLoginPage> {
  UserController userController = Get.put(UserController());
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  String? userInfo = ""; //user의 정보를 저장하기 위한 변수
  String token = "";
  static SharedPreferences? sharedPreferences;
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
  
    sharedPreferences = await SharedPreferences.getInstance();

    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)

    String? token = await sharedPreferences!.getString("token");
  
    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (token != null && token.length != 0) {
      // emailController!.text =
      //     sharedPreferences!.getString("email").toString().trim();
      // passwordController!.text =
      //     sharedPreferences!.getString("password").toString().trim();
      this.token = token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/backIcon.svg",
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1.3,
        centerTitle: true,
        title: Text("이메일로 로그인",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
      ),
      body: Center(
        child: Container(
          width: 325.w,
          height: 300.h,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff00276b)),
              borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.w),
                          height: 20.h,
                          width: 60.w,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "이메일: ",
                              style: TextStyle(
                                  color: const Color(0xff222222),
                                  fontFamily: "NotoSans",
                                  fontSize: 14.0),
                            ),
                          )),
                      Container(
                          height: 50.h,
                          width: 240.w,
                          margin: EdgeInsets.only(bottom: 8.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0xffe8e8e8), width: 1.w),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x0c000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Form(
                            key: this._emailFormKey,
                            child: TextFormField(
                              validator: emailValidate,
                              textAlignVertical: TextAlignVertical.center,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    KOREAN_WORD_REGEXP),
                                LengthLimitingTextInputFormatter(36),
                              ],
                              style: TextStyle(
                                  fontFamily: "NotoSans", fontSize: 14.0),
                              textAlign: TextAlign.center,
                              // textAlignVertical: TextAlignVertical.center,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "이메일을 입력하세요.",
                              ),
                            ),
                          )),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.w),
                          height: 20.h,
                          width: 60.w,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                "비밀번호: ",
                                style: TextStyle(
                                    color: const Color(0xff222222),
                                    fontFamily: "NotoSans",
                                    fontSize: 14.0),
                              ))),
                      Container(
                          height: 50.h,
                          width: 240.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0xffe8e8e8), width: 1.w),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x0c000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0)
                            ],
                          ),
                          child: Form(
                            key: this._passwordFormKey,
                            child: TextFormField(
                              validator: passwordValidate,
                              obscureText: true,
                              textAlignVertical: TextAlignVertical.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20),
                                FilteringTextInputFormatter.deny(
                                    KOREAN_WORD_REGEXP),
                              ],
                              style: TextStyle(
                                  fontFamily: "NotoSans", fontSize: 14.0),
                              textAlign: TextAlign.center,
                              // textAlignVertical: TextAlignVertical.center,
                              // 비밀번호 입력할 때 스페이스바 지우기
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "비밀번호를 입력하세요.",
                              ),
                            ),
                          )),
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: const Color(0xff00276b), width: 1.w)),
                    backgroundColor: MaterialStateProperty.all(
                        isEmailValid && isPasswordValid
                            ? Colors.grey
                            : Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(loginRaiusSize))),
                  ),
                  onPressed: () async {
                    if (!this._emailFormKey.currentState!.validate() ||
                        !this._passwordFormKey.currentState!.validate()) {
                      return;
                    }
                    Map data = {
                      "email": emailController!.text.toString().trim(),
                      "password": passwordController!.text.toString().trim()
                    };

                    var body = json.encode(data);
                    var response = await http.Client().post(
                        Uri.parse(
                            "http://${devMode()}.dalbodre.me/api/User/Login"),
                        headers: <String, String>{
                          'Content-Type': 'application/json'
                        },
                        body: body);

                    if (response.statusCode != 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("이메일 혹은 비밀번호를 잘못 입력하셨습니다."),
                          duration: const Duration(milliseconds: 1000)));
                      return;
                    }
                    final decodedToken = json.decode(response.body);

                    this.token = decodedToken["token"];

                    bool isTempPassword = decodedToken["isTempPassword"]
                            .toString()
                            .toLowerCase() ==
                        'true';

                    if (isTempPassword == true) {
                      Get.to(() => PasswordChangePage());
                      return;
                    }

                    if (sharedPreferences == null) {
                      sharedPreferences = await SharedPreferences.getInstance();
                    }

                    await sharedPreferences!.setString("email",
                        emailController!.text.toString().replaceAll(" ", ""));

                    // await sharedPreferences!.setString(
                    //     "password", passwordController!.text.toString());
                    await sharedPreferences!.setString("token", this.token);

                    if (this.token.length != 0) {
                      userController.updateUserInfo(
                          emailController!.text.toString(), this.token);
                    }
                    Get.off(() => NearStoresPage(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                      width: 200.w,
                      height: 20.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("로그인",
                              style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff00276b),
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0))))),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 25.h,
                        child: GestureDetector(
                            onTap: () {
                              Get.to(EmailFindPage());
                            },
                            child: Text("이메일 찾기")),
                      ),
                      Container(height: 25.h, child: Text("|")),
                      Container(
                        height: 25.h,
                        child: GestureDetector(
                            onTap: () {
                              Get.to(PasswordFindPage());
                            },
                            child: Text("비밀번호 찾기")),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
