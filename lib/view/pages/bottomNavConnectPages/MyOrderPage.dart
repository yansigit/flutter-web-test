import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/size.dart';
import 'package:save_order/model/Order.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class MyOrderPageState extends State<MyOrderPage> {
  List<Order> _orders = <Order>[];
  List<MyOrder> _mockMyMenus = <MyOrder>[];
  var orderedStoreLength = 0;
  var eachOrderLength = 0;
  String userAccessToken = "";

  MyOrderPageState() {
    _orders = <Order>[];
    // _orders.add(new Order());
    orderedStoreLength = _orders.length;
    // _mockMyMenus.add(new MyOrder());
    // _mockMyMenus.add(new MyOrder());
    eachOrderLength = _mockMyMenus.length;
  }

  // _asyncMethod() async {
  //   //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
  //   //(데이터가 없을때는 null을 반환을 합니다.)
  //   String? userInfo = await storage.read(key: "login");

  //   print(userInfo);

  //   //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
  //   if (userInfo != null) {
  //     var token = userInfo.split(" ")[5];
  //     this.userAccessToken = token;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //_asyncMethod();
    });
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
    // if (!(this._orders == null)) {
    //   orderedStoreLength = this._orders.length;
    // }
    // showDialog(context: context, builder: (context) {
    //   return AlertDialog(
    //       // SnackBar의 배경색
    //       backgroundColor: Colors.red[400],
    //       content: Text("주문 내역을 볼 수 있는 기능이 아직 구현되지 않았습니다. "),
    //     );
    // });

    return Container(
        height: 20.h,
        child: Text("주문 내역을 볼 수 있는 기능이 아직 구현되지 않았습니다. ")
    );

    return Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight * 0.7,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 9.w),
                Container(
                    margin: EdgeInsets.only(),
                    child: Text(this.orderedStoreLength.toString() + "개")),
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
                          Container(
                            height: 60.h,
                            width: 51.w,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: SvgPicture.asset(
                                  "assets/icons/emptyOrder.svg"),
                            ),
                          ),
                          Container(
                            height: 24.h,
                            width: 148.w,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text("주문 내역이 없습니다",
                                  style: const TextStyle(
                                    color: PHRASE_COLOR,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSans",
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ));
  }

  Widget buildStoreView(BuildContext context, MyOrder order) {
    return Container(
      width: 350.w,
      height: 180.h,
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
              // SizedBox(height: 19.h, width: 20.w),
              Container(
                margin: EdgeInsets.only(
                    left: 20.w, top: 10.h, bottom: 19.h, right: 180.w),
                height: 19.h,
                width: 51.w,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "주문확인",
                    style: const TextStyle(
                        color: const Color(0xff666666),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                  ),
                ),
              ),

              Container(
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: ElevatedButton(
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
                                              Container(
                                                height: 33.h,
                                                width: 86.w,
                                                child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text("제조 완료",
                                                      style: const TextStyle(
                                                          color: const Color(
                                                              0xff222222),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily:
                                                              "NotoSans",
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 24.0),
                                                      textAlign:
                                                          TextAlign.left),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // 주문내역 삭제 remove
                                                },
                                                child: Container(
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icons/trash.svg"),
                                                        Container(
                                                          height: 19.h,
                                                          width: 26.w,
                                                          child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              child: Text("삭제",
                                                                  style: const TextStyle(
                                                                      color: const Color(
                                                                          0xff666666),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "NotoSans",
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontSize:
                                                                          15.0),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left)),
                                                        ),
                                                      ],
                                                    ),
                                                    width: 70.w,
                                                    height: 15.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    9.h)),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffe8e8e8),
                                                            width: 1),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: const Color(
                                                                  0x0d000000),
                                                              offset: Offset(
                                                                  0.h, 2.h),
                                                              blurRadius: 4.h,
                                                              spreadRadius: 0)
                                                        ],
                                                        color: const Color(
                                                            0xffffffff))),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // svgpicture 커피 모양
                                              Container(
                                                height: 26.h,
                                                width: 208.w,
                                                child: FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(order.storeName,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff00276b),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "NotoSans",
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 22.0),
                                                        textAlign:
                                                            TextAlign.left)),
                                              )
                                            ],
                                          ),
                                          Container(
                                              color: const Color(0xffd1d1d1)
                                                  .withOpacity(
                                                      0.15000000596046448),
                                              child: Column(children: <Widget>[
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20.w,
                                                          top: 20.h,
                                                          right: 265.w,
                                                          bottom: 14.h),
                                                      height: 17.h,
                                                      width: 90.w,
                                                      child: FittedBox(
                                                          fit: BoxFit.fitHeight,
                                                          child: Text(
                                                              "주문 내역 (" +
                                                                  order.orders
                                                                      .length
                                                                      .toString() +
                                                                  ")", // 후에 고치기 상점마다 주문한 메뉴들 개수
                                                              style: const TextStyle(
                                                                  color: const Color(
                                                                      0xff222222),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      "NotoSans",
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      18.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left)),
                                                    ),
                                                  ],
                                                ),
                                                order.orders.length == 0
                                                    ? Column(
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/emptyOrder.svg"),
                                                          Container(
                                                            height: 18.h,
                                                            width: 148.w,
                                                            child: FittedBox(
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                                child: Text(
                                                                  "주문 내역이 없습니다",
                                                                  style: const TextStyle(
                                                                      color: const Color(
                                                                          0xff999999),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "NotoSans",
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontSize:
                                                                          18.0),
                                                                )),
                                                          ),
                                                        ],
                                                      )
                                                    :
                                                    //Container()

                                                    ListView.separated(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return buildOrderDetailView(
                                                              context,
                                                              order.orders[
                                                                  index]);
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Divider();
                                                        },
                                                        itemCount:
                                                            order.orders.length)
                                              ]))
                                        ],
                                      );
                                    });
                              });
                            },
                            child: Container(
                              height: 15.h,
                              child: FittedBox(
                                  fit: BoxFit.fitHeight,
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
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(WHITE),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.w))),
                          ))))
            ],
          ),
          Row(
            children: <Widget>[
              SvgPicture.asset(order.storeThumbnail),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.w, top: 20.h, right: 62.w, bottom: 4.h),
                    height: 20.h,
                    width: 189.w,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        order.storeName,
                        style: const TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 15.w, top: 40.h, right: 64.w, bottom: 17.h),
                    height: 19.h,
                    width: 187.w,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          order.firstMenuName +
                              " 외 " +
                              (order.orders.length - 1).toString() +
                              " 개" +
                              order.totalPrice.toString(),
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                        )),
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
    return Container(
        height: 54.h,
        width: 375.w,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Image.network(myMenus.menuThumnail, fit: BoxFit.contain),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 5.w, top: 10.h, right: 200.w, bottom: 3.h),
                  height: 21.h,
                  width: 76.w,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(myMenus.menuName,
                        style: const TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0),
                        textAlign: TextAlign.left),
                  ),
                ),
                Container(
                  height: 20.h,
                  width: 250.w,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(myMenus.options.join(" / "),
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left)),
                ),
              ],
            )
          ],
        ));
  }
}

class MyOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyOrderPageState();
  }
}
