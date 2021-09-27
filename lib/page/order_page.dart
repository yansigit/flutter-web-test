import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/mockup.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/shoppingcart_page.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:save_order/widget/bottom_shopnav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/widget/order_tabbar.dart';
import 'package:save_order/widget/tempoarary_bottom_nav.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);
  final ShopController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Category>>(
          future: Category.fetchCategories(controller.shopId.value),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //categories = categories;
              final categories = snapshot.data as List<Category>;

              return OrderTabRe(categoryList: categories);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: InkWell(
        onTap: () => Get.to(() => ShoppingCartPage()),
        child: Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.h)),
            color: Color(0xff00276b),
            boxShadow: [
              BoxShadow(
                color: Color(0x59000000),
                offset: Offset(3, 3),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset("assets/icons/orderCartIcon.svg",
                fit: BoxFit.fill, color: Color(0xffffffff)),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav()
    );
  }
}
