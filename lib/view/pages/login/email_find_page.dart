import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/view/pages/login/login_page.dart';

class EmailFindPage extends StatefulWidget {
  @override
  _EmailFindPage createState() => _EmailFindPage();
}

class _EmailFindPage extends State<EmailFindPage> {
  TextEditingController? nameController;
  TextEditingController? phoneNumberController;
  TextEditingController? certificationNumberController;
  String? certificationNumberSended;
  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _certificationNumberFormKey = GlobalKey<FormState>();
  Future<bool> sendCertificationNumberToUser() async {
    String name = nameController!.text.toString();
    String phoneNumber = phoneNumberController!.text.toString();
    print(name);
    print(phoneNumber);
    certificationNumberSended = "12345";

    // send api
    return true;
  }

  Future<bool> verifyCertificationNumber() async {
    // 유저 휴대폰으로 보낸 인증번호 저장해서, 인증 번호가 유저가 입력한 것과 같으면 이메일 알려주기
    print(certificationNumberSended);
    print(certificationNumberController!.text.toString());
    if (certificationNumberSended ==
        certificationNumberController!.text.toString()) {
      print(certificationNumberController!.text.toString());
      print("verfi");
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneNumberController = TextEditingController();
    certificationNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
        body: Center(
            child: Container(
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
                      height: 30.h,
                      width: 50.w,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "이름: ",
                          style: TextStyle(
                              color: const Color(0xff222222),
                              fontFamily: "NotoSans",
                              fontSize: 14.0),
                        ),
                      )),
                  Container(
                      height: 30.h,
                      width: 200.w,
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
                          child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ],
                        textAlignVertical: TextAlignVertical.center,
                        style:
                            TextStyle(fontFamily: "NotoSans", fontSize: 14.0),
                        textAlign: TextAlign.center,
                        // textAlignVertical: TextAlignVertical.center,
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "이름을 입력하세요.",
                        ),
                      ))),
                ],
              )),
              Container(
                margin: EdgeInsets.only(bottom: 15.h),
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10.w),
                      alignment: Alignment.center,
                      height: 30.h,
                      width: 50.w,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "휴대폰 번호: ",
                          style: TextStyle(
                              color: const Color(0xff222222),
                              fontFamily: "NotoSans",
                              fontSize: 14.0),
                        ),
                      )),
                  Container(
                      height: 30.h,
                      width: 200.w,
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
                      child:
                     
                      Form(
                        
                         key: this._phoneNumberFormKey,
                          child: TextFormField(
                          
                        validator: (value) {
                          RegExp regExp = new RegExp(
                            "\d{10, 12}",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          if (value == null ||
                              value.isEmpty ||
                              !regExp.hasMatch(value)) {
                            return '전화번호 형식에 맞지 않습니다. ';
                          }
                          return "";
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style:
                            TextStyle(fontFamily: "NotoSans", fontSize: 14.0),
                        textAlign: TextAlign.center,
                        controller: phoneNumberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(14),
                        ],
                       
                        decoration: InputDecoration(
                          hintText: "휴대폰 번호를 입력하세요.",
                        ),
                      ))
                      )
                ],
              )),
              Container(
                  height: 30.h,
                  width: 200.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xffe8e8e8), width: 1.w),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x0c000000),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                  ),
                  child: Form(
                      key: this._certificationNumberFormKey,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style:
                            TextStyle(fontFamily: "NotoSans", fontSize: 14.0),
                        textAlign: TextAlign.center,
                        // textAlignVertical: TextAlignVertical.center,
                        controller: certificationNumberController,
                        decoration: InputDecoration(
                          hintText: "인증번호 6자리 숫자",
                        ),
                      ))),
              GestureDetector(
                onTap: () async {
                  if (!this._phoneNumberFormKey.currentState!.validate()) {
                    return;
                  }

                  bool isSuccess = await this.sendCertificationNumberToUser();
                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 1000),
                        content: Text("입력하신 이메일입니다.")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 1000),
                        content: Text("이름 혹은 휴대폰 번호를 잘못 입력하셨습니다."))
                        );
                  }
                },
                child: Container(
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
                    margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    height: 25.h,
                    width: 160.w,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("인증 번호 받기",
                            style: TextStyle(
                                backgroundColor: Colors.white,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.0)))),
              ),
              ElevatedButton(
                  onPressed: () async {
                    bool isSuccess = await this.verifyCertificationNumber();
                    if (isSuccess == true) {
                      // 이메일 보여주는 뷰

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 1000),
                          content: Text("올바르지 않은 인증번호입니다.")));
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
