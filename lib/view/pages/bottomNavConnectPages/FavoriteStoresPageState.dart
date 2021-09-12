import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/util/sqlite_local_database/UserFavoriteStoreDb.dart';
import 'package:save_order/widget/order_carousel.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteStoresPageState extends State<FavoriteStoresPage> {
  String userAccessToken = "";
  List<Shop> favoriteStores = List.empty();
  String searchKind = "최신순";

  int length = 0;

  FavoriteStoresPageState({required this.userAccessToken});

  Future<List<Shop>> loadFavoriteShopsByuser() async {
    final dbHelper = UserFavoriteStoresDatabase.instance;
    // mock 코드
    Shop mockShop = new Shop(
        name: "컬티", carouselImages: ["이미지경로"], latitude: 20, longtitude: 20);
    Map<String, dynamic> newShop = mockShop.toMap();
    newShop[UserFavoriteStoresDatabase.userAccessToken] = this.userAccessToken;
    await dbHelper.insert(newShop);

    List<Map<String, dynamic>> stores =
        await dbHelper.queryRowByUserToken(this.userAccessToken);
    print(stores);
    print("read data ");
    Shop mocShop = new Shop(
        name: "컬티", carouselImages: ["이미지경로"], latitude: 20, longtitude: 20);
    print(mocShop);
    print("moccccccccccccccccccccccccccc");

    List<Shop> shops = [];
    for (int i = 0; i < stores.length; i++) {
      var store = stores[i];
      print(store);
      // for (var store in stores) {
      var storeName = store[UserFavoriteStoresDatabase.storeName];
      print(storeName);
      var myCarsouelImages = store[UserFavoriteStoresDatabase.thumbnailPath];
      print(myCarsouelImages);
      var latitude = store[UserFavoriteStoresDatabase.latitude];
      print(latitude);
      var longitutde = store[UserFavoriteStoresDatabase.longitutde];
      print(longitutde);
      Shop shop = new Shop(
          name: storeName,
          carouselImages: [myCarsouelImages],
          latitude: 0,
          longtitude: 0);
      shops.add(shop);
    }

    // List<Shop> shops = getShopByList(stores).toList();

    return shops;
  }

  @override
  void init() {
    this.favoriteStores = List.empty();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    this.init();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Column(children: [
          Flexible(
              child: Row(children: [
            Text(length.toString() + "개 매장",
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18),
                textAlign: TextAlign.left),
            SizedBox(width: 200, height: 5),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (this.searchKind == "최신순") {
                    } else {
                      // 등록순 정렬
                    }
                  });
                } // 검색해서 view 바꾸는 함수
                // 등록순 최신순 2가지 경우 있음.
                ,
                child: Row(children: <Widget>[
                  Text("최신순",
                      style: TextStyle(
                          color: const Color(0xff666666),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.left),
                  SvgPicture.asset("assets/icons/arrowdown.svg")
                ]),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(WHITE),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallRadiusSize),
                    )),
                    fixedSize: MaterialStateProperty.all<Size>(Size(85, 32))))
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
              future: this.loadFavoriteShopsByuser(),
              builder: (context, AsyncSnapshot projectSnap) {
                if (projectSnap.hasData && projectSnap.data != null) {
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
                } else if (projectSnap.hasError || projectSnap.data == null) {
                  return Center(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/icons/emptyStore.svg"),
                        Text("등록된 매장이 없습니다")
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
                  width: ScreenUtil().setWidth(10),
                  height: ScreenUtil().setHeight(10),
                  child: SvgPicture.asset("assets/icons/위치icon.svg")),
              SizedBox(width: 5, height: 5),
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
              SizedBox(width: 7, height: 7),
              ElevatedButton(
                  onPressed: () => {/*매장 에서 직접 사먹는 api */},
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

class FavoriteStoresPage extends StatefulWidget {
  String token = "";

  FavoriteStoresPage({Key? key, required this.token}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FavoriteStoresPageState(userAccessToken: this.token);
  }
}
