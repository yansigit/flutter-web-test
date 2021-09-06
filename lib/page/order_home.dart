// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:save_order/model/modelEx.dart';
// import 'package:save_order/page/order_takeout.dart';
// import 'package:save_order/widget/bottom_bar.dart';
// import 'package:http/http.dart' as http;

// class OrderHome extends StatelessWidget {
//   final Shop shop;

//   OrderHome({
//     Key? key,
//     required this.shop,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //getCategories(shop.id);
//     return Scaffold(
//       body: FutureBuilder<List<Category>>(
//           future: Category.fetchCategories(http.Client(), shop.id),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Container(child: Text(snapshot.error.toString()));
//             } else {
//               return snapshot.hasData
//                   ? Get.put(() => Takeout(shop: shop, categories: snapshot.data!,))
//                   : Center(child: CircularProgressIndicator());
//             }
//           }),
//       bottomNavigationBar: BottomNav(),
//     );
//   }
// }
