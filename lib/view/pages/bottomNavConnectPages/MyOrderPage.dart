import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/model/model.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import '/model/Order.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class MyOrderPageState extends State<MyOrderPage> {
  List<Order> _orders = <Order>[];
  List<MyOrder> _mockMyMenus = <MyOrder>[];
  var orderedStoreLength = 0;
  var eachOrderLength = 0;
  String userAccessToken = "";

  MyOrderPageState(String token) {
    this.userAccessToken = token;
    _orders = <Order>[];
    _orders.add(new Order());
    orderedStoreLength = _orders.length;
    // _mockMyMenus.add(new MyOrder());
    // _mockMyMenus.add(new MyOrder());
    eachOrderLength = _mockMyMenus.length;
  }

  Future<List<MyOrder>> fetchRecentOrders() async {
    http.Client client = http.Client();
    final userResponse = await client.get(Uri.parse(
        "http://${devMode()}.dalbodre.me/api/user/${this.userAccessToken}"));

    final decodedUser = json.decode(userResponse.body);

    int userId = decodedUser["id"];
    print(decodedUser);
    print(userId);
    final recentOrdersResponse = await client.get(Uri.parse(
        "http://${devMode()}.dalbodre.me/api/Order/Recent/${userId}/1"));

    final decodeOrderData = utf8.decode(recentOrdersResponse.bodyBytes);
    print(decodeOrderData);
    List<MyOrder> myOrders = MyOrder.parseMyMenu(decodeOrderData);
    print(myOrders[0]);

    for (var i = 0; i < myOrders.length; i++) {
      final storeResponse = await client.get(Uri.parse(
          "http://${devMode()}.dalbodre.me/api/Shop/${myOrders[i].shopId}"));
      final decodedStoreData = json.decode(storeResponse.body);
      myOrders[i].storeName = decodedStoreData["name"];
      myOrders[i].storeThumbnail = decodedStoreData["thumbImage"];
      print(decodedStoreData["thumbImage"]);
    }
    return myOrders;
  }

  Widget build(BuildContext context) {
    if (!(this._orders == null)) {
      orderedStoreLength = this._orders.length;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: ScreenUtil().screenWidth, 
          height: ScreenUtil().screenHeight,
            child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 9.w),
                Text(this.orderedStoreLength.toString() + "개"),
                SizedBox(height: 8.h),
                // ElevatedButton(
                //   onPressed: () => {} // 검색해서 view 바꾸는 함수
                //   ,
                //   child: Row(children: <Widget>[
                //     Text("인기순",
                //         style: TextStyle(
                //             color: const Color(0xff666666),
                //             fontWeight: FontWeight.w400,
                //             fontFamily: "NotoSans",
                //             fontStyle: FontStyle.normal,
                //             fontSize: 14.0),
                //         textAlign: TextAlign.left),
                //   ]),
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(WHITE),
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(smallRadiusSize),
                //     )),
                //   ),
                // )
              ],
            ),
            FutureBuilder(
                future: this.fetchRecentOrders(),
                builder: (context, AsyncSnapshot projectSnap) {
                  if (projectSnap.hasData && projectSnap.data != null) {
                    return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        return buildStoreView(context, projectSnap.data[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    );
                  } else if (projectSnap.hasError || projectSnap.data == null) {
                    return Center(
                      child: Column(
                        children: [
                          SvgPicture.asset("assets/icons/emptyOrder.svg"),
                          Text(
                            "주문 내역이 없습니다",
                            style: const TextStyle(
                                color: const Color(0xff999999),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 18.0),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        )));
  }

  Widget buildStoreView(BuildContext context, MyOrder order) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.h)),
          border: Border.all(color: const Color(0xffededed), width: 1.w),
          boxShadow: [
            BoxShadow(
                color: const Color(0x0d000000),
                offset: Offset(0.h, 6.h),
                blurRadius: 12.h,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 19.h, width: 20.w),
              Text(
                "주문확인",
                style: const TextStyle(
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
              ),
              SizedBox(width: 220.w, height: 7.h),
              ElevatedButton(
                  onPressed: () => {} // 주문 상세 모달
                  ,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("제조 완료",
                                            style: const TextStyle(
                                                color: const Color(0xff222222),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "NotoSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 24.0),
                                            textAlign: TextAlign.left),
                                        Text("01",
                                            style: const TextStyle(
                                                color: const Color(0xffed6363),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "NotoSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 24.0),
                                            textAlign: TextAlign.left),
                                        GestureDetector(
                                          onTap: () {
                                            // 주문내역 삭제 remove
                                          },
                                          child: Container(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      "assets/icons/trash.svg"),
                                                  Text("삭제",
                                                      style: const TextStyle(
                                                          color: const Color(
                                                              0xff666666),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "NotoSans",
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 15.0),
                                                      textAlign: TextAlign.left)
                                                ],
                                              ),
                                              width: 70.w,
                                              height: 32.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(90.h)),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffe8e8e8),
                                                      width: 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color(
                                                            0x0d000000),
                                                        offset: Offset(0.h, 2.h),
                                                        blurRadius: 4.h,
                                                        spreadRadius: 0)
                                                  ],
                                                  color:
                                                      const Color(0xffffffff))),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // svgpicture 커피 모양
                                        Text(order.storeName,
                                            style: TextStyle(
                                                color: const Color(0xff00276b),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "NotoSans",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 22.0),
                                            textAlign: TextAlign.left)
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.005),
                                    Container(
                                        color: const Color(0xffd1d1d1)
                                            .withOpacity(0.15000000596046448),
                                        child: Column(children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                  "주문 내역 (" +
                                                      order.orders.length
                                                          .toString() +
                                                      ")", // 후에 고치기 상점마다 주문한 메뉴들 개수
                                                  style: const TextStyle(
                                                      color: const Color(
                                                          0xff222222),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "NotoSans",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 18.0),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                          order.orders.length == 0
                                              ? Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/emptyOrder.svg"),
                                                    Text(
                                                      "주문 내역이 없습니다",
                                                      style: const TextStyle(
                                                          color: const Color(
                                                              0xff999999),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "NotoSans",
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 18.0),
                                                    )
                                                  ],
                                                )
                                              : SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child: ListView.separated(
                                                      itemBuilder:
                                                          (context, index) {
                                                        return buildOrderDetailView(
                                                            context,
                                                            order
                                                                .orders[index]);
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Divider();
                                                      },
                                                      itemCount:
                                                          order.orders.length),
                                                ),
                                        ]))
                                  ],
                                );
                              });
                        });
                      },
                      child: Text(
                        "주문상세",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: const Color(0xff666666),
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 13.0),
                      )),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(WHITE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(smallRadiusSize))),
                      fixedSize: MaterialStateProperty.all<Size>(Size(70.w, 38.h))))
            ],
          ),
          Row(
            children: <Widget>[
              SvgPicture.asset(order.storeThumbnail),
              Column(
                children: <Widget>[
                  Text(
                    order.storeName,
                    style: const TextStyle(
                        color: const Color(0xff222222),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0),
                  ),
                  Text(
                    order.firstMenuName +
                        " 외 " +
                        (order.orders.length - 1).toString() +
                        " " +
                        order.totalPrice.toString(),
                    style: const TextStyle(
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w400,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildOrderDetailView(BuildContext context, OrderedMenu myMenus) {
    return Row(
      children: [
        SvgPicture.asset(myMenus.menuThumnail),
        Column(
          children: [
            Text(myMenus.menuName,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
            Text(myMenus.options.join(" / "),
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                textAlign: TextAlign.left)
          ],
        )
      ],
    );
  }
}

class MyOrderPage extends StatefulWidget {
  String userAccessToken = "";

  MyOrderPage(String accessToken) {
    this.userAccessToken = accessToken;
  }

  @override
  State<StatefulWidget> createState() {
    return MyOrderPageState(this.userAccessToken);
  }
}
