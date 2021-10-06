// import 'package:card_scanner/card_scanner.dart';
// import 'package:card_scanner/models/card_details.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/now_payment.dart';
import 'package:save_order/page/orderstatus_page.dart';
import 'package:save_order/state/controllers.dart';
import 'package:http/http.dart' as http;
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:url_launcher/url_launcher.dart';

class CardPage extends StatefulWidget {
  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<FocusNode> cardFocusNodeList = List.generate(4, (index) => FocusNode());
  List<FocusNode> validationFocusNodeList = List.generate(2, (index) => FocusNode());
  FocusNode cvcFocusNode = FocusNode();
  List<TextEditingController> cardTextController = List.generate(4, (i) => TextEditingController());
  List<TextEditingController> validationTextController = List.generate(2, (i) => TextEditingController());
  TextEditingController cvcController = TextEditingController();

  final CardController cardController = Get.put(CardController());
  final ShoppingCartController shoppingCartController = Get.find();
  final ShopController shopController = Get.find();
  final CouponController couponController = Get.find();
  final TakeOutController takeOutController = Get.find();
  // final UserController userController = Get.find();
  final OrderController orderController = Get.put(OrderController());

  String errorMsg = "";

  final _formCardKey0 = GlobalKey<FormState>();
  final _formCardKey1 = GlobalKey<FormState>();
  final _formCardKey2 = GlobalKey<FormState>();
  final _formCardKey3 = GlobalKey<FormState>();

  // CardDetails _cardDetails = new CardDetails();
  // CardScanOptions scanOptions = CardScanOptions(
  //   scanCardHolderName: false,
  //   scanExpiryDate: true,
  //   validCardsToScanBeforeFinishingScan: 7,
  //   cardScannerTimeOut: 0,
  // );

  // Future<void> scanCard() async {
  //   var cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
  //   if (!mounted) return;
  //   setState(() {
  //     _cardDetails = cardDetails as CardDetails;
  //   });
  // }
  _launchURL() async {
    const url = "https://docs.google.com/forms/d/e/1FAIpQLSeC3i15imSGErTtzrb7CQGv6qv9np0DXXCsIq_yRqgP9g0PAg/viewform";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("cannot launch");
    }
  }

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
                                    style: TextStyle(color: Colors.black87),
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
                                    child: Form(
                                      key: _formCardKey0,
                                      child: TextFormField(
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                                        validator: (text) {
                                          if (text!.length < 4) {
                                            errorMsg += "카드 번호를 입력해주세요.";
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: Form(
                                      key: _formCardKey1,
                                      child: TextFormField(
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                                        validator: (text) {
                                          if (text!.length < 4) {
                                            if (errorMsg == "") {
                                              errorMsg += "카드 번호를 입력해주세요.";
                                            }
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: Form(
                                      key: _formCardKey2,
                                      child: TextFormField(
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                                        validator: (text) {
                                          if (text!.length < 4) {
                                            if (errorMsg == "") {
                                              errorMsg += "카드 번호를 입력해주세요.";
                                            }
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(width: 30.w, alignment: Alignment.center, child: Text("-", style: TextStyle(fontSize: 24.sp))),
                                  Container(
                                    width: 40.w,
                                    height: 30.h,
                                    child: Form(
                                      key: _formCardKey3,
                                      child: TextFormField(
                                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                                        validator: (text) {
                                          if (text!.length < 4) {
                                            if (errorMsg == "") {
                                              errorMsg += "카드 번호를 입력해주세요.";
                                            }
                                            return "";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
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
                                            style: TextStyle(color: Colors.black87),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30.w,
                                            height: 50.h,
                                            child: TextFormField(
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
                              // Flexible(
                              //   child: Container(
                              //     width: double.infinity,
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Container(
                              //           height: 23.h,
                              //           child: FittedBox(
                              //             fit: BoxFit.fitHeight,
                              //             child: Text(
                              //               "CVC",
                              //               style: TextStyle(color: Colors.black87),
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           width: 40.w,
                              //           height: 30.h,
                              //           child: TextField(
                              //             inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                              //             maxLength: 3,
                              //             textAlign: TextAlign.center,
                              //             decoration: InputDecoration(
                              //               counterText: "",
                              //               isDense: true,
                              //               focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff00276b))),
                              //             ),
                              //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
                              //             cursorColor: Color(0xff00277b),
                              //             obscureText: true,
                              //             keyboardType: TextInputType.number,
                              //             focusNode: cvcFocusNode,
                              //             controller: cvcController,
                              //             onChanged: (text) {
                              //               if (text.length == 3) {
                              //                 cvcFocusNode.unfocus();
                              //               }
                              //             },
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
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

                        if (_formCardKey0.currentState!.validate() &&
                            _formCardKey1.currentState!.validate() &&
                            _formCardKey2.currentState!.validate() &&
                            _formCardKey3.currentState!.validate() &&
                            validationTextController[0].text.isNotEmpty &&
                            validationTextController[1].text.isNotEmpty) {
                          Get.snackbar("", "결제 진행");
                          for (int i = 0; i < cardTextController.length; i++) {
                            cardNum += cardTextController[i].text;
                          }
                          cardVal = validationTextController[1].text[2] + validationTextController[1].text[3] + validationTextController[0].text;

                          print(cardNum + "\n" + cardVal);

                          cardController.updateCardInfo(cardNum);
                          cardController.updateCardValidation(cardVal);
                          requestCardValidation().then((status) {
                            // 카드번호 검증이 성공했을 때.
                            switch (status) {
                              case 1:
                                requestOrder();
                                Get.to(() => NowPayment());
                                // Get.offAll(() => NearStoresPage());
                                // Get.to(() => OrderStatusPage());
                                break;
                              case 2:
                                Get.snackbar("경고", "카드번호를 잘 못 입력하셨습니다.", backgroundColor: Colors.white);
                                break;
                              case 3:
                                Get.snackbar("경고", "카드번호를 잘 못 입력하셨습니다.", backgroundColor: Colors.white);
                                break;
                              case 4:
                                Get.snackbar("경고", "유효기간을 잘 못 입력하셨습니다.", backgroundColor: Colors.white);
                                break;
                              case 0:
                                Get.snackbar("경고", "결제 오류가 발생하였습니다.\n다른 카드를 이용해주세요.", backgroundColor: Colors.white);
                                break;
                              default:
                                Get.snackbar("경고", "카드번호를 잘 못 입력하셨습니다.", backgroundColor: Colors.white);
                                break;
                            }
                            //카드번호 검증 실패시.
                          });
                        } else if (errorMsg != "") {
                          if (validationTextController[0].text.isEmpty || validationTextController[1].text.isEmpty) {
                            errorMsg += "\n유효기간을 확인하세요.";
                            Get.defaultDialog(title: "카드 정보 오류", middleText: errorMsg);
                          } else {
                            Get.defaultDialog(title: "카드 정보 오류", middleText: errorMsg);
                          }
                        } else {
                          Get.defaultDialog(title: "카드 정보 오류", middleText: "유효기간을 확인하세요.");
                        }
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff00276b))),
                      child: Container(
                          width: 70.w,
                          height: 35.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: FittedBox(
                                fit: BoxFit.fitHeight, child: Text("결제하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                          ))),
                  //SizedBox(width: 10.w),
                  // OutlinedButton(
                  //     onPressed: () async {
                  //       if (GetPlatform.isAndroid || GetPlatform.isIOS) {
                  //         await scanCard();
                  //         print(_cardDetails.toString());
                  //         if (_cardDetails.cardNumber.isNotEmpty && _cardDetails.expiryDate.isNotEmpty) {
                  //           String scanNum = _cardDetails.cardNumber;
                  //           String scanExp = _cardDetails.expiryDate;

                  //           cardTextController[0].text = scanNum.substring(0, 4);
                  //           cardTextController[1].text = scanNum.substring(4, 8);
                  //           cardTextController[2].text = scanNum.substring(8, 12);
                  //           cardTextController[3].text = scanNum.substring(12, 16);

                  //           validationTextController[0].text = scanExp.substring(0, 2);
                  //           validationTextController[1].text = "20" + scanExp.substring(3, 5);
                  //           Get.snackbar("카드입력", "입력이 완료되었습니다.", backgroundColor: Colors.white);
                  //         }
                  //       } else {
                  //         Get.defaultDialog(title: "오류", middleText: "곧 출시될 앱을 이용해주세요!", textConfirm: "확인");
                  //       }
                  //     },
                  //     child: Container(
                  //         width: 70.w,
                  //         height: 40.h,
                  //         child: FittedBox(fit: BoxFit.contain, child: Text("사진찍어\n카드입력", style: TextStyle(color: Color(0xff00276b)))))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> requestCardValidation() async {
    Get.snackbar("알림", "카드 유효성 검사를 위해 100원이 결제됩니다.\n확인 후 취소처리 됩니다.", backgroundColor: Colors.white);
    Map<String, dynamic> data = {};
    data["cardNumber"] = cardController.cardNum.value;
    data["cardExpire"] = cardController.cardValidation.value;

    var body = json.encode(data);
    var res = await http.Client().post(Uri.parse("https://${devMode()}.dalbodre.me/api/Order/CardNumberTest/"),
        body: body, headers: <String, String>{'Content-Type': 'application/json'});

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      if (data["success"] == "True") {
        return 1;
      } else if (data["error"] == "카드번호 오류   카드사전화요망") {
        return 2;
      } else if (data["error"] == "카드사코드 미입력오류") {
        return 3;
      } else if (data["error"] == "유효기간 오류") {
        return 4;
      } else {
        return -1;
      }
    } else {
      print(res.statusCode.toString());
      return 0;
    }
  }

  requestOrder() {
    /*
    {
      "shopId": 1,
      "totalPrice": 20000,
      "discountPrice": 1000,
      "menuList": [
        {
          "name": "메뉴 1",
          "price": 20000,
          "quantity": 3,
          "imagePath": "https://imagepath/test.png",
          "optionList": [
            {
              "name": "온도",
              "data": "차가움"
            },
            {
              "name": "샷 추가",
              "quantity": 1
            }
          ] // 옵션 있을 경우
        },
        {
          "name": "메뉴 2",
          "price": 20000,
          "quantity": 1,
          "imagePath": "https://imagepath/test.png",
          "optionList": [] // 옵션 없을 경우
        }
      ],
      "cardNumber": "1111222233334444",
      "cardExpire": "1212",
      "isUsingStamp": false,
      "CouponCode": "AAAA-BBBB-CCCC-DDDD"
    }
    */
    Map<String, dynamic> data = {};
    data["shopId"] = shopController.shop.value.id;
    data["totalPrice"] = shoppingCartController.totalPrice.value;
    data["discountPrice"] = shoppingCartController.discountPrice.value;
    data["cardNumber"] = cardController.cardNum.value;
    data["cardExpire"] = cardController.cardValidation.value;
    data["isUsingStamp"] = false;
    data["CouponCode"] = couponController.couponNo.value;

    // data["shopName"] = shopController.shop.value.name;

    List<Map<String, dynamic>> menuList = [];

    for (CartItem cartItem in shoppingCartController.shoppingCart) {
      Map<String, dynamic> menus = {};

      menus["name"] = cartItem.name;
      menus["price"] = 0;
      menus["quantity"] = cartItem.quantity;
      menus["imagePath"] = cartItem.thumbnail;
      menus["backgroundColor"] = cartItem.bgColor;

      List<Map<String, dynamic>> optionList = [];
      cartItem.cartOptions.forEach((key, value) {
        Map<String, dynamic> options = {};
        if (key == "temp") {
          options["name"] = "온도";
          options["body"] = value.name;
        }
        if (key == "addShot") {
          options["name"] = "샷 추가";
          options["quantity"] = value.quantity;
        }
        if (key == "syrup") {
          options["name"] = "헤이즐넛 시럽";
          options["quantity"] = value.quantity;
        }
        if (key == "whipping") {
          options["name"] = "휘핑크림";
          options["body"] = value.quantity == 1 ? "추가" : "";
        }
        if (key == "etcOption") {
          options["name"] = "기타옵션";
          options["body"] = value.name;
        }
        if (key != "menuQuantity") {
          optionList.add(options);
        }
      });
      menus["optionList"] = optionList;
      menuList.add(menus);
    }

    data["menuList"] = menuList;
    print(data);

    var body = json.encode(data);
    box.write("orderJson", body);
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
        itemExtent: 30.h,
        onSelectedItemChanged: (val) {
          setState(() {
            if (widget.mode == 0) {
              _selectedVal = val ~/ 9 == 0 ? "0" + (val + 1).toString() : (val + 1).toString();
            } else {
              _selectedVal = (val + 2021).toString();
            }

            widget.controller.text = _selectedVal;
          });
        },
        children: monthList);
  }
}
