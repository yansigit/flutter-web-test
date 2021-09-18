import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class CardPage extends StatelessWidget {
  List<FocusNode> cardFocusNodeList = List.generate(4, (index) => FocusNode());

  List<TextEditingController> cardTextController =
      List.generate(4, (i) => TextEditingController());


  // List<FocusNode> validationDateFocusNodeList =
  //     List.generate(2, (index) => FocusNode());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카드 결제",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset("assets/icons/backIcon.svg",
                color: Colors.black)),
        elevation: 2.0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25.h,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "카드 정보 입력",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                width: double.infinity,
                height: 230.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xff00276b)),
                  borderRadius: BorderRadius.all(Radius.circular(15.h)),
                  color: Color(0xa0fef7ed),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w, vertical: 15.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                height: 23.h,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "카드번호",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xff00276b),
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      //focusnode
                                      focusNode: cardFocusNodeList[0],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[0].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Text("-",
                                          style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xff00276b))),
                                      ),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp),
                                      //focusnode
                                      focusNode: cardFocusNodeList[1],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[1].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Text("-",
                                          style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xff00276b))),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp),
                                      cursorColor: Color(0xff00277b),
                                      obscureText: true,
                                      keyboardType: TextInputType.number,
                                      //focusnode
                                      focusNode: cardFocusNodeList[2],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[2].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      child: Text("-",
                                          style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xff00276b))),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      //focusnode
                                      focusNode: cardFocusNodeList[3],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[3].unfocus();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 23.h,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "유효기간",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          
                                          // Container(
                                          //   width: 30.w,
                                          //   height: 50.h,
                                          //   child: TextFormField(
                                          //     maxLength: 2,
                                          //     textAlign: TextAlign.center,
                                          //     decoration: InputDecoration(
                                          //       hintText: "월",
                                          //       hintStyle: TextStyle(
                                          //           fontWeight: FontWeight.w400,
                                          //           fontSize: 15.sp),
                                          //       counterText: "",
                                          //       isDense: true,
                                          //       focusedBorder:
                                          //           UnderlineInputBorder(
                                          //         borderSide: BorderSide(
                                          //           width: 1,
                                          //           color: Color(0xff00276b),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     style: TextStyle(
                                          //         fontWeight: FontWeight.w700,
                                          //         fontSize: 16.sp),
                                          //     cursorColor: Color(0xff00277b),
                                          //     keyboardType:
                                          //         TextInputType.number,
                                          //     //focusnode
                                          //     focusNode:
                                          //         validationDateFocusNodeList[
                                          //             0],
                                          //     onChanged: (text) {
                                          //       if (text.length == 2) {
                                          //         validationDateFocusNodeList[0]
                                          //             .nextFocus();
                                          //       }
                                          //     },
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: 15.w,
                                          //   alignment: Alignment.center,
                                          //   child: Text(
                                          //     "/",
                                          //     style: TextStyle(fontSize: 20.sp),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: 30.w,
                                          //   height: 50.h,
                                          //   child: TextFormField(
                                          //     maxLength: 2,
                                          //     textAlign: TextAlign.center,
                                          //     decoration: InputDecoration(
                                          //       hintText: "연도",
                                          //       hintStyle: TextStyle(
                                          //           fontWeight: FontWeight.w400,
                                          //           fontSize: 15.sp),
                                          //       counterText: "",
                                          //       isDense: true,
                                          //       focusedBorder:
                                          //           UnderlineInputBorder(
                                          //         borderSide: BorderSide(
                                          //           width: 1,
                                          //           color: Color(0xff00276b),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     style: TextStyle(
                                          //         fontWeight: FontWeight.w700,
                                          //         fontSize: 16.sp),
                                          //     cursorColor: Color(0xff00277b),
                                          //     keyboardType:
                                          //         TextInputType.number,
                                          //     //focusnode
                                          //     focusNode:
                                          //         validationDateFocusNodeList[
                                          //             1],
                                          //     onChanged: (text) {
                                          //       if (text.length == 2) {
                                          //         validationDateFocusNodeList[1]
                                          //             .unfocus();
                                          //       }
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Container(
                                        height: 25.h,
                                        child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                                "월 두자리, 년도 두자리로 입력해주세요.\n예시)2021년 09월의 경우, 09/21")),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 23.h,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "CVC",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
