// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:save_order/consts/color.dart';
// import 'package:save_order/model/model.dart';
// import 'package:save_order/view/pages/login/login_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:save_order/view/pages/login/show_forgot_email.dart';

// class EmailFindPage extends StatefulWidget {
//   @override
//   _EmailFindPage createState() => _EmailFindPage();
// }

// class _EmailFindPage extends State<EmailFindPage> {
//   TextEditingController? nameController;
//   TextEditingController? phoneNumberController;
//   //TextEditingController? certificationNumberController;
//   String? certificationNumberSended;
//   final _phoneNumberFormKey = GlobalKey<FormState>();
//   final _certificationNumberFormKey = GlobalKey<FormState>();
//   final NO_SUCH_EMAIL = "no such email";

//   // Future<bool> sendCertificationNumberToUser() async {
//   //   String name = nameController!.text.toString();
//   //   String phoneNumber = phoneNumberController!.text.toString();
//   //   print(name);
//   //   print(phoneNumber);
//   //   certificationNumberSended = "12345";

//   //   // send api
//   //   return true;
//   // }

//   Future<String> getEmail() async {
//     // 유저 휴대폰으로 보낸 인증번호 저장해서, 인증 번호가 유저가 입력한 것과 같으면 이메일 알려주기
//     String name = nameController!.text.toString().replaceAll(" ", "");
//     String phoneNumber =
//         phoneNumberController!.text.toString().replaceAll(" ", "");
//     print(name);
//     print(phoneNumber);
//     print("phoneNumber");
//     final response = await http.Client().get(Uri.parse(
//         "https://${devMode()}.dalbodre.me/api/User/FindEmail/${name}/${phoneNumber}"));
//     print(response.statusCode);
//     print("sss");
//     if (response.statusCode != 200) {
//       return NO_SUCH_EMAIL;
//     }
//     final decodedData = json.decode(utf8.decode(response.bodyBytes));

//     return decodedData["email"];
//     // /api/User/FindEmail/{Name}/{PhoneNumber}
//   }

//   @override
//   void initState() {
//     super.initState();
//     nameController = TextEditingController();
//     phoneNumberController = TextEditingController();
//     // certificationNumberController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 1.3,
//           centerTitle: true,
//           title: Text("이메일 찾기",
//               style:
//                   TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
//         ),
//         backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
//         body: Center(
//             child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: const Color(0xff00276b)),
//               borderRadius: BorderRadius.all(Radius.circular(15.w))),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                   margin: EdgeInsets.only(bottom: 5.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.only(right: 10.w),
//                           height: 30.h,
//                           width: 70.w,
//                           child: FittedBox(
//                             fit: BoxFit.fitHeight,
//                             child: Text(
//                               "이름: ",
//                               style: TextStyle(
//                                   color: const Color(0xff222222),
//                                   fontFamily: "NotoSans",
//                                   fontSize: 14.0),
//                             ),
//                           )),
//                       Container(
//                           height: 30.h,
//                           width: 200.w,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                                 color: const Color(0xffe8e8e8), width: 1.w),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: const Color(0x0c000000),
//                                   offset: Offset(0, 2),
//                                   blurRadius: 4,
//                                   spreadRadius: 0)
//                             ],
//                           ),
//                           child: Form(
//                               child: TextFormField(
//                             inputFormatters: [
//                               LengthLimitingTextInputFormatter(20),
//                             ],
//                             textAlignVertical: TextAlignVertical.center,
//                             style: TextStyle(
//                                 fontFamily: "NotoSans", fontSize: 14.0),
//                             textAlign: TextAlign.center,
//                             // textAlignVertical: TextAlignVertical.center,
//                             controller: nameController,
//                             decoration: InputDecoration(
//                               hintText: "이름을 입력하세요.",
//                             ),
//                           ))),
//                     ],
//                   )),
//               Container(
//                   margin: EdgeInsets.only(bottom: 15.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           margin: EdgeInsets.only(right: 10.w),
//                           alignment: Alignment.center,
//                           height: 30.h,
//                           width: 70.w,
//                           child: FittedBox(
//                             fit: BoxFit.fitHeight,
//                             child: Text(
//                               "휴대폰 번호: ",
//                               style: TextStyle(
//                                   color: const Color(0xff222222),
//                                   fontFamily: "NotoSans",
//                                   fontSize: 14.0),
//                             ),
//                           )),
//                       Container(
//                           height: 30.h,
//                           width: 200.w,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(
//                                 color: const Color(0xffe8e8e8), width: 1.w),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: const Color(0x0c000000),
//                                   offset: Offset(0, 2),
//                                   blurRadius: 4,
//                                   spreadRadius: 0)
//                             ],
//                           ),
//                           child: Form(
//                               key: this._phoneNumberFormKey,
//                               child: TextFormField(
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                   LengthLimitingTextInputFormatter(14),
//                                 ],
//                                 validator: (value) {
//                                   RegExp regExp = new RegExp(
//                                     "\d{10, 12}",
//                                     caseSensitive: false,
//                                     multiLine: false,
//                                   );
//                                   if (value == null ||
//                                       value.isEmpty ||
//                                       !regExp.hasMatch(value)) {
//                                     return '전화번호 형식에 맞지 않습니다. ';
//                                   }
//                                   return "";
//                                 },
//                                 textAlignVertical: TextAlignVertical.center,
//                                 style: TextStyle(
//                                     fontFamily: "NotoSans", fontSize: 14.0),
//                                 textAlign: TextAlign.center,
//                                 controller: phoneNumberController,
//                                 decoration: InputDecoration(
//                                   hintText: "휴대폰 번호를 입력하세요.",
//                                 ),
//                               )))
//                     ],
//                   )),
//               ElevatedButton(
//                   onPressed: () async {
//                     String email = await this.getEmail();
//                     if (email == NO_SUCH_EMAIL) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           duration: const Duration(milliseconds: 1000),
//                           content: Text("이름과 휴대폰 번호에 걸맞는 이메일이 존재하지 않습니다.")));
//                     } else {
//                       Get.off(() => ShowForgatEmailPage(email),
//                           transition: Transition.rightToLeft);
//                     }
//                   },
//                   style: ButtonStyle(
//                     side: MaterialStateProperty.all<BorderSide>(
//                         BorderSide(color: const Color(0xff00276b), width: 1.w)),
//                     backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.w))),
//                   ),
//                   child: Container(
//                       margin: EdgeInsets.only(
//                           right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
//                       width: 250.w,
//                       height: 25.h,
//                       child: FittedBox(
//                           fit: BoxFit.fitHeight,
//                           child: Text("다음",
//                               style: TextStyle(
//                                   backgroundColor: Colors.white,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xff00276b),
//                                   fontFamily: "NotoSans",
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 10.0))))),
//             ],
//           ),
//           width: 325.w,
//           height: 300.h,
//         )));
//   }
// }
