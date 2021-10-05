import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/billing_page.dart';
import 'package:save_order/state/controllers.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  static bool discountFlag = false;
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final ShoppingCartController shoppingCartController = Get.find();
  final ShopController shopController = Get.find();
  final CouponController c = Get.put(CouponController());

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<int> discountPrice = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (DateTime.now().hour >= 10 && shopController.shop.value.name == "11호관 커피숍") {
      ShoppingCartPage.discountFlag = true;
      for (int idx = 0; idx < shoppingCartController.shoppingCart.length; idx++) {
        shoppingCartController.update11stDiscount(idx);
      }

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.snackbar("할인 행사", "11호관 커피에서 할인 행사가 진행되어 10% 할인이 적용되었습니다.");
      });
    } else if (DateTime.now().hour < 10 && shopController.shop.value.name == "11호관 커피숍") {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Get.snackbar("굿즈 행사", "11호관 커피에서 굿즈 행사가 진행중입니다. 점원에게 문의하세요.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "장바구니",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/backIcon.svg",
            color: Colors.black,
          ),
          onPressed: () {
            // if (ShoppingCartPage.discountFlag) {
            //   for (int idx = 0; idx < shoppingCartController.shoppingCart.length; idx++) {
            //     shoppingCartController.reset11stDiscount(idx);
            //   }
            // }
            Get.back();
          },
        ),
        elevation: 2.0,
        //TODO 전체삭제 구현

        actions: <Widget>[
          Transform.scale(
            scale: 0.7,
            child: InkWell(
              onTap: () {
                if (shoppingCartController.shoppingCart.length != 0) {
                  shoppingCartController.shoppingCart.clear();
                  Get.snackbar("알림", "장바구니 내용이 모두 삭제되었습니다.", backgroundColor: Colors.white);
                } else {
                  Get.snackbar("알림", "장바구니에 담긴 내역이 없습니다.", backgroundColor: Colors.white);
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 5.h),
                child: Image.asset("assets/icons/ic_allClear.png"),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: GetX<ShoppingCartController>(
          init: shoppingCartController,
          builder: (_) => Container(
            child: ListView.separated(
                itemBuilder: ((context, idx) {
                  if (_.shoppingCart.length >= 1) {
                    if (idx == 0) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.h, bottom: 14.h, left: 20.w),
                        child: Container(
                          width: double.infinity,
                          height: 52.h,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //TODO 아이콘 구현
                              Container(
                                width: 29.w,
                                height: 22.h,
                                child: SvgPicture.asset(
                                  "assets/icons/ic_nowShop.svg",
                                  fit: BoxFit.fitHeight,
                                  color: Color(0xff00276b),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 6.w),
                                height: 31.h,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    shopController.shop.value.name,
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
                                "장바구니에 담으신 물품은 종료하실 때까지 보관됩니다.",
                                style: TextStyle(
                                  color: Color(0xff707070),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (idx == _.shoppingCart.length + 2) {
                      return InkWell(
                        onTap: (() => Get.back()),
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 44.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.h)),
                            color: Color(0xfff8f8f8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 18.3.h,
                                child: SvgPicture.asset("assets/icons/orderCartIcon.svg", fit: BoxFit.fitHeight, color: Color(0xff00276b)),
                              ),
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
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                        child: cartItemWidget(idx - 2),
                      );
                    }
                  } else {
                    if (idx == 0) {
                      return Padding(
                        padding: EdgeInsets.only(top: 7.h, bottom: 14.h, left: 20.w),
                        child: Container(
                          width: double.infinity,
                          height: 52.h,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 29.w,
                                height: 22.h,
                                child: SvgPicture.asset(
                                  "assets/icons/ic_nowShop.svg",
                                  fit: BoxFit.fitHeight,
                                  color: Color(0xff00276b),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 6.w),
                                height: 31.h,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    shopController.shop.value.name,
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
                      return Container();
                    } else if (idx == 3) {
                      return InkWell(
                        onTap: (() => Get.back()),
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 44.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.h)),
                            color: Color(0xfff8f8f8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 20.w,
                                  height: 18.3.h,
                                  child: SvgPicture.asset("assets/icons/orderCartIcon.svg", fit: BoxFit.fitHeight, color: Color(0xff00276b))),
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
                                fit: BoxFit.fitHeight,
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
                itemCount: _.shoppingCart.length != 0 ? _.shoppingCart.length + 3 : 4),
          ),
        ),
      ),
      bottomNavigationBar: GetX<ShoppingCartController>(
          init: ShoppingCartController(),
          builder: (_) => BottomWidget(cartList: _.shoppingCart, cartListLength: _.shoppingCart.length, controller: _)),
    );
  }

  Widget cartItemWidget(idx) {
    ShoppingCartController c = Get.find();
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15.h),
            width: 90.w,
            height: 154.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90.h)),
              color: Color(c.shoppingCart[idx].bgColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO 아이템 박스 구현
                Expanded(
                  flex: 52,
                  child: Container(
                    margin: EdgeInsets.only(top: 18.h),
                    child: SvgPicture.asset(
                      c.shoppingCart[idx].cartOptions["temp"]!.name == "따뜻한" ? "assets/icons/hotOnlyIcon.svg" : "assets/icons/iceOnlyIcon.svg",
                      color: Colors.white,
                      fit: BoxFit.fitHeight,
                    ),
                    //TODO 아이스, 핫 둘 다 가능할 경우 고치기 22x22 -> 57 x 22
                    width: 22.w,
                    height: 22.h,
                  ),
                ),
                Expanded(
                  flex: 102,
                  child: Center(
                    child: Image.network(c.shoppingCart[idx].thumbnail), //SvgPicture.asset("assets/icons/iceOnlyIcon.svg"),
                  ),
                )
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
                              c.shoppingCart[idx].name,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          )),
                      InkWell(
                        onTap: () => c.removeCartItem(idx),
                        child: Container(
                          width: 24.w,
                          height: 24.h,
                          child: SvgPicture.asset("assets/icons/ic_delete.svg", fit: BoxFit.fitHeight),
                        ),
                      ),
                    ],
                  ),
                  c.shoppingCart[idx].cartOptions["temp"]?.name != null
                      ? Row(children: [
                          Container(
                            height: 19.h,
                            width: 19.w,
                            child: c.shoppingCart[idx].cartOptions["temp"]!.name == "따뜻한"
                                ? SvgPicture.asset("assets/icons/ic_hotIcon.svg", color: Color(0xffad1616))
                                : SvgPicture.asset("assets/icons/ic_coldIcon.svg", color: Color(0xff00276b)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.w),
                            height: 19.h,
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  c.shoppingCart[idx].cartOptions["temp"]!.name,
                                  style: TextStyle(
                                    color: c.shoppingCart[idx].cartOptions["temp"]!.name == "따뜻한" ? Color(0xffad1616) : Color(0xff00276b),
                                  ),
                                )),
                          ),
                        ])
                      : Container(),
                  c.shoppingCart[idx].cartOptions["size"]?.name != null
                      ? Container(
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(c.shoppingCart[idx].cartOptions["iceSize"]!.name, style: TextStyle(color: Color(0xff707070))),
                          ))
                      : Container(
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text("기본 사이즈", style: TextStyle(color: Color(0xff707070))),
                          )),
                  // c.shoppingCart[idx].cartOptions["iceSize"]?.name != null
                  //     ? Container(
                  //         height: 20.h,
                  //         child: FittedBox(
                  //           fit: BoxFit.fitHeight,
                  //           child: Text(c.shoppingCart[idx].cartOptions["iceSize"]!.name, style: TextStyle(color: Color(0xff707070))),
                  //         ))
                  //     : Container(),
                  c.shoppingCart[idx].cartOptions["addShot"]?.name != null
                      ? Container(
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(c.shoppingCart[idx].cartOptions["addShot"]!.quantity.toString() + "샷 추가",
                                style: TextStyle(color: Color(0xff707070))),
                          ))
                      : Container(),
                  c.shoppingCart[idx].cartOptions["whipping"]?.name != null
                      ? Container(
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text("휘핑크림 추가", style: TextStyle(color: Color(0xff707070))),
                          ))
                      : Container(),
                  c.shoppingCart[idx].cartOptions["etcOption"]?.name != null
                      ? Container(
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(c.shoppingCart[idx].cartOptions["etcOption"]!.name, style: TextStyle(color: Color(0xff707070))),
                          ))
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Obx(
                            () => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (c.shoppingCart[idx].quantity > 1) {
                                      c.decreaseMenuQuantity(idx);
                                      c.shoppingCart.refresh();
                                    }
                                  },
                                  child: SizedBox(
                                    width: 36.w,
                                    height: 36.h,
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(18.h)),
                                          border: Border.all(
                                            color: Color(0xffe8e8e8),
                                            width: 1,
                                          ),
                                          color: Color(0xffffffff),
                                          boxShadow: [
                                            BoxShadow(color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: 0),
                                          ],
                                        ),
                                        child: SvgPicture.asset("assets/icons/minusIcon.svg",
                                            fit: BoxFit.scaleDown, color: c.shoppingCart[idx].quantity > 1 ? Color(0xff00276b) : Color(0xffe6e6e6))),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                                  height: 25.h,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      c.shoppingCart[idx].quantity.toString(),
                                      style: TextStyle(
                                        color: Color(0xff00276b),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    c.increaseMenuQuantity(idx);
                                    c.shoppingCart.refresh();
                                  },
                                  child: SizedBox(
                                    child: Container(
                                      width: 36.w,
                                      height: 36.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(18.h)),
                                        border: Border.all(
                                          color: Color(0xffe8e8e8),
                                          width: 1,
                                        ),
                                        color: Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: 0),
                                        ],
                                      ),
                                      child: SvgPicture.asset("assets/icons/plusIcon.svg", fit: BoxFit.scaleDown, color: Color(0xff00276b)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 27.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              calcStringToWon(c.shoppingCart[idx].price),
                              style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700),
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

class BottomWidget extends StatelessWidget {
  final cartList;
  final cartListLength;
  final controller;

  BottomWidget({
    Key? key,
    required this.cartList,
    required this.cartListLength,
    required this.controller,
  }) : super(key: key);

  CouponController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144.h,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Color(0x59000000), offset: Offset(0, 6), blurRadius: 12, spreadRadius: 0)],
        color: Color(0xffffffff),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w, bottom: 18.h),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 31.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight, child: Text("총 ${controller.shoppingCart.length}건", style: TextStyle(color: Color(0xff00276b))))),
                Container(
                    height: 34.h,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        //TODO 아이템 가격 산정하기.
                        child: Text(controller.shoppingCart.length == 0 ? "0원" : calcStringToWon(controller.updateTotalPrice(cartList)),
                            style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700)))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: InkWell(
              onTap: (() {
                if (cartListLength > 0) {
                  ShoppingCartController s = Get.find();
                  Get.to(() => BillingPage())!.whenComplete(() {
                    s.resetPrice();
                    if (c.couponNo.value != "") {
                      Get.snackbar("알림", "쿠폰 사용이 취소되었습니다.");
                      c.reset();
                    }
                  });
                  // Get.snackbar(
                  //   "오류",
                  //   "결제 시스템 오류로 인해 10월 4일부터 이용 가능합니다.",
                  //   backgroundColor: Colors.white,
                  // );
                } else {
                  Get.snackbar("경고", "장바구니에 담긴 내역이 없습니다.", backgroundColor: Colors.white);
                }
              }),
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
                            style: TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.w700),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 52,
                  child: Container(
                    child: SvgPicture.asset(
                        cartItem.cartOptions["temp"]!.name == "따뜻한" ? "assets/icons/ic_hotIcon.svg" : "assets/icons/ic_coldIcon.svg",
                        color: Colors.white,
                        fit: BoxFit.fitHeight),
                    //TODO 아이스, 핫 둘 다 가능할 경우 고치기 22x22 -> 57 x 22
                    width: 22.w,
                    height: 22.h,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Expanded(
                  flex: 102,
                  child: Center(
                    child: Image.network(cartItem.thumbnail), //SvgPicture.asset("assets/icons/iceOnlyIcon.svg"),
                  ),
                )
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
                        child: Container(width: 24.w, height: 24.h, color: Colors.red),
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
                        child: Text("중간 사이즈", style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("얼음 적게", style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("1샷 추가", style: TextStyle(color: Color(0xff707070))),
                      )),
                  Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("물 적게 넣어주세요.", style: TextStyle(color: Color(0xff707070))),
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
                                        borderRadius: BorderRadius.all(Radius.circular(18.h)),
                                        border: Border.all(
                                          color: Color(0xffe8e8e8),
                                          width: 1,
                                        ),
                                        color: Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: 0),
                                        ],
                                      ),
                                      child: SvgPicture.asset("assets/icons/minusIcon.svg", fit: BoxFit.scaleDown)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
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
                                      borderRadius: BorderRadius.all(Radius.circular(18.h)),
                                      border: Border.all(
                                        color: Color(0xffe8e8e8),
                                        width: 1,
                                      ),
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 4, spreadRadius: 0),
                                      ],
                                    ),
                                    child: SvgPicture.asset("assets/icons/plusIcon.svg", fit: BoxFit.scaleDown),
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
                              style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700),
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
