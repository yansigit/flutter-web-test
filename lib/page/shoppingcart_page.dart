import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/billing_page.dart';
import 'package:save_order/state/controllers.dart';

class ShoppingCartPage extends StatelessWidget {
  final ShoppingCartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<CartItem> cartItemList = controller.shoppingCart.value;

    int cartListLength = cartItemList.length;
    print(cartListLength.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "장바구니",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 5,
        actions: [
          Container(
              height: 20, child: Text("슈발", style: TextStyle(fontSize: 20))),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Container(
          child: ListView.separated(
              itemBuilder: ((context, idx) {
                if (cartListLength >= 1) {
                  if (idx == 0) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 7.h, bottom: 14.h, left: 20.w),
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(),
                            Container(
                              height: 31.h,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "달보드레 잠실점",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff00276b),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (idx == 1) {
                    return Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xfff8f8f8),
                        border: Border(
                          top: BorderSide(color: Color(0xffe8e8e8), width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.5.h, bottom: 10.5.h),
                        child: Container(
                          height: 19.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "장바구니에 담으신 물품은 최대 7일간 보관됩니다.",
                              style: TextStyle(
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (idx == cartListLength + 2) {
                    return InkWell(
                      onTap: (() => Get.back()),
                      child: Container(
                        width: double.infinity,
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 24.h, bottom: 44.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.h)),
                          color: Color(0xfff8f8f8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(),
                            Container(
                              height: 24.h,
                              margin: EdgeInsets.only(left: 10.w),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "더 담으러 가기",
                                  style: TextStyle(
                                    color: Color(0xff00276b),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 20.w),
                      child: CartMenuWidget(
                        cartItem: cartItemList[idx - 2],
                      ),
                    );
                  }
                } else {
                  if (idx == 0) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 7.h, bottom: 14.h, left: 20.w),
                      child: Container(
                        width: double.infinity,
                        height: 52.h,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(),
                            Container(
                              height: 31.h,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "달보드레 잠실점",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff00276b),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (idx == 1) {
                    return Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xfff8f8f8),
                        border: Border(
                          top: BorderSide(color: Color(0xffe8e8e8), width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.5.h, bottom: 10.5.h),
                        child: Container(
                          height: 19.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "장바구니에 담으신 물품은 최대 7일간 보관됩니다.",
                              style: TextStyle(
                                color: Color(0xff707070),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (idx == 3) {
                    return InkWell(
                      onTap: (() => Get.back()),
                      child: Container(
                        width: double.infinity,
                        height: 60.h,
                        margin: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 24.h, bottom: 44.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.h)),
                          color: Color(0xfff8f8f8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(),
                            Container(
                              height: 24.h,
                              margin: EdgeInsets.only(left: 10.w),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "더 담으러 가기",
                                  style: TextStyle(
                                    color: Color(0xff00276b),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: 325.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 52.8.w,
                            height: 60.h,
                            child: SvgPicture.asset(
                              "assets/icons/ic_nonCart.svg",
                              fit: BoxFit.fill,
                              color: Color(0xff999999),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12.h),
                            height: 24.h,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                "장바구니 내역이 없습니다.",
                                style: TextStyle(
                                  color: Color(0xff999999),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
              separatorBuilder: ((context, index) {
                if (index == 0) {
                  return Container();
                } else if (index == 1) {
                  return Container();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Divider(
                      color: Color(0xffd8d8d8),
                    ),
                  );
                }
              }),
              itemCount: cartListLength != 0 ? cartListLength + 3 : 4),
        ),
      ),
      bottomNavigationBar: BottomWidget(cartList: cartItemList),
    );
  }
}

class BottomWidget extends StatelessWidget {
  final cartList;
  BottomWidget({
    Key? key,
    required this.cartList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0x59000000),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 0)
        ],
        color: Color(0xffffffff),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 15.h, left: 20.w, right: 20.w, bottom: 18.h),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 31.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("총 ${cartList.length}건",
                            style: TextStyle(color: Color(0xff00276b))))),
                Container(
                    height: 34.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(cartList.length == 0 ? "0원" : "23,600원",
                            style: TextStyle(
                                color: Color(0xff00276b),
                                fontWeight: FontWeight.w700)))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: InkWell(
              onTap: (() => Get.to(BillingPage())),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(27.h)),
                  color: Color(0xff00276b),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 20.w,
                        height: 20.h,
                        child: SvgPicture.asset(
                          "assets/icons/orderNowIcon.svg",
                          color: Color(0xffffffff),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 8.w),
                        height: 24.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "주문하기",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w700),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CartMenuWidget extends StatelessWidget {
  final CartItem cartItem;
  CartMenuWidget({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15.h),
            width: 90.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90.h)),
              color: Color(cartItem.bgColor),
            ),
            child: Column(
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 27.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              cartItem.name,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          )),
                      InkWell(
                        child: Container(
                            width: 24.w, height: 24.h, color: Colors.red),
                      ),
                    ],
                  ),
                  Row(children: [
                    Container(
                      height: 19.h,
                      width: 19.w,
                      color: Colors.blue,
                    ),
                    Container(
                      height: 19.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "시원한",
                            style: TextStyle(
                              color: Color(0xff00276b),
                            ),
                          )),
                    ),
                  ]),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("중간 사이즈",
                            style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("얼음 적게",
                            style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("1샷 추가",
                            style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("물 적게 넣어주세요.",
                            style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                child: SizedBox(
                                  width: 36.w,
                                  height: 36.h,
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18.h)),
                                        border: Border.all(
                                          color: Color(0xffe8e8e8),
                                          width: 1,
                                        ),
                                        color: Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x14000000),
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                              spreadRadius: 0),
                                        ],
                                      ),
                                      child: SvgPicture.asset(
                                          "assets/icons/minusIcon.svg",
                                          fit: BoxFit.scaleDown)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 16.w),
                                height: 25.h,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      color: Color(0xff00276b),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                child: SizedBox(
                                  child: Container(
                                    width: 36.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18.h)),
                                      border: Border.all(
                                        color: Color(0xffe8e8e8),
                                        width: 1,
                                      ),
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x14000000),
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                            spreadRadius: 0),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/plusIcon.svg",
                                        fit: BoxFit.scaleDown),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 27.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              cartItem.price.toString(),
                              style: TextStyle(
                                  color: Color(0xff00276b),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
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
