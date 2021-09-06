import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/widget/order_itembox.dart';

class OrderTabRe extends StatefulWidget {
  List<Category> categoryList;
  OrderTabRe({Key? key, this.categoryList = const []}) : super(key: key);

  @override
  _OrderTabReState createState() =>
      _OrderTabReState(categoryList: categoryList);
}

class _OrderTabReState extends State<OrderTabRe>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  List<Category> categoryList = [];
  _OrderTabReState({required this.categoryList});
  List<Tab> tabList = [];

  @override
  void initState() {
    super.initState();
    tabList = getTabs(this.categoryList);
    _controller = new TabController(length: tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Tab> getTabs(List<Category> categoryList) {
    List<Tab> tabs = [];
    for (Category category in categoryList) {
      tabs.add(new Tab(
        child: Container(
          height: 24.h,
          child: Center(
            child: FittedBox(
              child: Text(
                category.name,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ));
    }
    print(tabs.toString());
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              "assets/icons/backIcon.svg",
              color: Color.fromRGBO(34, 34, 34, 1),
            ),
          ),
          title: Text("주문하기", style: TextStyle(fontWeight: FontWeight.w700)),
          actions: [
            IconButton(
              onPressed: () => print("검색하기"),
              icon: SvgPicture.asset(
                "assets/icons/searchIcon.svg",
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ],
          bottom: TabBar(
            controller: _controller,
            tabs: tabList,
            isScrollable: true,
            indicatorColor: Color.fromRGBO(34, 34, 34, 1),
            labelColor: Color.fromRGBO(34, 34, 34, 1),
            labelPadding: EdgeInsets.symmetric(horizontal: 15),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: tabList.map((Tab tab) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: categoryList[_controller.index].menus.isNotEmpty
                    ? categoryList[_controller.index].menus.length
                    : 1,
                itemBuilder: (context, index) {
                  return Container(
                      child: categoryList[_controller.index].menus.isNotEmpty
                          ? ItemBoxContainer(
                              categoryList[_controller.index].menus[index])
                          : Container(
                              child: Text("표시할 항목이 없습니다."),
                              height: 200.h,
                              alignment: Alignment.center,
                            ));
                },
              ),
            );
          }).toList(),
          // children: [ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   itemBuilder: (context, index) {
          //     return Container(
          //         child: categoryList[_controller.index].menus.length == null
          //             ? Container(
          //                 alignment: Alignment.center,
          //                 child: Text("표시할 항목이 없습니다."))
          //             : itemBoxContainer(
          //                 categoryList[_controller.index].menus[index]));
          //   },
          //   itemCount: categoryList[_controller.index].menus == null
          //       ? 1
          //       : categoryList[_controller.index].menus.length,
          // ),],
        ));
  }
}
