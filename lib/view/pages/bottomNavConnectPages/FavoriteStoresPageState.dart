import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dalbbodre/consts/color.dart';
import 'package:flutter_dalbbodre/consts/size.dart';
import 'package:flutter_dalbbodre/model/Shop.dart';
import 'package:flutter_dalbbodre/model/data/dummiesRepositories.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteStoresPageState extends State<FavoriteStoresPage> {
  List<Shop> favoriteStores = List.empty();
  String searchKind = "최신순";

  int length = 0;
  @override
  void init() {
    this.favoriteStores = List.empty();
  }

  Widget build(BuildContext context) {
    this.init();
    if (!(this.favoriteStores == null)) {
      length = this.favoriteStores.length;
    }

    return Container(
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
            onPressed: () => {
              if(this.searchKind == "최신순") {

              } else{
                //등록순
              }
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
              SvgPicture.asset("images/icon/arrowdown.svg")
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
      this.length == 0
          ? Center(
              child: Column(
                children: [
                  SvgPicture.asset("images/icon/emptyStore.svg"),
                  Text("등록된 매장이 없습니다")
                ],
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: this.favoriteStores.length,
              itemBuilder: (context, index) {
                return buildStoreView(context, this.favoriteStores[index]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            )
    ]));
  }

  Widget buildStoreView(BuildContext context, Shop store) {
    return Container(
        child: Row(
      children: [
        Container(
            width: ScreenUtil().setWidth(50),
            height: ScreenUtil().setHeight(50),
            child:
                SvgPicture.asset("images/store/" + store.thumbnail + ".svg")),
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
                  child: SvgPicture.asset("images/store/위치icon.svg")),
              SizedBox(width: 5, height: 5),
              Text(store.distance,
                  style: const TextStyle(
                      color: const Color(0xffed6363),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0)),
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
  @override
  State<StatefulWidget> createState() {
    return FavoriteStoresPageState();
  }
}
