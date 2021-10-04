import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/colorTheme/color.dart';
//import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_page.dart';
import 'package:save_order/state/controllers.dart';
//import 'package:http/http.dart' as http;

class OrderTakeOutWidget extends StatelessWidget {
  //컨트롤러에 매장, 포장 적재
  TakeOutController _c = Get.put(TakeOutController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      width: ScreenUtil().screenWidth,
      height: 270.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Color.fromRGBO(237, 237, 237, 1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0d000000),
                  offset: Offset(0, 6.h),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            width: 160.w,
            height: 180.h,
            child: InkWell(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: FittedBox(
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/tableIcon.svg",
                            width: 60.w,
                          ),
                          onPressed: null,
                        ),
                      ),
                      width: 80.w,
                    ),
                    Container(
                        child: FittedBox(
                          child: Text(
                            "매장",
                            style: TextStyle(
                              color: ColorThemes().selectedColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        height: 36.h),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              onTap: () {
                _c.updateTakeOut(false);
                Get.to(() => OrderPage(), transition: Transition.rightToLeft);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.w),
            decoration: new BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Color.fromRGBO(237, 237, 237, 1), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0d000000),
                  offset: Offset(6.w, 6.h),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            width: 160.w,
            height: 180.h,
            child: InkWell(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: FittedBox(
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/takeoutIcon.svg",
                          ),
                          onPressed: null,
                        ),
                        fit: BoxFit.fill,
                      ),
                      width: 80.w,
                    ),
                    Container(
                      height: 36.h,
                      child: FittedBox(
                        child: Text(
                          "포장",
                          style: TextStyle(
                            color: ColorThemes().selectedColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              onTap: () {
                _c.updateTakeOut(true);
                Get.to(() => OrderPage(), transition: Transition.rightToLeft);
              },
            ),
          ),
        ],
      ),
    );
  }
}
