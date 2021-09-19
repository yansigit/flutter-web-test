import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_order/state/controllers.dart';

class CardPage extends StatelessWidget {
  List<FocusNode> cardFocusNodeList = List.generate(4, (index) => FocusNode());
  List<FocusNode> validationFocusNodeList = List.generate(2, (index) => FocusNode());
  FocusNode cvcFocusNode = FocusNode();

  List<TextEditingController> cardTextController = List.generate(4, (i) => TextEditingController());
  List<TextEditingController> validationTextController = List.generate(2, (i) => TextEditingController());
  TextEditingController cvcController = TextEditingController();

  final CardController cardController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카드 결제", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Get.back(), icon: SvgPicture.asset("assets/icons/backIcon.svg", color: Colors.black)),
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
                height: 200.h,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xff00276b)),
                  borderRadius: BorderRadius.all(Radius.circular(15.h)),
                  color: Color(0xa0fef7ed),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
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
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      controller: cardTextController[0],
                                      //focusnode
                                      focusNode: cardFocusNodeList[0],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[0].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff00276b))),
                                      ),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                                      //focusnode
                                      controller: cardTextController[1],
                                      focusNode: cardFocusNodeList[1],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[1].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff00276b))),
                                      ),
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                                      cursorColor: Color(0xff00277b),
                                      obscureText: true,
                                      keyboardType: TextInputType.number,
                                      //focusnode
                                      controller: cardTextController[2],
                                      focusNode: cardFocusNodeList[2],
                                      onChanged: (text) {
                                        if (text.length == 4) {
                                          cardFocusNodeList[2].nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: TextField(
                                      maxLength: 4,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        isDense: true,
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff00276b))),
                                      ),
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                                      cursorColor: Color(0xff00277b),
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      //focusnode
                                      controller: cardTextController[3],
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 23.h,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "유효기간",
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30.w,
                                            height: 50.h,
                                            child: TextFormField(
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: "월",
                                                hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
                                                counterText: "",
                                                isDense: true,
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xff00276b),
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                                              cursorColor: Color(0xff00277b),
                                              controller: validationTextController[0],
                                              keyboardType: TextInputType.none,
                                              focusNode: validationFocusNodeList[0],
                                              onTap: (() {
                                                showCupertinoModalPopup(
                                                  barrierColor: Color(0xa0000000),
                                                  context: context,
                                                  builder: (_) => Container(
                                                      width: double.infinity,
                                                      height: ScreenUtil().screenHeight / 3,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(15.h),
                                                            topRight: Radius.circular(15.h),
                                                          )),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 40.h,
                                                            color: Colors.transparent,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Material(
                                                                      child: FittedBox(
                                                                          fit: BoxFit.fitHeight,
                                                                          child: Text("월 선택",
                                                                              style: TextStyle(
                                                                                fontFamily: "Noto Sans",
                                                                                //fontWeight: FontWeight.w700,
                                                                                fontSize: 17.sp,
                                                                              )))),
                                                                  Material(
                                                                      child: GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(context, rootNavigator: true).pop();
                                                                      validationFocusNodeList[0].unfocus();
                                                                    },
                                                                    child: FittedBox(
                                                                        fit: BoxFit.fitHeight,
                                                                        child: Text("완료",
                                                                            style: TextStyle(
                                                                              fontFamily: "Noto Sans",
                                                                              color: Color(0xff2f5c9c),
                                                                              fontSize: 17.sp,
                                                                            ))),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              color: Color(0x10000000),
                                                              child: Picker(
                                                                mode: 0,
                                                                controller: validationTextController[0],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              }),
                                              //focusnode
                                            ),
                                          ),
                                          Container(
                                            width: 15.w,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "/",
                                              style: TextStyle(fontSize: 20.sp),
                                            ),
                                          ),
                                          Container(
                                            width: 43.w,
                                            height: 50.h,
                                            child: TextFormField(
                                              maxLength: 4,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: "연도",
                                                hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
                                                counterText: "",
                                                isDense: true,
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xff00276b),
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                                              cursorColor: Color(0xff00277b),
                                              keyboardType: TextInputType.none,
                                              focusNode: validationFocusNodeList[1],
                                              controller: validationTextController[1],
                                              onTap: (() {
                                                showCupertinoModalPopup(
                                                  barrierColor: Color(0xa0000000),
                                                  context: context,
                                                  builder: (_) => Container(
                                                      width: double.infinity,
                                                      height: ScreenUtil().screenHeight / 3,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(15.h),
                                                            topRight: Radius.circular(15.h),
                                                          )),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: double.infinity,
                                                            height: 40.h,
                                                            color: Colors.transparent,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Material(
                                                                      child: FittedBox(
                                                                          fit: BoxFit.fitHeight,
                                                                          child: Text("연도 선택",
                                                                              style: TextStyle(
                                                                                fontFamily: "Noto Sans",
                                                                                //fontWeight: FontWeight.w700,
                                                                                fontSize: 17.sp,
                                                                              )))),
                                                                  Material(
                                                                      child: GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(context, rootNavigator: true).pop();
                                                                      validationFocusNodeList[1].unfocus();
                                                                    },
                                                                    child: FittedBox(
                                                                        fit: BoxFit.fitHeight,
                                                                        child: Text("완료",
                                                                            style: TextStyle(
                                                                              fontFamily: "Noto Sans",
                                                                              color: Color(0xff2f5c9c),
                                                                              fontSize: 17.sp,
                                                                            ))),
                                                                  )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              color: Color(0x10000000),
                                                              child: Picker(
                                                                mode: 1,
                                                                controller: validationTextController[1],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 23.h,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "CVC",
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 40.w,
                                        height: 30.h,
                                        child: TextField(
                                          maxLength: 3,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff00276b))),
                                          ),
                                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                                          cursorColor: Color(0xff00277b),
                                          obscureText: true,
                                          keyboardType: TextInputType.number,
                                          focusNode: cvcFocusNode,
                                          controller: cvcController,
                                          onChanged: (text) {
                                            if (text.length == 3) {
                                              cvcFocusNode.unfocus();
                                            }
                                          },
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
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        String cardNum = "";
                        String cardVal = "";
                        for (int i = 0; i < cardTextController.length; i++) {
                          if (cardTextController[i].text.isEmpty) {
                            Get.defaultDialog(title: "카드 정보 오류", middleText: "카드번호를 확인하세요.");
                            break;
                          }
                          cardNum += cardTextController[i].text;
                        }
                        if (validationTextController[0].text.isEmpty || validationTextController[1].text.isEmpty) {
                          Get.defaultDialog(title: "카드 정보 오류", middleText: "유효기간을 확인하세요.");
                        } else {
                          cardVal += validationTextController[0].text;
                          cardVal += validationTextController[1].text[2];
                          cardVal += validationTextController[1].text[3];
                        }
                        if (cvcController.text.isEmpty) {
                          Get.defaultDialog(title: "카드 정보 오류", middleText: "CVC 코드를 확인하세요.\nCVC 코드는 카드 뒷면 서명란에 있습니다.");
                        } else if (cvcController.text.length != 3) {
                          Get.defaultDialog(title: "카드 정보 오류", middleText: "CVC 코드를 확인하세요.\nCVC 코드는 카드 뒷면 서명란에 있습니다.");
                        }
                        if (cardNum.isNotEmpty && cardVal.isNotEmpty) {
                          cardController.updateCardInfo(cardNum);
                          cardController.updateCardValidation(cardVal);
                        }
                        print(cardController.cardNum.value);
                        print(cardController.cardValidation.value);
                      },
                      child: Container(width: 70.w, height: 40.h, child: FittedBox(fit: BoxFit.contain, child: Text("결제하기")))),
                  SizedBox(width: 10.w),
                  OutlinedButton(
                      onPressed: () => print("click"),
                      child: Container(width: 70.w, height: 40.h, child: FittedBox(fit: BoxFit.contain, child: Text("사진찍어\n카드입력")))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Picker extends StatefulWidget {
  final mode;
  final TextEditingController controller;

  Picker({
    Key? key,
    required this.mode,
    required this.controller,
  }) : super(key: key);

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  String _selectedVal = "";
  late List<Text> monthList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mode == 0) {
      monthList = List.generate(12, (index) => Text((index + 1).toString(), style: TextStyle(fontSize: 23.sp)));
    } else {
      monthList = List.generate(10, (index) => Text((index + 2021).toString(), style: TextStyle(fontSize: 23.sp)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
        itemExtent: 27.h,
        onSelectedItemChanged: (val) {
          setState(() {
            if (widget.mode == 0) {
              _selectedVal = val / 10 < 1 ? "0" + (val + 1).toString() : (val + 1).toString();
            } else {
              _selectedVal = (val + 2021).toString();
            }

            widget.controller.text = _selectedVal;
          });
        },
        children: monthList);
  }
}
