import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/util/sqlite_local_database/UserFavoriteStoreDb.dart';
import 'package:save_order/widget/order_carousel.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoriteStoresPageState extends State<FavoriteStoresPage> {
  String userAccessToken = "";
  List<Shop> favoriteStores = List.empty();
  String searchKind = "최신순";

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

  Future<List<Shop>> loadFavoriteShopsByuser() async {
    // mock 코드
    Shop mockShop = new Shop(
        name: "컬티", carouselImages: ["이미지경로"], latitude: 20, longtitude: 20);
    Map<String, dynamic> newShop = mockShop.toMap();
    newShop[UserFavoriteStoresDatabase.userAccessToken] = this.userAccessToken;
    await dbHelper.insert(newShop);
    // mock 코드 끝
    print(this.userAccessToken);
    List<Map<String, dynamic>> stores =
        await dbHelper.queryRowByUserToken(this.userAccessToken);

    List<Shop> shops = [];
    for (int i = 0; i < stores.length; i++) {
      var store = stores[i];
      var storeName = store[UserFavoriteStoresDatabase.storeName];
      var myCarsouelImages = store[UserFavoriteStoresDatabase.thumbnailPath];
      var latitude = store[UserFavoriteStoresDatabase.latitude];
      var longitutde = store[UserFavoriteStoresDatabase.longitutde];
      Shop shop = new Shop(
          name: storeName,
          carouselImages: [myCarsouelImages],
          latitude: 0,
          longtitude: 0);
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

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 2,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: SvgPicture.asset(
                  "assets/icons/backIcon.svg",
                  color: Color.fromRGBO(34, 34, 34, 1),
                )),
            title: Text("단골 매장", style: TextStyle(fontWeight: FontWeight.w700)),
            actions: [
              IconButton(
                onPressed: () => print("검색하기"),
                icon: SvgPicture.asset(
                  "assets/icons/searchIcon.svg",
                  color: Color.fromRGBO(34, 34, 34, 1),
                ),
              ),
            ]),
        body: Container(
            margin: EdgeInsets.only(top: 20.0.h, left: 20.0.w),
            alignment: Alignment.bottomCenter,
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(children: [
              Flexible(
                  child: Row(children: [
                Container(
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(length.toString() + "개 매장",
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
                      margin: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                      child: Divider(
                        color: Colors.black,
                        height: 20.h,
                      )),
                )
              ]),
              FutureBuilder(
                  future: this.loadFavoriteShopsByuser(),
                  builder: (context, AsyncSnapshot projectSnap) {
                    if (projectSnap.hasData && projectSnap.data != null) {
                      return Container(
                          child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          return buildStoreView(
                              context, projectSnap.data[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ));
                    } else if (projectSnap.hasError ||
                        projectSnap.data == null) {
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
            ])));
  }

  Widget buildStoreView(BuildContext context, Shop store) {
    return Container(
        child: Row(
      children: [
        Container(
            width: ScreenUtil().setWidth(50),
            height: ScreenUtil().setHeight(50),
            child: Container(
                height: 68.h,
                width: 68.w,
                child: Carousel(thumbnailList: store.carouselImages))
            //SvgPicture.asset("images/store/" + store.thumbnail + ".svg")

            ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              // Container(
              //     width: ScreenUtil().setWidth(10),
              //     height: ScreenUtil().setHeight(10),
              //     child: SvgPicture.asset("assets/icons/위치icon.svg")),

              // SizedBox(width: 5.w, height: 5.h),
              // Text(
              //     "3.2km"
              //     //store.distance
              //     ,
              //     style: const TextStyle(
              //         color: const Color(0xffed6363),
              //         fontWeight: FontWeight.w400,
              //         fontFamily: "Roboto",
              //         fontStyle: FontStyle.normal,
              //         fontSize: 18.0)),
              // SizedBox(width: 7.w, height: 7.h),
              Container(
                  height: 32.h,
                  width: 50.w,
                  margin: EdgeInsets.only(right: 6.w, left: 8.w),
                  child: ElevatedButton(
                      onPressed: () => {/*매장 에서 직접 사먹는 api */},
                      child: Container(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.h),
                        )),
                      ))),
              Container(
                  height: 32.h,
                  width: 50.w,
                  child: ElevatedButton(
                      onPressed: () => {/*매장 에서 포장하는 api */},
                      child: Container(
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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

class FavoriteStoresPage extends StatefulWidget {
  FavoriteStoresPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FavoriteStoresPageState();
  }
}
