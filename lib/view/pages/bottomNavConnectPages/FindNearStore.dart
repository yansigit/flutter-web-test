import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/model/Order.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_takeout.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import 'package:save_order/widget/bottom_nav.dart';
import '/consts/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import "package:permission_handler/permission_handler.dart";

class NearStoresPageState extends State<NearStoresPage> {
  Future<List<Shop>>? nearStoresFuture;
  List<Shop>? nearStores;
  int nearStoreLength = 0;
  late Position curPosition;
  int N = 3;
  UserController userController = Get.find();

  Future<Position> loadCurLocation() async {
    print("location");
    // setState(() async {
    curPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // });

    return curPosition;
  }

  List<bool> statusPermissions = [false, false];

  Future getStatusPermissonList() async {
    var _statusLocation = await Permission.location.status.isGranted;
    var _statusCamera = await Permission.camera.status.isGranted;
    setState(() {
      print("a");
      statusPermissions[0] = _statusLocation;
      statusPermissions[1] = _statusCamera;
    });
  }

  Future<List<Shop>> fetchNearStores() async {
    //await Future.delayed(Duration(seconds: 0));
    var shops;
    if (GetPlatform.isWeb) {
      //shops = await Shop.fetchShopsByLocation(http.Client(), N, this.curPosition);

      shops = await Shop.fetchShops(http.Client());

      return shops;
    }

    //var locationPermissionStatus = statusPermissions[0];
    // var locationPermissionStatus = false;
    // print("locationPermissionStatus:" + locationPermissionStatus.toString());
    // if (locationPermissionStatus == true) {
    if (statusPermissions[0] == true) {
      shops =
          await Shop.fetchShopsByLocation(http.Client(), N, this.curPosition);
    } else {
      shops = await Shop.fetchShops(http.Client());
    }

    return shops;

    // return [
    //   // new Shop(id:1,  name: "컬티", latitude: 38.5, longtitude: 40.5, distanceFromCurPosition: 3.5),
    //   // new Shop(id:1,  name: "카페마냥", latitude: 38.5, longtitude: 40.5, distanceFromCurPosition: 4.5),
    //   new Shop(id: 1, name: "11호관 커피", latitude: 38.5, longtitude: 40.5, distanceFromCurPosition: 6.5),
    // ];
  }

  @override
  void initState() {
    super.initState();
    print("ssssdsdsf");
    print(userController.userToken);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getStatusPermissonList();
      loadCurLocation().then((val) {
        curPosition = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.3,
          leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: Text(
                              "아직 QR코드 스캔 기능이 구현되지 않았습니다. 베타 테스트 이후 기능 구현 예정입니다."));
                    });
              },
              icon: SvgPicture.asset(
                "assets/icons/ic_qrcode.svg",
                color: Color.fromRGBO(34, 34, 34, 1),
              )),
          centerTitle: true,
          title: Text("아름 드림",
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: Text(
                              "아직 검색 기능이 구현되지 않았습니다. 베타 테스트 이후 기능 구현 예정입니다."));
                    });
              },
              icon: SvgPicture.asset(
                "assets/icons/searchIcon.svg",
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ]),
      body: Container(
          margin: EdgeInsets.only(top: 24.0.h, left: 20.w, right: 20.w),
          child: Column(children: [
            Flexible(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Container(
                      height: 24.h,
                      width: 95.w,
                      margin: EdgeInsets.only(bottom: 14.h),
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("내 주변 매장",
                              style: TextStyle(
                                  color: const Color(0xff222222),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "NotoSans",
                                  fontSize: 18.0),
                              textAlign: TextAlign.left))),
                  InkWell(
                    onTap: () => {this.loadCurLocation()},
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(NEAR_WHITE),
                    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    //         RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20.h))),
                    //   ),
                    child: Container(
                      width: 122.w,
                      height: 32.h,
                      margin: EdgeInsets.only(bottom: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(300.w)),
                        border: Border.all(
                            color: const Color(0xffe8e8e8), width: 1.w),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x0c000000),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.w,
                                    top: 3.h,
                                    bottom: 3.h,
                                    right: 2.w),
                                width: 24.w,
                                height: 26.h,
                                child: SvgPicture.asset(
                                    "assets/images/location.svg",
                                    fit: BoxFit.fitHeight)),
                            Container(
                                width: 54.w,
                                height: 20.h,
                                margin: EdgeInsets.only(left: 2.w, right: 5.w),
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text("현재 위치",
                                        style: const TextStyle(
                                            color: const Color(0xff00276b),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "NotoSans",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.0))))
                          ]),
                    ),
                  ),
                ])),
            Container(
              height: 1.h,
              margin: EdgeInsets.only(
                left: 20.5.w,
                right: 20.5.w,
              ),
              decoration: BoxDecoration(
                color: Color(0xffd1d1d1).withOpacity(0.30000001192092896),
              ),
            ),
            // FutureBuilder(
            //   future: fetchNearStores(),
            //   builder: (context, AsyncSnapshot projectSnap) {
            //     if (projectSnap.hasData) {
            //       return Container(
            //           child: ListView.separated(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.vertical,
            //         itemCount: projectSnap.data.length,
            //         itemBuilder: (BuildContext context, index) {
            //           return buildStoreView(context, projectSnap.data[index]);
            //         },
            //         separatorBuilder: (context, index) {
            //           return Container(
            //             height: 1.h,
            //             margin: EdgeInsets.only(
            //               left: 20.5.w,
            //               right: 20.5.w,
            //             ),
            //             decoration: BoxDecoration(
            //               color: Color(0xffd1d1d1)
            //                   .withOpacity(0.30000001192092896),
            //             ),
            //           );
            //         },
            //       ));
            //     } else if (projectSnap.hasError) {
            //       return Center(child: Text("주변 매장이 없습니다."));
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // )
            FutureBuilder(
              future: loadCurLocation(),
              builder: (context, AsyncSnapshot projectSnap) {
                if (projectSnap.hasData) {
                  curPosition = projectSnap.data;
                  print(curPosition.latitude);
                  print(curPosition.longitude);
                  return FutureBuilder(
                      future: fetchNearStores(),
                      builder: (ctx, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          return Container(
                              child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snap.data.length,
                            itemBuilder: (BuildContext context, index) {
                              return buildStoreView(context, snap.data[index]);
                            },
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 1.h,
                                margin: EdgeInsets.only(
                                  left: 20.5.w,
                                  right: 20.5.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffd1d1d1)
                                      .withOpacity(0.30000001192092896),
                                ),
                              );
                            },
                          ));
                        } else if (!snap.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Text("f");
                        }
                      });
                } else if (!projectSnap.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text("현재 매장이 없다구");
                }
              },
            )
          ])),
      bottomNavigationBar: BottomNav(),
    );
  }

  Widget buildStoreView(BuildContext context, Shop store) {
    final ShopController shopController = Get.put(ShopController());
    final Map<String, String> storeNameToAddress = {
      "컬티": "울산광역시 남구 컬티",
      "카페마냥": "울산광역시 남구 카페마냥",
      "11호관 커피": "울산광역시 남구 대학로 93번길 11호관"
    };

    // 각 가게 위치 데이터 넣기.  카페  이름이랑 비교
    //
    // 가게 view 누르면 가게로 이동
    return InkWell(
        onTap: () {
          Get.to(() {
            shopController.updateShop(store);
            return OrderTakeOut(shop: store);
          });
        },
        child: Container(
            margin: EdgeInsets.only(left: 20.w, top: 19.h),
            child: Row(
              children: [
                Container(
                    width: 75.w,
                    height: 75.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.w)),
                        border: Border.all(
                            color: const Color(0xffe8e8e8), width: 1.w)),
                    child: Image.asset("assets/images/thumbnail.png")),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(top: 12.h, left: 16.w, bottom: 8.h),
                        child: Text(store.name,
                            style: const TextStyle(
                                color: const Color(0xff222222),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                            textAlign: TextAlign.left)),
                    Container(
                      margin: EdgeInsets.only(left: 16.w, bottom: 5.h),
                      width: 140.w,
                      height: 15.h,
                      child: Text(
                        storeNameToAddress[store.name].toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 16.w),
                                width: 12.7.w,
                                height: 16.h,
                                child: SvgPicture.asset(
                                  "assets/icons/ic_placeholder.svg",
                                )),
                            Container(
                                margin: EdgeInsets.only(left: 6.w),
                                width: 80.w,
                                height: 21.h,
                                child: Text(
                                    //store.distance
                                    (store.distanceFromCurPosition / 1000)
                                            .toStringAsFixed(3) +
                                        " " +
                                        "km",
                                    style: const TextStyle(
                                        color: const Color(0xffed6363),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0))),
                            Container(
                                height: 22.h,
                                width: 40.w,
                                //margin: EdgeInsets.only(bottom: 24.h),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() {
                                        shopController.updateShop(store);
                                        return OrderTakeOut(shop: store);
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 4.w,
                                            right: 4.w,
                                            top: 2.h,
                                            bottom: 2.h),
                                        height: 18.h,
                                        child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text("매장",
                                                style: TextStyle(
                                                    color: NEAR_WHITE,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "NotoSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 17.0),
                                                textAlign: TextAlign.left))),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(DARK_BLUE),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.h),
                                      )),
                                    ))),
                            Container(
                                height: 22.h,
                                width: 40.w,
                                margin: EdgeInsets.only(left: 6.w),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(() {
                                        shopController.updateShop(store);
                                        return OrderTakeOut(shop: store);
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 4.w,
                                            right: 4.w,
                                            top: 2.h,
                                            bottom: 2.h),
                                        height: 18.h,
                                        child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text("포장",
                                                style: TextStyle(
                                                    color: NEAR_WHITE,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "NotoSans",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 17.0),
                                                textAlign: TextAlign.left))),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              LIGHT_SKY_BLUE),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.h),
                                      )),
                                    ))),
                          ]),
                    ),
                  ],
                )
              ],
            )));
  }
}

class NearStoresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearStoresPageState();
  }
}
