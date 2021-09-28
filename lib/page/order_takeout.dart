import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/widget/bottom_nav.dart';

import 'package:save_order/widget/order_cafename.dart';
import 'package:save_order/widget/order_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/widget/order_takeoutwidget.dart';


class OrderTakeOut extends StatelessWidget {
  final Shop shop;
  OrderTakeOut({Key? key, required this.shop}) : super(key: key);
  final ShoppingCartController c = Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backIcon.svg"),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 3,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
          ),
          Positioned(
            child: Stack(
              children: <Widget>[
                Positioned(child: Carousel(thumbnailList: shop.carouselImages)),
                Positioned(
                  child: CafeNameWidget(shop.name),
                  top: 95.h,
                ),
              ],
            ),
          ),
          Positioned(
            top: 462.h,
            child: OrderTakeOutWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav()
    );
  }
}
