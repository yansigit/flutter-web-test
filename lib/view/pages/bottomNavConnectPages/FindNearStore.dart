import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_takeout.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/view/pages/login/login_page.dart';
import '/consts/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;

class NearStoresPageState extends State<NearStoresPage> {
  Future<List<Shop>>? nearStoresFuture;
  List<Shop>? nearStores;
  int nearStoreLength = 0;
  late Position curPosition;
  int N = 3;

  Future<Position> loadCurLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<List<Shop>> fetchNearStores() async {
    //await Future.delayed(Duration(seconds: 0));

    await this.loadCurLocation().then((val) {
      this.curPosition = val;
    });
    print(this.curPosition);
    return await Shop.fetchShopsByLocation(http.Client(), N, this.curPosition);
    // if (this.nearStores != null) {
    //   this.nearStoreLength = this.nearStores!.length;
    // } else {
    //   this.nearStoreLength = 0;
    // }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 24.0.h,
          left: 20.w,
          //  left: 20.0.w, right: 80.w,
        ),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight * 0.75,
        child: Column(children: [
          Flexible(
              child: Row(children: [
            Container(
                height: 24.h,
                width: 84.w,
                margin: EdgeInsets.only(left: 24.w, right: 110.w, bottom: 14.h),
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("내 주변 매장",
                        style: TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0),
                        textAlign: TextAlign.left)
                        )),
            Container(
                margin: EdgeInsets.only(bottom: 14.h, right: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(300.w)),
                    border: Border.all(color: const Color(
                        //0xffe8e8e8
                        0xffffffff), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x0d000000),
                          offset: Offset(0, 2),
                          blurRadius: 4.w,
                          spreadRadius: 0)
                    ],
                    color: const Color(0xffffffff)),
                width: 122.w,
                height: 32.h,
                child: ElevatedButton(
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(
                                left: 0.w, top: 3.h, bottom: 3.h, right: 3.w),
                            width: 24.w,
                            height: 26.h,
                            child: SvgPicture.asset(
                                "assets/images/location.svg",
                                fit: BoxFit.fitHeight)),
                        Container(
                            width: 54.w,
                            height: 20.h,
                            margin: EdgeInsets.only(left: 2.w, right: 8.w),
                            padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("현재위치",
                                    style: const TextStyle(
                                        color: const Color(0xff00276b),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NotoSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0))))
                      ]),
                  onPressed: () => {this.loadCurLocation()}, // 현재 위치 불러오기
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(NEAR_WHITE),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.h))),
                  ),
                )),
          ])),
          Row(children: <Widget>[
            Opacity(
              opacity: 0.30000001192092896,
              child: Container(
                  width: 335.w,
                  height: 1.h,
                  decoration: BoxDecoration(color: const Color(0xffd1d1d1))),
            )
          ]),
          FutureBuilder(
            future: fetchNearStores(),
            builder: (context, AsyncSnapshot projectSnap) {
              if (projectSnap.hasData) {
                return Container(
                    child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: projectSnap.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return buildStoreView(context, projectSnap.data[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ));
              } else if (projectSnap.hasError) {
                return Center(child: Text("주변 매장이 없습니다."));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ]));
  }

  Widget buildStoreView(BuildContext context, Shop store) {
    // var d = await Geolocator.distanceBetween(this.curPosition.latitude,
    //     this.curPosition.longitude, store.latitude, store.longtitude);
    // print(store.name);
    // String distance = d.toString();
    // print("dgggggggggggggggggggg");
    //print(distance);
    final ShopController shopController = Get.put(ShopController());

    print(store.carouselImages);
    return Container(
        margin: EdgeInsets.only(left: 20.w),
        child: Row(
          children: [
            // margin: EdgeInsets.only(bottom: 16.h),
            // child:
            Container(
                width: 75.w,
                height: 75.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border:
                        Border.all(color: const Color(0xffe8e8e8), width: 1)),
                child: Image.network(
                    "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EB%B0%80%ED%81%AC%ED%8B%B0%EB%9D%BC%EB%96%BC.png")
                //Carousel(thumbnailList: store.carouselImages),

                //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 12.h, left: 16.w),
                    child: Text(store.name,
                        style: const TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        textAlign: TextAlign.left)),
                Row(children: [
                  SvgPicture.asset(
                    "assets/icons/ic_placeholder.svg",
                    width: 12.7.w,
                    height: 16.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 13.w, left: 6.w),
                      width: 80.w,
                      height: 21.h,
                      child: Text(
                          //store.distance
                          (store.distanceFromCurPosition % 10)
                                  .toStringAsFixed(1) +
                              "km",
                          style: const TextStyle(
                              color: const Color(0xffed6363),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0))),
                  Container(
                      height: 32.h,
                      width: 50.w,
                      margin: EdgeInsets.only(right: 6.w, left: 14.w),
                      child: ElevatedButton(
                          onPressed: () {
                            print("mm");
                            //Get.to(() => LoginPage());

                            Get.to(() {
                              shopController.updateShopId(store.id);
                              return OrderTakeOut(shop: store);
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
                              height: 20.h,
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
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.h),
                            )),
                          ))),
                  Container(
                      height: 32.h,
                      width: 50.w,
                      child: ElevatedButton(
                          onPressed: () => {/*매장 에서 포장하는 api */},
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
                              height: 20.h,
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
                                MaterialStateProperty.all(LIGHT_SKY_BLUE),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.h),
                            )),
                          ))),
                ])
              ],
            )
          ],
        ));
  }
}

class NearStoresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearStoresPageState();
  }
}
