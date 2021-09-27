import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:save_order/model/model.dart';
import 'package:save_order/page/shoppingcart_page.dart';
import 'package:save_order/state/controllers.dart';
import 'package:flutter/cupertino.dart';

class OptionDialog extends StatelessWidget {
  final Menu menu;

  OptionDialog({Key? key, required this.menu}) : super(key: key);

  final cartOptions = Map<String, CartOption>();

  final textController = TextEditingController();
  final ShoppingCartController cartController = Get.find();
  final OptionDialogController optionController = Get.put(OptionDialogController());
  final AddShotController shotController = Get.put(AddShotController());
  final QuantityController quantityController = Get.put(QuantityController());
  final WhippingController whipController = Get.put(WhippingController());
  final SyrupController syrupController = Get.put(SyrupController());
  final PriceController priceController = Get.put(PriceController());

  void removeKey(cartOptions) {
    List<String> nullKeys = [];
    cartOptions.forEach((key, value) {
      if (value.quantity == 0) {
        nullKeys.add(key);
      }
    });
    nullKeys.forEach((key) {
      cartOptions.remove(key);
    });
  }

  static void destoryAllController() {
    OptionDialogController c1 = Get.find();
    AddShotController c2 = Get.find();
    QuantityController c3 = Get.find();
    WhippingController c4 = Get.find();
    SyrupController c5 = Get.find();
    PriceController c6 = Get.find();

    c1.onClose();
    c2.onClose();
    c3.onClose();
    c4.onClose();
    c5.onClose();
    c6.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    int getHasHotCold(Menu menu) {
      if (menu.isHot == true && menu.isCold == true) {
        return 3;
      } else if (menu.isHot == true && menu.isCold == false) {
        return 2;
      } else if (menu.isHot == false && menu.isCold == true) {
        return 1;
      } else {
        return 0;
      }
    }

    final _hasHotCold = getHasHotCold(menu);

    cartOptions["temp"] = new CartOption();
    cartOptions["size"] = new CartOption();
    cartOptions["addShot"] = new CartOption();
    cartOptions["iceSize"] = new CartOption();
    cartOptions["syrup"] = new CartOption();
    cartOptions["whipping"] = new CartOption();

    return Container(
      width: double.infinity,
      height: ScreenUtil().screenHeight * 0.95,
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                    child: AppBarWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 10.h),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppBarBody(menu: menu),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.h),
                          topRight: Radius.circular(30.h),
                        ),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //Hot/Ice
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GetX<OptionDialogController>(
                                    init: OptionDialogController(),
                                    builder: (_c) => Column(
                                      children: [
                                        SelectTempWidget(
                                          menu: menu,
                                          hasHotCold: _hasHotCold,
                                          selected: _c.selectHotColdOption.value,
                                          cartOptions: this.cartOptions,
                                        ),
                                        // SelectSizeWidget(
                                        //   function: _c.updateSizeOption,
                                        //   selected: _c.selectSizeOption.value,
                                        //   cartOptions: this.cartOptions,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  menu.options.isNotEmpty
                                      ? ExpandableView(
                                          cartOptions: cartOptions,
                                          menu: menu,
                                        )
                                      : Container(),
                                  EtcCommentWidget(
                                    textController: textController,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        bottomNavigationBar: OptionBottomBar(
          cartOptions: cartOptions,
          textController: textController,
          removeFunction: removeKey,
          cartController: cartController,
          menu: menu,
        ),
      ),
    );
  }
}

class EtcCommentWidget extends StatelessWidget {
  EtcCommentWidget({
    Key? key,
    required this.textController,
  }) : super(key: key);
  final textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              height: 24.h,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text("직접 요청", style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            CupertinoTextField(
              placeholder: "내용을 입력해주세요. (예시)당도를 낮춰주세요.",
              cursorColor: Colors.black87,
              controller: textController,
              decoration: BoxDecoration(
                color: Color(0xfffcfcfc),
                border: Border.all(color: Color(0xffe8e8e8), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(5.h)),
              ),
              maxLengthEnforcement: MaxLengthEnforcement.none,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionPlusWidget extends StatelessWidget {
  final cartOptions;
  final Menu menu;
  OptionPlusWidget({
    Key? key,
    required this.cartOptions,
    required this.menu,
  }) : super(key: key);

  List<Widget> getOptionList(List<Option> optionList) {
    List<Widget> list = [];
    for (Option option in optionList) {
      switch (option.name) {
        case "addShot":
          list.add(AddShotWidget(cartOptions: cartOptions));
          break;
        case "iceSize":
          list.add(IceSizeWidget(cartOptions: cartOptions));
          break;
      }
      if (option.name == "syrup") {
        print("syrup");
        list.add(EtcWidget(cartOptions: cartOptions, menu: menu));
        break;
      } else if (option.name == "whipping") {
        print("whipping");
        list.add(EtcWidget(cartOptions: cartOptions, menu: menu));
        break;
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff8f8f8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          children: getOptionList(menu.options),
        ),
      ),
    );
  }
}

class EtcWidget extends StatelessWidget {
  final cartOptions;
  final menu;
  EtcWidget({
    Key? key,
    required this.cartOptions,
    required this.menu,
  }) : super(key: key);

  List<Widget> widgetList() {
    List<Widget> etcOptionWidgetList = [];

    for (Option option in menu.options) {
      switch (option.name) {
        case "syrup":
          etcOptionWidgetList.add(syrupBox());
          break;
        case "whipping":
          etcOptionWidgetList.add(whipBox());
          break;
      }
    }

    return etcOptionWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                height: 24.h,
                child:
                    FittedBox(child: Text("기타 추가  ", style: TextStyle(color: Color(0xff222222), fontWeight: FontWeight.w700)), fit: BoxFit.fitHeight),
              ),
              Container(
                height: 24.h,
                child:
                    FittedBox(child: Text("+500원", style: TextStyle(color: Color(0xffed6363), fontWeight: FontWeight.w700)), fit: BoxFit.fitHeight),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetList(), //[
              //   syrupBox(),
              //   whipBox(),
              // ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded whipBox() => Expanded(
        child: GetX<WhippingController>(
          init: WhippingController(),
          builder: (_c) => InkWell(
            onTap: () {
              _c.switchingWhipState();
              if (_c.whippingState.value == true) {
                cartOptions["whipping"] = new CartOption(name: "휘핑크림", price: 500, quantity: 1);
                PriceController _controller = Get.find();
                // _controller.increaseWhippingPrice();
                _controller.updateWhippingPrice();
              } else {
                cartOptions["whipping"] = new CartOption(name: "휘핑크림", price: 500, quantity: 0);
                PriceController _controller = Get.find();
                // _controller.decreaseWhippingPrice();
                _controller.updateWhippingPrice();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 3.5.w),
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _c.whippingState.value ? Color(0xff00276b) : Color(0x59000000), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(15.h)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 28.w,
                    height: 24.h,
                    child: SvgPicture.asset(
                      "assets/icons/ic_whipping.svg",
                      fit: BoxFit.fill,
                      color: _c.whippingState.value ? Color(0xff00276b) : Color(0x59000000),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 6.9.h),
                      height: 21.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "휘핑크림",
                          style: TextStyle(
                            color: _c.whippingState.value ? Color(0xff00276b) : Color(0x59000000),
                            fontWeight: _c.whippingState.value ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      );

  Expanded syrupBox() => Expanded(
        child: GetX<SyrupController>(
          init: SyrupController(),
          builder: (_c) => Container(
            margin: EdgeInsets.only(right: 3.5.w),
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _c.syrupCount.value > 0 ? Color(0xff00276b) : Color(0x59000000), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 19.7.w,
                    height: 24.h,
                    child: SvgPicture.asset(
                      "assets/icons/ic_syrup.svg",
                      fit: BoxFit.fill,
                      color: _c.syrupCount.value > 0 ? Color(0xff00276b) : Color(0x59000000),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.3.w),
                    height: 21.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "설탕 시럽",
                        style: TextStyle(
                          color: _c.syrupCount.value > 0 ? Color(0xff00276b) : Color(0x59000000),
                          fontWeight: _c.syrupCount.value > 0 ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 6.9.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print("- Button Clicked");

                        if (_c.hasMinus.value == true) {
                          _c.decreaseSyrupCount();
                          PriceController _controller = Get.find();
                          // _controller.decreaseSyrupPrice();
                          _controller.updateSyrupPrice();
                          cartOptions["syrup"] = new CartOption(name: "시럽", price: 500, quantity: _c.syrupCount.value);
                        } else {
                          cartOptions["syrup"] = new CartOption(name: "시럽");
                        }
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            border: Border.all(color: Color(0xffe8e8e8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14000000),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: SvgPicture.asset(
                            "assets/icons/minusIcon.svg",
                            fit: BoxFit.scaleDown,
                            color: _c.hasMinus.value ? Color(0xff00276b) : Color(0xffd1d1d1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        height: 25.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            _c.syrupCount.value.toString() + "번",
                            style: TextStyle(color: _c.syrupCount.value > 0 ? Color(0xff00276b) : Color(0x59000000), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("+ Button Clicked");
                        if (_c.hasPlus.value == true) {
                          _c.increaseSyrupCount();
                          PriceController _controller = Get.find();
                          // _controller.increaseSyrupPrice();
                          _controller.updateSyrupPrice();
                          cartOptions["syrup"] = new CartOption(name: "시럽", price: 500, quantity: _c.syrupCount.value);
                        } else {
                          cartOptions["syrup"] = new CartOption(name: "시럽");
                        }
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            border: Border.all(color: Color(0xffe8e8e8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14000000),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: Container(
                          width: 24.w,
                          height: 24.h,
                          child: SvgPicture.asset(
                            "assets/icons/plusIcon.svg",
                            fit: BoxFit.scaleDown,
                            color: _c.hasPlus.value ? Color(0xff00276b) : Color(0x59000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
}

class AddShotWidget extends StatelessWidget {
  final cartOptions;
  AddShotWidget({
    Key? key,
    required this.cartOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 33.h),
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24.h,
                child:
                    FittedBox(child: Text("샷 추가  ", style: TextStyle(color: Color(0xff222222), fontWeight: FontWeight.w700)), fit: BoxFit.fitHeight),
              ),
              Container(
                height: 24.h,
                child:
                    FittedBox(child: Text("+500원", style: TextStyle(color: Color(0xffed6363), fontWeight: FontWeight.w700)), fit: BoxFit.fitHeight),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.h)),
              border: Border.all(
                color: Color(0x59000000),
                width: 0.1.w,
              ),
            ),
            child: Center(child: GetX<AddShotController>(init: AddShotController(), builder: (_c) => shotAddBox())),
          ),
        ],
      ),
    );
  }

  List<Widget> shotImageExpanded(int count) {
    List<Widget> list = [];
    for (int i = 0; i < count; i++) {
      list.add(
        Expanded(
          child: Container(
            child: SvgPicture.asset("assets/icons/icShot.svg", fit: BoxFit.fitHeight),
          ),
        ),
      );
    }
    return list;
  }

  Widget shotAddBox() {
    final AddShotController controller = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 81.w, vertical: 19.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //OptionDialogController의 selectAddShot 갯수만큼 추가
              children: shotImageExpanded(controller.shotCount.value),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    print("- Button Clicked");
                    if (controller.hasMinus.value == true) {
                      controller.decreaseShotCount();
                      PriceController _c = Get.find();
                      // _c.decreaseShotPrice();
                      _c.updateShotPrice();
                      cartOptions["addShot"] = new CartOption(name: "샷 추가", price: 500, quantity: controller.shotCount.value);
                    }
                    if (controller.hasMinus.value == false) {
                      cartOptions["addShot"] = new CartOption();
                    }
                  },
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: Color(0xffe8e8e8)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: SvgPicture.asset("assets/icons/minusIcon.svg",
                          fit: BoxFit.scaleDown, color: controller.hasMinus.value ? Color(0xff00276b) : Color(0xffd1d1d1)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 36.w, vertical: 6.h),
                  width: 26.w,
                  height: 24.w,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      controller.shotCount.value.toString() + "샷",
                      style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("+ Button Clicked");
                    if (controller.hasPlus.value == true) {
                      controller.increaseShotCount();
                      PriceController _c = Get.find();
                      // _c.increaseShotPrice();
                      _c.updateShotPrice();
                      cartOptions["addShot"] = new CartOption(name: "샷 추가", price: 500, quantity: controller.shotCount.value);
                    }
                  },
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: Color(0xffe8e8e8)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ]),
                    child: Container(
                      width: 24.w,
                      height: 24.h,
                      child: SvgPicture.asset(
                        "assets/icons/plusIcon.svg",
                        fit: BoxFit.scaleDown,
                        color: controller.hasPlus.value ? Color(0xff00276b) : Color(0xffd1d1d1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IceSizeWidget extends StatelessWidget {
  final Map<String, CartOption> cartOptions;
  IceSizeWidget({
    Key? key,
    required this.cartOptions,
  }) : super(key: key);

  Widget iceSizeStyle(Function f, int s, int hcVal) {
    if (hcVal == 2) {
      // f(2);
      // cartOptions["iceSize"] =
      //     new CartOption(name: "보통", price: 0, quantity: 1);
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            iceSizeBox(1, f, s),
            iceSizeBox(2, f, s),
            iceSizeBox(3, f, s),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  InkWell iceSizeBox(int id, Function function, int selected) {
    String name = "";
    String nameKo = "";

    switch (id) {
      case 1:
        name = "small";
        nameKo = "적게";
        break;
      case 2:
        name = "normal";
        nameKo = "보통";
        break;
      case 3:
        name = "large";
        nameKo = "많이";
        break;
    }

    return InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 4.w),
          child: Column(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                child: SvgPicture.asset(
                  "assets/icons/${name}IceSize.svg",
                  fit: BoxFit.fill,
                  color: id == selected ? Color(0xff00276b) : Color(0xff999999),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: id == selected ? Border.all(color: Color(0xff00276b), width: 2) : Border.all(color: Color(0xffe8e8e8), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(60.h)),
                ),
                width: 100.w,
                height: 44.h,
                child: Center(
                  child: Container(
                    height: 21.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        nameKo,
                        style: id == selected
                            ? TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700)
                            : TextStyle(
                                color: Color(0xff666666),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          switch (id) {
            case 1:
              function(1);
              cartOptions["iceSize"] = new CartOption(name: "적게", price: 0, quantity: 1);
              break;
            case 2:
              function(2);
              cartOptions["iceSize"] = new CartOption(name: "보통", price: 0, quantity: 1);
              break;
            case 3:
              function(3);
              cartOptions["iceSize"] = new CartOption(name: "많이", price: 0, quantity: 1);
              break;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<OptionDialogController>(
        init: OptionDialogController(),
        builder: (_c) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 450),
            height: _c.selectHotColdOption.value != 2 ? 0 : 207.h,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                  child: FittedBox(
                      child: Text(
                        "얼음 양",
                        style: TextStyle(color: Color(0xff222222), fontWeight: FontWeight.w700),
                      ),
                      fit: BoxFit.fitHeight),
                ),
                Container(
                  height: 140.h,
                  margin: EdgeInsets.only(top: 10.h, bottom: 33.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0x59000000),
                      width: 0.1.w,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.h)),
                  ),
                  child: Center(child: iceSizeStyle(_c.updateIceQuantity, _c.selectIceQuantity.value, _c.selectHotColdOption.value)),
                ),
              ],
            ),
          );
        });
  }
}

class ExpandableView extends StatefulWidget {
  final cartOptions;
  final Menu menu;
  ExpandableView({
    Key? key,
    required this.cartOptions,
    required this.menu,
  }) : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableView> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.h),
      width: double.infinity,
      color: Color(0xfff8f8f8),
      child: Column(
        children: [
          InkWell(
            onTap: (() {
              setState(() {
                expandFlag = !expandFlag;
              });
            }),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 24.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "추가 선택",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ))),
                  Container(
                      height: 24.h,
                      width: 24.w,
                      child: Icon(
                        !expandFlag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        color: Color(0xff777777),
                      ))
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Color(0xffe0e0e0)),
          ExpandableContainer(
            expanded: expandFlag,
            child: OptionPlusWidget(
              cartOptions: widget.cartOptions,
              menu: widget.menu,
            ),
          )
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;

  final Widget child;
  ExpandableContainer({Key? key, this.expanded = true, this.collapsedHeight = 0.0, required this.child}) : super(key: key);

  OptionDialogController _c = Get.find();

  double get containerHeight {
    double expandedHeight = 703.h;
    if (_c.selectHotColdOption.value != 2) {
      expandedHeight = expandedHeight - 400.6.h;
    } else {
      expandedHeight = 525.h;
    }
    return expandedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        color: Color(0xfff8f8f8),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: expanded ? 510.h : collapsedHeight,
        child: child);
  }
}

class SelectSizeWidget extends StatelessWidget {
  final Function function;
  final int selected;
  final Map<String, CartOption> cartOptions;

  SelectSizeWidget({
    Key? key,
    required this.function,
    required this.selected,
    required this.cartOptions,
  }) : super(key: key);

  Widget sizeContainer(int selected) {
    return Container(
        child: Row(children: [
      smallSize(selected),
      midSize(selected),
      bigSize(selected),
    ]));
  }

  Widget smallSize(int selected) {
    return InkWell(
      child: Container(
        width: 107.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.h)),
          border: selected == 1 ? Border.all(color: Color(0xff00276b), width: 2) : Border.all(color: Color(0xffe8e8e8), width: 1),
        ),
      ),
      onTap: () {
        cartOptions["size"] = new CartOption(name: "작은 사이즈", price: 0, quantity: 1);
        function(1);
      },
    );
  }

  Widget midSize(int selected) {
    return InkWell(
      child: Container(
        width: 107.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.h)),
          border: selected == 2 ? Border.all(color: Color(0xff00276b), width: 2) : Border.all(color: Color(0xffe8e8e8), width: 1),
        ),
      ),
      onTap: () {
        cartOptions["size"] = new CartOption(name: "중간 사이즈", price: 0, quantity: 1);
        function(2);
      },
    );
  }

  Widget bigSize(int selected) {
    return InkWell(
      child: Container(
        width: 107.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.h)),
          border: selected == 3 ? Border.all(color: Color(0xff00276b), width: 2) : Border.all(color: Color(0xffe8e8e8), width: 1),
        ),
      ),
      onTap: () {
        cartOptions["size"] = new CartOption(name: "큰 사이즈", price: 0, quantity: 1);
        function(3);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        margin: EdgeInsets.only(top: 30.h),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 24.h,
                child: FittedBox(
                  child: Text(
                    "음료 양",
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 6.h),
              child: sizeContainer(selected),
              height: 96.h,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTempWidget extends StatelessWidget {
  final int hasHotCold;
  final int selected;
  final Map<String, CartOption> cartOptions;
  final menu;

  SelectTempWidget({
    Key? key,
    required this.hasHotCold,
    required this.selected,
    required this.cartOptions,
    required this.menu,
  }) : super(key: key);
  final OptionDialogController controller = Get.find();
  final PriceController _c = Get.find();

  void setStateTemp() {
    switch (hasHotCold) {
      case 3:
        _c.updateTempPrice(menu.hotPrice);
        break;
    }
  }

  Widget expandedHotColdContainer(hasHotCold) {
    switch (hasHotCold) {
      //핫, 아이스 둘 다 있을 때
      case 3:
        //default 값
        cartOptions["temp"] = new CartOption(name: "뜨겁게", price: 0, quantity: 1);
        //controller.updateHotColdOption(1);
        return Row(
          children: [
            HotContainer(selected),
            IceContainer(selected),
          ],
        );
      //핫만 있을 때
      case 2:
        cartOptions["temp"] = new CartOption(name: "뜨겁게", price: 0, quantity: 1);

        //controller.updateHotColdOption(1);
        return Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Color(0xffed6363)),
          ),
        );
      case 1:
        cartOptions["temp"] = new CartOption(name: "차갑게", price: 0, quantity: 1);

        //controller.updateHotColdOption(2);
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xff6288c9),
            ),
          ),
        );
      default:
        cartOptions["temp"] = new CartOption(name: "", price: 0, quantity: 0);
        //controller.updateHotColdOption(0);
        return Container();
    }
  }

  Widget HotContainer(int selected) {
    cartOptions["iceSize"] = new CartOption();
    return Expanded(
        child: InkWell(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 22.w,
                      height: 22.h,
                      child: SvgPicture.asset(
                        "assets/icons/ic_hotIcon.svg",
                        fit: BoxFit.fill,
                        color: selected == 1 ? Color(0xffffffff) : Color(0xff666666),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.w),
                      height: 24.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "따뜻한",
                          style: selected == 1
                              ? TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                )
                              : TextStyle(
                                  color: Color(0xff666666),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: selected == 1 ? Color(0xffed6363) : Colors.transparent,
                border: selected == 1 ? Border.all(width: 0, color: Colors.transparent) : Border.all(width: 1, color: Color(0xffe8e8e8)),
              ),
            ),
            onTap: () {
              cartOptions["temp"] = new CartOption(name: "뜨겁게", price: 0, quantity: 1);
              // PriceController _c = Get.find();
              _c.updateTempPrice(menu.hotPrice);
              controller.updateHotColdOption(1);
            }),
        flex: 1);
  }

  Widget IceContainer(int selected) {
    return Expanded(
        child: InkWell(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 22.w,
                      height: 22.h,
                      child: SvgPicture.asset(
                        "assets/icons/ic_coldIcon.svg",
                        fit: BoxFit.fill,
                        color: selected == 2 ? Color(0xffffffff) : Color(0xff666666),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.w),
                      height: 24.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "시원한",
                          style: selected == 2
                              ? TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                )
                              : TextStyle(
                                  color: Color(0xff666666),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: selected == 2 ? Color(0xff6288c9) : Colors.transparent,
                  border: selected == 2 ? Border.all(width: 0, color: Colors.transparent) : Border.all(width: 1, color: Color(0xffe8e8e8))),
            ),
            onTap: () {
              cartOptions["temp"] = new CartOption(name: "차갑게", price: 0, quantity: 1);
              // PriceController _c = Get.find();
              _c.updateTempPrice(menu.coldPrice);
              controller.updateHotColdOption(2);
            }),
        flex: 1);
  }

  
  @override
  Widget build(BuildContext context) {
    // if (cartOptions["temp"]!.name == "뜨겁게") {
    //   _c.updateTempPrice(menu.hotPrice);
    // }
    // if (cartOptions["temp"]!.name == "차갑게") {
    //   _c.updateTempPrice(menu.coldPrice);
    // }
    // if (cartOptions["temp"]!.name == "") {
    //   _c.updateTempPrice(menu.coldPrice);
    // }

    return hasHotCold != 0
        ? Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 24.h,
                      child: FittedBox(
                        child: Text(
                          "온도 선택",
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    child: expandedHotColdContainer(hasHotCold),
                    height: 54.h,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}

class AppBarBody extends StatelessWidget {
  const AppBarBody({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      //TODO 상단 레이아웃 고치기
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 36.h,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                child: Text(
                  menu.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/backIcon.svg",
            ),
            iconSize: 18.w,
            onPressed: () => Get.back(),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            child: Opacity(
              opacity: 0.8,
              child: Container(
                width: 54.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.h)),
                  color: Color(0xffececec),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionBottomBar extends StatelessWidget {
  final cartOptions;
  final textController;
  final Function removeFunction;
  final Menu menu;
  final ShoppingCartController cartController;
  OptionBottomBar({
    Key? key,
    required this.cartOptions,
    required this.textController,
    required this.removeFunction,
    required this.cartController,
    required this.menu,
  }) : super(key: key);
  final QuantityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    PriceController _c = Get.find();

    return Container(
      alignment: Alignment.bottomCenter,
      width: ScreenUtil().screenWidth,
      height: 144.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x59000000),
            offset: Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: GetX<QuantityController>(
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("- Button Clicked");

                            if (controller.hasMinus.value == true) {
                              controller.decreaseMenuQuantity();
                              cartOptions["menuQuantity"] = new CartOption(name: "수량", quantity: controller.menuQuantity.value);
                            }
                            if (controller.hasMinus.value == false) {
                              cartOptions["menuQuantity"] = new CartOption();
                            }
                          },
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                border: Border.all(color: Color(0xffe8e8e8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: SvgPicture.asset("assets/icons/minusIcon.svg",
                                  fit: BoxFit.scaleDown, color: controller.hasMinus.value ? Color(0xff00276b) : Color(0xffd1d1d1)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 3.h),
                          child: Container(
                            width: 31.w,
                            height: 31.w,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                controller.menuQuantity.value.toString() + "잔",
                                style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("+ Button Clicked");
                            controller.increaseMenuQuantity();
                            cartOptions["menuQuantity"] = new CartOption(name: "수량", quantity: controller.menuQuantity.value);
                          },
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                border: Border.all(color: Color(0xffe8e8e8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              child: SvgPicture.asset("assets/icons/plusIcon.svg", fit: BoxFit.scaleDown),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child: Container(
                        height: 34.h,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: GetX<PriceController>(
                              init: PriceController(),
                              builder: (_c) {
                                //TODO 가격
                                OptionDialogController _controller = Get.find();
                                // if (_controller.selectHotColdOption.value == 1) {
                                //   _c.updateTempPrice(menu.hotPrice);
                                // } else if (_controller.selectHotColdOption.value == 2) {
                                //   _c.updateTempPrice(menu.coldPrice);
                                // }
                                _c.updatePrice(cartOptions, menu);
                                return Text(
                                  calcStringToWon(_c.finalPrice.value),
                                  style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        String text = textController.text;
                        PriceController p = Get.find();
                        if (text.isNotEmpty) {
                          cartOptions["etcOption"] = new CartOption(name: text, price: 0, quantity: 1);
                        } else {
                          cartOptions["etcOption"] = new CartOption(name: "", price: 0, quantity: 0);
                        }
                        removeFunction(cartOptions);
                        print(cartOptions.toString());
                        cartController.shoppingCart.add(new CartItem(
                          name: menu.name,
                          //TODO 메뉴 가격 정하기
                          price: p.finalPrice.value,
                          //price: menu.price,
                          thumbnail: menu.thumbnail,
                          bgColor: menu.bgColor,
                          cartOptions: cartOptions,
                        ));
                        OptionDialog.destoryAllController();
                        Get.back();
                      },
                      child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff00276b), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 18.3.h,
                                child: SvgPicture.asset(
                                  "assets/icons/orderCartIcon.svg",
                                  color: Color(0xff00276b),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.5.w),
                                height: 24.h,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "담기",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xff00276b), fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    flex: 138,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        String text = textController.text;
                        PriceController p = Get.find();
                        if (text.isNotEmpty) {
                          cartOptions["etcOption"] = new CartOption(name: text, price: 0, quantity: 1);
                        } else {
                          cartOptions["etcOption"] = new CartOption(name: "", price: 0, quantity: 0);
                        }
                        removeFunction(cartOptions);
                        print(cartOptions.toString());
                        cartController.shoppingCart.add(new CartItem(
                          name: menu.name,
                          //TODO 메뉴 가격 정하기
                          price: p.finalPrice.value,
                          //price: menu.price,
                          thumbnail: menu.thumbnail,
                          bgColor: menu.bgColor,
                          cartOptions: cartOptions,
                        ));
                        OptionDialog.destoryAllController();
                        Get.off(() => ShoppingCartPage(), transition: Transition.rightToLeft);
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 5.w),
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Color(0xff00276b),
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 18.3.h,
                                child: SvgPicture.asset(
                                  "assets/icons/orderNowIcon.svg",
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.0.w),
                                height: 24.h,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "바로 주문",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    flex: 192,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
