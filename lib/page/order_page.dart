import 'package:flutter/material.dart';
import 'package:save_order/model/mockup.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:save_order/widget/bottom_shopnav.dart';
import 'package:save_order/widget/order_tabbar.dart';

class OrderPage extends StatelessWidget {
  final Shop shop;
  OrderPage({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Category>>(
          future: Category.fetchCategories(shop.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              categories = categories;
              //final categories = snapshot.data as List<Category>;

              return OrderTabRe(categoryList: categories);
            } else {
              return Container(child: CircularProgressIndicator());
            }
          }),
      bottomNavigationBar: BottomNav(),
    );
  }
}
