import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:save_order/widget/bottom_shopnav.dart';
import 'package:save_order/widget/order_cafename.dart';
import 'package:save_order/widget/order_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/widget/order_takeoutwidget.dart';

class OrderTakeOut extends StatelessWidget {
  final Shop shop;
  OrderTakeOut({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backIcon.svg"),
          onPressed: () => print("back"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
            child: OrderTakeOutWidget(shop),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
