import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:save_order/page/order_takeout.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/widget/bottom_shopnav.dart';
import 'package:save_order/state/controllers.dart';

class Home extends StatelessWidget {
  List<Shop> shopList;
  Home({Key? key, required this.shopList}) : super(key: key);
  final ShopController shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    print(shopList[0].id.toString());
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: GestureDetector(
                    child: Container(
                      width: 30.w,
                      height: 45.h,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            shopList[index].name,
                          ),
                        ),
                      ),
                    ),
                    onTap: () =>
                        // Get.to(() => LoginPage())

                        Get.to(() {
                          print(";;");
                          shopController.updateShopId(shopList.length - index);
                          return OrderTakeOut(shop: shopList[index]);
                        })),
              );
            },
            itemCount: shopList.length,
          )
          //Center(
          //   child: GestureDetector(
          //     child: Container(
          //       child: Text(
          //         "달보드레 잠실점",
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //     onTap: () => Get.put(() {
          //       return OrderHome(shop: shopList[0]);
          //     }),
          //   ),
          // ),
          ),
      bottomNavigationBar: BottomNav(initialValue: 4),
    );
  }
}
