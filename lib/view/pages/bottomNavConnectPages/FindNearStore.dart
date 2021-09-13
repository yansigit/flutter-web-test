import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(children: [
          Flexible(
              child: Row(children: [
            Text("내 주변 매장",
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
            SizedBox(width: 160, height: 5),
            ElevatedButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("assets/images/location.svg"),
                    SizedBox(width: 3, height: 3),
                    Text("현재위치",
                        style: const TextStyle(
                            color: const Color(0xff00276b),
                            fontWeight: FontWeight.w400,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0))
                  ]),
              onPressed: () => {this.loadCurLocation()}, // 현재 위치 불러오기

              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(NEAR_WHITE),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  fixedSize: MaterialStateProperty.all<Size>(Size(100, 28))),
            ),
          ])),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Divider(
                    color: Colors.black,
                    height: 20,
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
        ])));
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
            width: 50,
            height: 50,
            child: Carousel(thumbnailList: store.carouselImages)
            //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")
            ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(store.name,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0),
                textAlign: TextAlign.left),
            Row(children: [
              Container(
                  width: 10,
                  height: 10,
                  child: SvgPicture.asset("assets/icons/위치icon.svg")),
              SizedBox(width: 5, height: 5),
              Text(
                  //store.distance
                  (store.distanceFromCurPosition / 1000).toStringAsFixed(1) + "km",
                  style: const TextStyle(
                      color: const Color(0xffed6363),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0)),
              SizedBox(width: 7, height: 7),
              ElevatedButton(
                  onPressed: () => {/*매장 에서 구매하는 api */},
                  child: Text("매장",
                      style: TextStyle(
                          color: NEAR_WHITE,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.left),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(DARK_BLUE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(smallRadiusSize),
                      )),
                      fixedSize:
                          MaterialStateProperty.all<Size>(SMALL_BUTTON_SIZE))),
              SizedBox(
                height: 5,
                width: 5,
              ),
              ElevatedButton(
                  onPressed: () => {/*매장 에서 포장하는 api */},
                  child: Text("포장",
                      style: TextStyle(
                          color: NEAR_WHITE,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.left),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(LIGHT_SKY_BLUE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(smallRadiusSize),
                      )),
                      fixedSize:
                          MaterialStateProperty.all<Size>(SMALL_BUTTON_SIZE))),
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
