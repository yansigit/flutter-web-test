import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/widget/order_carousel.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import '/model/Shop.dart';
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
    return await Shop.fetchShopsByLocation(http.Client(),
         N, this.curPosition);

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
    return  Container(
           margin: EdgeInsets.only(top: 24.0.h, 
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
             margin: EdgeInsets.only(right: 151.w),
             child: FittedBox(
               fit: BoxFit.fitHeight,
               child: 
            Text("내 주변 매장",
                style: TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left))),
            Container(
              width: 130.w,
              height: 25.h,
              child: 
            ElevatedButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 3.w, top: 1.h, bottom: 1.h, right: 8.w),
                      width: 24.w,
                      height: 15.h,
                      child:
                    SvgPicture.asset("assets/images/location.svg", fit: BoxFit.fitHeight)
                    ),
                    Container(
                      width: 54.w,
                      height: 15.h,
                      margin: EdgeInsets.only(left: 8.w),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                   child:  Text("현재위치",
                        style: const TextStyle(
                            color: const Color(0xff00276b),
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0))))
                  ]),
              onPressed: () => {this.loadCurLocation()}, // 현재 위치 불러오기
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(NEAR_WHITE),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.h))),
                  ),
            )),
          ])),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  child: Divider(
                    thickness: 1,
                    color: Colors.black
                  )),
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

    return Container(
        child: Row(
      children: [
        Container(
           margin: EdgeInsets.only(left: 12.w),
            width: 50.w,
            height: 50.h,
            child: Carousel(thumbnailList: store.carouselImages)
            //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")
            ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h,  left: 6.w),
              child:
            Text(store.name,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0),
                textAlign: TextAlign.left)),
            Row(children: [
               SvgPicture.asset("assets/icons/witch_icon.svg"),
              // Container(
              //     // margin: EdgeInsets.only(left: 5.w, bottom: 20.h, right: 6.w, top: 18.h),
              //     // width: 10.w,
              //     // height: 10.h,
              //     child:),
                  Container(
                    margin: EdgeInsets.only(right: 13.w, left: 6.w),
                    width: 80.w,
                    height: 21.h,
                  child: 
              Text(
                  //store.distance
                  (store.distanceFromCurPosition / 1000).round().toString() +
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
                child:

              ElevatedButton(
                  onPressed: () => {/*매장 에서 직접 사먹는 api */},
                  child:
                  Container(
                    
                    child: FittedBox(fit: BoxFit.fitHeight,
                  child:
                   Text("매장",
                      style: TextStyle(
                          color: NEAR_WHITE,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.left))),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(DARK_BLUE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      )),   
                          ))),
        
           Container(
                            height: 32.h,
                           width: 50.w,
                            child: 
              ElevatedButton(
                  onPressed: () => {/*매장 에서 포장하는 api */},
                  child:
                  
                Container(child: FittedBox(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(smallRadiusSize),
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
