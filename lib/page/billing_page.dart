import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/state/controllers.dart';

import 'card_page.dart';

class BillingPage extends StatelessWidget {
  BillingPage({Key? key}) : super(key: key);
  ShoppingCartController s = Get.find();

  String couponNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("결제하기", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Get.back(), icon: SvgPicture.asset("assets/icons/backIcon.svg", color: Colors.black)),
      ),
      body: Container(
        color: Color(0xffffffff),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              PaymentMethodWidget(),
              ExpandableList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x59000000),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
          color: Color(0xffffffff),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 22.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "최종 결제 금액",
                      style: TextStyle(
                        color: Color(0xff707070),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 27.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      //TODO 결제금액
                      calcStringToWon(s.totalPrice.value),
                      style: TextStyle(
                        color: Color(0xff00276b),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

//TODO 쿠폰번호 구현
class PaymentMethodWidget extends StatelessWidget {
  final TextEditingController tc1 = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String couponNo = "";
  PaymentMethodWidget({
    Key? key,
  }) : super(key: key);

  Future<bool> validationCouponNo(couponNo) async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 25.h, child: FittedBox(fit: BoxFit.fitHeight, child: Text("결제수단", style: TextStyle(fontWeight: FontWeight.w700)))),
            InkWell(
              onTap: (() => print("aa")
                  //Get.to(CardPage())
                  ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffededed), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40.w,
                        height: 40.h,
                        child: SvgPicture.asset(
                          "assets/icons/ic_card.svg",
                          fit: BoxFit.fill,
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 8.w),
                        height: 31.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "카드 결제",
                            style: TextStyle(
                              color: Color(0xff00276b),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                Get.defaultDialog(
                  title: "쿠폰 적용",
                  content: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              key: _formKey,
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: tc1,
                                  maxLength: 6,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.characters,
                                  style: TextStyle(
                                    color: Color(0xff00276b),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: "쿠폰 번호",
                                  ),
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                  ],
                                  validator: (val) {
                                    int len = val?.length == null ? 0 : val!.length;
                                    if (len < 6) {
                                      return "6자리 입력";
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
                      OutlinedButton(
                        onPressed: () {
                          print("validation");
                          final couponVal = tc1.text;
                          //TODO 쿠폰 검증
                          if (_formKey.currentState?.validate() == null) {
                            tc1.clear();
                          }
                        },
                        child: Container(
                          width: 70.w,
                          height: 40.h,
                          child: Center(
                            child: Text(
                              "적용하기",
                              style: TextStyle(
                                color: Color(0xff00276b),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  titleStyle: TextStyle(
                    color: Color(0xff00276b),
                    fontWeight: FontWeight.w700,
                  ),
                );
              }),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffededed), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40.w,
                        height: 40.h,
                        child: SvgPicture.asset(
                          "assets/icons/ic_coin.svg",
                          fit: BoxFit.fill,
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 8.w),
                        height: 31.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "쿠폰 적용",
                            style: TextStyle(
                              color: Color(0xff00276b),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // InkWell(
            //   onTap: (() => print("모바일 결제")),
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 5.h),
            //     width: double.infinity,
            //     height: 80.h,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Color(0xffededed), width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(20.h)),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Color(0x0d000000),
            //           offset: Offset(0, 3),
            //           blurRadius: 6,
            //           spreadRadius: 0,
            //         ),
            //       ],
            //       color: Color(0xffffffff),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ExpandableList extends StatefulWidget {
  ExpandableList({Key? key}) : super(key: key);

  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  ShoppingCartController s = Get.find();
  bool expandFlag = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0x05000000),
      child: Column(
        children: [
          InkWell(
            onTap: (() {
              setState(() {
                expandFlag = !expandFlag;
              });
            }),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 24.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        //TODO 주문 내역 갯수구현
                        child: Text("주문 내역(${s.shoppingCart.length})", style: TextStyle(fontWeight: FontWeight.w700))),
                  ),
                  Container(
                    height: 24.h,
                    width: 24.w,
                    child: Icon(
                      !expandFlag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                      color: Color(0xff777777),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xffe8e8e8),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            width: double.infinity,
            height: !expandFlag ? 0 : s.shoppingCart.length * 90.h,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return cartItemWidget(s.shoppingCart[index]);
              }),
              itemCount: s.shoppingCart.length,
            ),
          )
        ],
      ),
    );
  }

  Widget cartItemWidget(CartItem i) {
    String optionString = "";
    Map<String, CartOption> options = i.cartOptions;

    if (options["temp"]?.name != null) {
      optionString += options["temp"]!.name;
    }
    if (options["addShot"]?.name != null) {
      if (optionString == "") {
        optionString += " / ${options["addShot"]!.quantity}샷 추가";
      } else {
        optionString += "${options["addShot"]!.quantity}샷 추가";
      }
    }
    if (options["whipping"]?.name != null) {
      if (optionString == "") {
        optionString += " / 휘핑크림";
      } else {
        optionString += "휘핑크림";
      }
    }
    if (options["etcOption"]?.name != null) {
      if (optionString == "") {
        optionString += "\n${options["etcOption"]!.name}";
      } else {
        optionString += "${options["etcOption"]!.name}";
      }
    }

    return Container(
      color: Color(0xfff8f8f8),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90.h)),
              color: Color(i.bgColor),
            ),
            child: Image.network(i.thumbnail, fit: BoxFit.scaleDown),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 16.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 21.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            i.name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      i.cartOptions["menuQuantity"]?.quantity != null
                          ? Container(
                              height: 21.h,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "  ${i.cartOptions["menuQuantity"]!.quantity}잔",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ))
                          : Container()
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    height: 19.h,
                    child: Text(
                      optionString,
                      style: TextStyle(
                        color: Color(0xff707070),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
