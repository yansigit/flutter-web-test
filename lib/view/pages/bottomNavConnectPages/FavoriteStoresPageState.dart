import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/page/order_takeout.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/util/sqlite_local_database/UserFavoriteStoreDb.dart';
import 'package:save_order/widget/order_carousel.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class FavoriteStoresPageState extends State<FavoriteStoresPage> {
  String userAccessToken = "";
  List<Shop> favoriteStores = List.empty();
  String searchKind = "최신순";
  late Position curPosition;

  int length = 0;
  var dbHelper = UserFavoriteStoresDatabase.instance;
  static final storage = new FlutterSecureStorage();

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    String? userInfo = await storage.read(key: "login");

    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      var token = userInfo.split(" ")[5];
      this.userAccessToken = token;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<Position> loadCurLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<List<Shop>> loadFavoriteShopsByuser() async {
    // mock 코드
    Shop mockShop = new Shop(name: "컬티", carouselImages: ["이미지경로"], latitude: 20, longtitude: 20);
    Map<String, dynamic> newShop = mockShop.toMap();
    newShop[UserFavoriteStoresDatabase.userAccessToken] = this.userAccessToken;
    //await dbHelper.insert(newShop);
    // mock 코드 끝
    List<Map<String, dynamic>> stores = await dbHelper.queryRowByUserToken(this.userAccessToken);

    await this.loadCurLocation().then((val) {
      this.curPosition = val;
    });

    List<Shop> shops = [];
    print(stores.length);
    for (int i = 0; i < stores.length; i++) {
      var store = stores[i];
      var storeName = store[UserFavoriteStoresDatabase.storeName];
      var myCarsouelImages = store[UserFavoriteStoresDatabase.thumbnailPath];
      var latitude = store[UserFavoriteStoresDatabase.latitude];
      var longitude = store[UserFavoriteStoresDatabase.longitutde];
      double d = Geolocator.distanceBetween(curPosition.latitude, curPosition.longitude, latitude, longitude);
      print(d);
      print('dist');
      Shop shop =
          new Shop(name: storeName, carouselImages: [myCarsouelImages], latitude: latitude, longtitude: longitude, distanceFromCurPosition: d);
      shops.add(shop);
    }

    return shops;
  }

  @override
  void init() {
    this.favoriteStores = List.empty();
  }

  Widget build(BuildContext context) {
    this.init();

    return Container(
        margin: EdgeInsets.only(top: 20.0.h),
        alignment: Alignment.bottomCenter,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight * 0.7,
        child: Column(children: [
          Flexible(
              child: Row(children: [
            Container(
                margin: EdgeInsets.only(left: 8.w),
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("0 개 매장",
                        style: const TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                        textAlign: TextAlign.left))),
            //SizedBox(width: 200.w, height: 5.h),
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         if (this.searchKind == "최신순") {
            //         } else {
            //           // 등록순 정렬
            //         }
            //       });
            //     } // 검색해서 view 바꾸는 함수
            //     // 등록순 최신순 2가지 경우 있음.
            //     ,
            //     child: Row(children: <Widget>[
            //       Text("최신순",
            //           style: TextStyle(
            //               color: const Color(0xff666666),
            //               fontWeight: FontWeight.w400,
            //               fontFamily: "NotoSans",
            //               fontStyle: FontStyle.normal,
            //               fontSize: 14.0),
            //           textAlign: TextAlign.left),
            //       SvgPicture.asset("assets/icons/arrowdown.svg")
            //     ]),
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(WHITE),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //             RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(smallRadiusSize),
            //         )),
            //         fixedSize: MaterialStateProperty.all<Size>(Size(85.w, 32.h))))
          ])),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  child: Divider(
                color: Colors.black,
                height: 20.h,
              )),
            )
          ]),
          FutureBuilder(
              future: this.loadFavoriteShopsByuser(),
              builder: (context, AsyncSnapshot projectSnap) {
                if (projectSnap.hasData && projectSnap.data != null && projectSnap.data.length > 0) {
                  return Container(
                      child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: projectSnap.data.length,
                    itemBuilder: (context, index) {
                      return buildStoreView(context, projectSnap.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ));
                } else if (projectSnap.hasError || projectSnap.data == null || projectSnap.data.length == 0) {
                  return Center(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/icons/emptyStore.svg"),
                        Container(
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text("등록된 단골 매장이 없습니다.",
                                    style: const TextStyle(
                                        color: const Color(0xff999999),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NotoSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.center)))
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ]));
  }

  Widget buildStoreView(BuildContext context, Shop store) {
    final ShopController shopController = Get.put(ShopController());

    return Container(
        child: Row(
      children: [
        Container(
          width: ScreenUtil().setWidth(50),
          height: ScreenUtil().setHeight(50),
          child: Container(
              width: 75.w,
              height: 75.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: const Color(0xffe8e8e8), width: 1)),
              child:
                  Image.network("https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EB%B0%80%ED%81%AC%ED%8B%B0%EB%9D%BC%EB%96%BC.png")
              //Carousel(thumbnailList: store.carouselImages),

              //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")
              ),
          //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 12.h, left: 16.w),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(store.name,
                      style: const TextStyle(
                          color: const Color(0xff222222),
                          fontWeight: FontWeight.w700,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      textAlign: TextAlign.left),
                )),
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
                      (store.distanceFromCurPosition % 10).toStringAsFixed(1) + "km",
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
                          shopController.updateShop(store);
                          return OrderTakeOut(shop: store);
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
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
                        backgroundColor: MaterialStateProperty.all(DARK_BLUE),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        )),
                      ))),
              Container(
                  height: 32.h,
                  width: 50.w,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() {
                          shopController.updateShop(store);
                          return OrderTakeOut(shop: store);
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
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
                        backgroundColor: MaterialStateProperty.all(LIGHT_SKY_BLUE),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
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

class FavoriteStoresPage extends StatefulWidget {
  FavoriteStoresPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FavoriteStoresPageState();
  }
}
