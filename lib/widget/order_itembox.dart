import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_popupOption.dart';
import 'package:save_order/state/controllers.dart';

class ItemBoxContainer extends StatelessWidget {
  final Menu menu;
  ItemBoxContainer(this.menu);

  @override
  Widget build(BuildContext context) {
    return listViewStyle(menu);
  }

  Widget listViewStyle(Menu menu) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        OptionDialog(menu: menu),
        backgroundColor: Color(menu.bgColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        isDismissible: false,
        isScrollControlled: true,
        ignoreSafeArea: true,
      ).whenComplete(() => OptionDialog.destoryAllController()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(90)),
                color: Color(menu.bgColor),
              ),
              width: 90.w,
              height: 154.h,
              child: Column(
                //TODO 수정
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 52,
                    child: Container(
                      child: hotIceIconBox(menu.isHot, menu.isCold),
                      //TODO 아이스, 핫 둘 다 가능할 경우 고치기 22x22 -> 57 x 22
                      width: menu.isHot == true && menu.isCold == true ? 57.w : 22.w,
                      height: 22.h,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Expanded(
                    flex: 102,
                    child: Center(
                      child: Image.network(menu.thumbnail), //SvgPicture.asset("assets/icons/iceOnlyIcon.svg"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 27.h,
                    child: FittedBox(
                      child: Text(
                        menu.name,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 4.h), child: priceBoxWidget(menu)),
                  Container(
                    margin: EdgeInsets.only(top: 11.h),
                    child: ingredientBox(menu.ingredients),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hotIceIconBox(bool hotFlag, bool iceFlag) {
    if (hotFlag == true && iceFlag == true) {
      return SvgPicture.asset("assets/icons/ic_hotAndice.svg", color: Colors.white);
    } else if (hotFlag == true && iceFlag == false) {
      return SvgPicture.asset("assets/icons/ic_hotIcon.svg", color: Colors.white);
    } else if (hotFlag == false && iceFlag == true) {
      return SvgPicture.asset("assets/icons/ic_iceIcon.svg", color: Colors.white);
    } else {
      return Container();
    }
  }

  Widget priceBoxWidget(Menu menu) {
    if (menu.isHot == true && menu.isCold == true) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            child: FittedBox(
              child: SvgPicture.asset(
                "assets/icons/hotOnlyIcon.svg",
                color: Color.fromRGBO(177, 3, 3, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w),
            height: 22.h,
            child: FittedBox(
              child: Text(
                calcStringToWon(menu.hotPrice),
                style: TextStyle(color: Color.fromRGBO(177, 3, 3, 1)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 11.w),
            width: 16.w,
            height: 16.h,
            child: FittedBox(
              child: SvgPicture.asset(
                "assets/icons/iceOnlyIcon.svg",
                color: Color.fromRGBO(0, 39, 107, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w),
            height: 22.h,
            child: FittedBox(
              child: Text(
                calcStringToWon(menu.coldPrice),
                style: TextStyle(color: Color.fromRGBO(0, 39, 107, 1)),
              ),
            ),
          ),
        ],
      );
    } else if (menu.isHot == true && menu.isCold == false) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            child: FittedBox(
              child: SvgPicture.asset(
                "assets/icons/hotOnlyIcon.svg",
                color: Color.fromRGBO(177, 3, 3, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w),
            height: 22.h,
            child: FittedBox(
              child: Text(
                calcStringToWon(menu.hotPrice),
                style: TextStyle(color: Color.fromRGBO(177, 3, 3, 1)),
              ),
            ),
          ),
        ],
      );
    } else if (menu.isHot == false && menu.isCold == true) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            child: FittedBox(
              child: SvgPicture.asset(
                "assets/icons/iceOnlyIcon.svg",
                color: Color.fromRGBO(0, 39, 107, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w),
            height: 22.h,
            child: FittedBox(
              child: Text(
                calcStringToWon(menu.coldPrice),
                style: TextStyle(color: Color.fromRGBO(0, 39, 107, 1)),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 4.w),
        height: 22.h,
        child: FittedBox(
          child: Text(
            calcStringToWon(menu.hotPrice),
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  Widget ingredientBox(List<Ingredient> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ingredientBoxList(list),
      ),
    );
  }

  List<Widget> ingredientBoxList(List<Ingredient> lists) {
    List<Widget> val = [];

    for (Ingredient list in lists) {
      val.add(
        Container(
          decoration: BoxDecoration(
            color: Color(0xfff7f7f7),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          width: 64.w,
          height: 90.h,
          margin: EdgeInsets.only(right: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Container(
                    width: 45.w,
                    alignment: Alignment.bottomCenter,
                    child: Image.network(list.thumbnail),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    list.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return val;
  }
}
