import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/state/controllers.dart';
import 'package:http/http.dart' as http;
import 'package:save_order/page/card_page.dart';

class BillingPage extends StatefulWidget {
  bool isCouponChoosed;
  BillingPage({
    Key? key,
    this.isCouponChoosed = false,
  }) : super(key: key);

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  ShoppingCartController s = Get.find();
  CouponController coupon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("결제하기",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset("assets/icons/backIcon.svg",
                color: Colors.black)),
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

  final _formKey = GlobalKey<FormState>();

  Widget PaymentMethodWidget() {
    final TextEditingController tc1 = new TextEditingController();
    Get.put(UserController());
    final UserController u = Get.find();

    String couponNo = "";
    // print(u.userToken.toString());
    // print(u.userId.toString());
    // print("payments");
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 25.h,
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("결제수단",
                        style: TextStyle(fontWeight: FontWeight.w700)))),
            InkWell(
              onTap: (() => Get.to(CardPage())),
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
                          fit: BoxFit.fitHeight,
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
                if (!widget.isCouponChoosed) {
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
                                    textCapitalization:
                                        TextCapitalization.characters,
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
                                      new FilteringTextInputFormatter.allow(
                                          RegExp("[A-Za-z0-9]")),
                                    ],
                                    validator: (val) {
                                      int len =
                                          val?.length == null ? 0 : val!.length;
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
                          onPressed: () async {
                            print("validation");
                            final couponVal = tc1.text;
                            print(u.userToken.value);

                            // 쿠폰 6자리 입력
                            if (this._formKey.currentState!.validate()) {
                              var res = await http.Client().get(
                                  Uri.parse(
                                      'https://${devMode()}.dalbodre.me/api/CouponCheck/${couponVal}'),
                                  headers: <String, String>{
                                    'token': '${u.userToken.value}'
                                  });

                              if (res.statusCode == 200) {
                                var decodedData =
                                    json.decode(utf8.decode(res.bodyBytes));

                                if (decodedData["canUse"] as String == "True") {
                                  ShoppingCartController c = Get.find();
                                  ShopController s = Get.find();

                                  switch (decodedData["couponType"] as String) {
                                    case "manyang_20%":
                                      if (s.shop.value.name == "카페마냥") {
                                        c.discountPricePercent(20);
                                        setState(() {
                                          widget.isCouponChoosed = true;

                                          Get.back();
                                          Get.snackbar("알림", "20% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_30%":
                                      if (s.shop.value.name == "카페마냥") {
                                        c.discountPricePercent(30);
                                        setState(() {
                                          widget.isCouponChoosed = true;
                                          Get.back();
                                          Get.snackbar("알림", "30% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_50%":
                                      if (s.shop.value.name == "카페마냥") {
                                        c.discountPricePercent(50);
                                        setState(() {
                                          widget.isCouponChoosed = true;
                                          Get.back();
                                          Get.snackbar("알림", "50% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_2000":
                                      if (s.shop.value.name == "카페마냥") {
                                        bool americano = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "아메리카노") {
                                            americano = true;
                                          }
                                        }
                                        if (americano) {
                                          c.discountPriceMoney(2000);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar("알림",
                                                "아메리카노 2000원 할인이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "아메리카노가 장바구니에 없습니다.");
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_amer_free":
                                      if (s.shop.value.name == "카페마냥") {
                                        bool americano = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "아메리카노") {
                                            americano = true;
                                          }
                                        }
                                        if (americano) {
                                          c.discountPriceMoney(3500);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "아메리카노 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.snackbar(
                                              "경고", "아메리카노가 장바구니에 없습니다.");
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }

                                      break;
                                    case "manyang_latte_free":
                                      if (s.shop.value.name == "카페마냥") {
                                        bool lowLatteFlag = false;
                                        bool highLatteFlag = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "녹차라떼" ||
                                              cartItem.name == "초코라떼" ||
                                              cartItem.name == "딸기라떼" ||
                                              cartItem.name == "흑당마블링라떼") {
                                            lowLatteFlag = true;
                                          }
                                          if (cartItem.name == "고구마라떼" ||
                                              cartItem.name == "펌킨라떼" ||
                                              cartItem.name == "오곡통라떼") {
                                            highLatteFlag = true;
                                          }
                                        }
                                        if (highLatteFlag) {
                                          c.discountPriceMoney(5500);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "라떼 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else if (lowLatteFlag) {
                                          c.discountPriceMoney(5000);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "라떼 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "라떼 종류 음료가 장바구니에 없습니다.",
                                              backgroundColor: Colors.white);
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_smoothe_free":
                                      if (s.shop.value.name == "카페마냥") {
                                        bool lowSmootheFlag = false;
                                        bool highSmootheFlag = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "요거트스무디") {
                                            lowSmootheFlag = true;
                                          }
                                          if (cartItem.name == "초코스무디" ||
                                              cartItem.name == "딸기스무디") {
                                            highSmootheFlag = true;
                                          }
                                        }
                                        if (highSmootheFlag) {
                                          c.discountPriceMoney(6000);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "스무디 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else if (lowSmootheFlag) {
                                          c.discountPriceMoney(5500);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "스무디 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "스무디 종류 음료가 장바구니에 없습니다.",
                                              backgroundColor: Colors.white);
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "manyang_free":
                                      if (s.shop.value.name == "카페마냥") {
                                        int maxPrice = 0;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.price > maxPrice) {
                                            maxPrice = cartItem.price;
                                          }
                                        }
                                        setState(() {
                                          c.discountPriceMoney(maxPrice);
                                          Get.back();
                                          Get.snackbar("알림",
                                              "무료 음료 한 잔 쿠폰이 적용되었습니다.\n(가장 비싼 음료)",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "카페마냥에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_20%":
                                      if (s.shop.value.name == "컬티") {
                                        c.discountPricePercent(20);
                                        setState(() {
                                          widget.isCouponChoosed = true;
                                          Get.back();
                                          Get.snackbar("알림", "20% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_30%":
                                      if (s.shop.value.name == "컬티") {
                                        c.discountPricePercent(30);
                                        setState(() {
                                          widget.isCouponChoosed = true;
                                          Get.back();
                                          Get.snackbar("알림", "30% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_50%":
                                      if (s.shop.value.name == "컬티") {
                                        c.discountPricePercent(50);
                                        setState(() {
                                          widget.isCouponChoosed = true;
                                          Get.back();
                                          Get.snackbar("알림", "50% 할인이 적용되었습니다.",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_2000":
                                      if (s.shop.value.name == "컬티") {
                                        bool americano = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "아메리카노") {
                                            americano = true;
                                          }
                                        }
                                        if (americano) {
                                          c.discountPriceMoney(2000);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar("알림",
                                                "아메리카노 2000원 할인이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "아메리카노가 장바구니에 없습니다.");
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_amer_free":
                                      if (s.shop.value.name == "컬티") {
                                        bool coldAmericano = false;
                                        bool hotAmericano = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "아메리카노") {
                                            if (cartItem.cartOptions["temp"]!
                                                    .name ==
                                                "따뜻한")
                                              hotAmericano = true;
                                            else
                                              coldAmericano = true;
                                          }
                                        }
                                        if (coldAmericano) {
                                          c.discountPriceMoney(4300);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "아메리카노 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else if (hotAmericano) {
                                          c.discountPriceMoney(3800);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "아메리카노 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "아메리카노가 장바구니에 없습니다.");
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_latte_free":
                                      if (s.shop.value.name == "컬티") {
                                        /*
                                        카페라떼 4300, 4800
                                        초코라떼 4500, 5000
                                        고구마라떼 4800, 5300
                                        녹차라떼 4800, 5300
                                        오곡라떼 4800, 5300
                                        생강라떼 5300, 5800
                                        */
                                        int price = 0;
                                        bool latteExist = false;

                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "카페라떼" ||
                                              cartItem.name == "초코라떼" ||
                                              cartItem.name == "고구마라떼" ||
                                              cartItem.name == "녹차라떼" ||
                                              cartItem.name == "오곡라떼" ||
                                              cartItem.name == "생강라떼") {
                                            if (cartItem.price > price) {
                                              price = cartItem.price;
                                              latteExist = true;
                                            }
                                          }
                                        }
                                        if (latteExist) {
                                          c.discountPriceMoney(price);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "라떼 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "라떼 종류 음료가 장바구니에 없습니다.",
                                              backgroundColor: Colors.white);
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_smoothe_free":
                                      if (s.shop.value.name == "컬티") {
                                        bool lowSmootheFlag = false;
                                        bool highSmootheFlag = false;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.name == "요거트스무디") {
                                            lowSmootheFlag = true;
                                          }
                                          if (cartItem.name == "초코스무디" ||
                                              cartItem.name == "딸기스무디") {
                                            highSmootheFlag = true;
                                          }
                                        }
                                        if (highSmootheFlag) {
                                          c.discountPriceMoney(6000);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "스무디 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else if (lowSmootheFlag) {
                                          c.discountPriceMoney(5500);
                                          setState(() {
                                            widget.isCouponChoosed = true;
                                            Get.back();
                                            Get.snackbar(
                                                "알림", "스무디 무료 쿠폰이 적용되었습니다.",
                                                backgroundColor: Colors.white);
                                            coupon.updateCoupon(
                                                couponVal,
                                                decodedData["couponType"]
                                                    as String);
                                          });
                                        } else {
                                          Get.back();
                                          Get.snackbar(
                                              "경고", "스무디 종류 음료가 장바구니에 없습니다.",
                                              backgroundColor: Colors.white);
                                        }
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                    case "coltea_free":
                                      if (s.shop.value.name == "컬티") {
                                        int maxPrice = 0;
                                        for (var cartItem in c.shoppingCart) {
                                          if (cartItem.price > maxPrice) {
                                            maxPrice = cartItem.price;
                                          }
                                        }
                                        setState(() {
                                          c.discountPriceMoney(maxPrice);
                                          Get.back();
                                          Get.snackbar("알림",
                                              "무료 음료 한 잔 쿠폰이 적용되었습니다.\n(가장 비싼 음료)",
                                              backgroundColor: Colors.white);
                                          coupon.updateCoupon(
                                              couponVal,
                                              decodedData["couponType"]
                                                  as String);
                                        });
                                      } else {
                                        Get.snackbar(
                                            "경고", "컬티에서 사용 가능한 쿠폰입니다.");
                                      }
                                      break;
                                  }
                                } else if (decodedData["canUse"] as String ==
                                    "False") {
                                  Get.back();
                                  Get.snackbar("경고",
                                      "이미 쿠폰을 사용하신 적 있습니다.\n사용한 적이 없을 때 문구가 출력되면 문의 바랍니다.",
                                      backgroundColor: Colors.white);
                                }
                              } else {
                                Get.snackbar("경고", "쿠폰 번호를 잘 못 입력하셨습니다.",
                                    backgroundColor: Colors.white);
                                tc1.text = "";
                              }
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
                } else {
                  Get.snackbar("경고", "이미 쿠폰이 적용되었습니다.");
                }
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
                          fit: BoxFit.fitHeight,
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
                        child: Text("주문 내역(${s.shoppingCart.length})",
                            style: TextStyle(fontWeight: FontWeight.w700))),
                  ),
                  Container(
                    height: 24.h,
                    width: 24.w,
                    child: Icon(
                      !expandFlag
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
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
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
