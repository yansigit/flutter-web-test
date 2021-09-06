import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/consts/color.dart';
import '/consts/size.dart';
import '/model/Order.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrderPageState extends State<MyOrderPage> {
  List<Order> _orders = <Order>[];
  List<MyMenu> _mockMyMenus = <MyMenu>[];
  var orderedStoreLength = 0;
  var eachOrderLength = 0;

  MyOrderPageState() {
    _orders = <Order>[];
    _orders.add(new Order());
    orderedStoreLength = _orders.length;
    _mockMyMenus.add(new MyMenu());
    _mockMyMenus.add(new MyMenu());
    eachOrderLength = _mockMyMenus.length;
  }

  Widget build(BuildContext context) {
    if (!(this._orders == null)) {
      orderedStoreLength = this._orders.length;
    }

    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Text(this.orderedStoreLength.toString() + "개"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ElevatedButton(
              
                onPressed: () => {} // 검색해서 view 바꾸는 함수
                ,
                child: Row(children: <Widget>[
                  Text("인기순",
                      style: TextStyle(
                          color: const Color(0xff666666),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.left),
                ]),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(WHITE),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallRadiusSize),
                    )),
                    
                    ),
                    )
          ],
        ),
        this.orderedStoreLength == 0
            ? Center(
                child: Column(
                  children: [
                    SvgPicture.asset("images/icon/emptyOrder.svg"),
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
              )
            : ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: this._orders.length,
                itemBuilder: (context, index) {
                  return buildStoreView(context, this._orders[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )
      ],
    ));
  }

  Widget buildStoreView(BuildContext context, Order order) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: const Color(0xffededed), width: 1),
          boxShadow: [
            BoxShadow(
                color: const Color(0x0d000000),
                offset: Offset(0, 6),
                blurRadius: 12,
                spreadRadius: 0)
          ],
          color: const Color(0xffffffff)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 19, width: 20),
              Text(
                "주문확인",
                style: const TextStyle(
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
              ),
              SizedBox(width: 220, height: 7),
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
                                                      "images/icon/trash.svg"),
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
                                              width: 70,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(90)),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffe8e8e8),
                                                      width: 1),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color(
                                                            0x0d000000),
                                                        offset: Offset(0, 2),
                                                        blurRadius: 4,
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
                                        Text("어반포레스트 석촌호수점",
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
                                          "주문 내역 (" + this.eachOrderLength.toString() + ")",  // 후에 고치기 상점마다 주문한 메뉴들 개수
                                          style: const TextStyle(
                                              color:  const Color(0xff222222),
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "NotoSans",
                                              fontStyle:  FontStyle.normal,
                                              fontSize: 18.0
                                          ),
                                          textAlign: TextAlign.left                
                                          )
                                          ],
                                        ),
                                        this.eachOrderLength == 0 ? 
                                        Column(
                                          children: [
                                            SvgPicture.asset("images/icon/emptyOrder.svg"),
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
                                        )
                                        : SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          child: ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return buildOrderDetailView(
                                                      context,
                                                      _mockMyMenus[index]);
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider();
                                                },
                                                itemCount: this._orders.length),
                                          ),
                                          // Expanded(
                                          //   // 후에 고치기
                                          //   child: ListView.separated(
                                          //       itemBuilder: (context, index) {
                                          //         return buildOrderDetailView(
                                          //             context,
                                          //             _mockMyMenus[index]);
                                          //       },
                                          //       separatorBuilder:
                                          //           (context, index) {
                                          //         return Divider();
                                          //       },
                                          //       itemCount: this._orders.length),
                                          // )
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
                      fixedSize: MaterialStateProperty.all<Size>(Size(85, 38))))
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
                    order.orderDetail,
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

  Widget buildOrderDetailView(BuildContext context, MyMenu myMenu) {
    return Row(
      children: [
        SvgPicture.asset(myMenu.menuThumbnail),
        Column(
          children: [
            Text(myMenu.menuName,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0),
                textAlign: TextAlign.left),
            Text(
              myMenu.orderDetail,
              style: const TextStyle(
                  color:  const Color(0xff707070),
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSans",
                  fontStyle:  FontStyle.normal,
                  fontSize: 14.0
              ),
              textAlign: TextAlign.left                
              )
          ],
        )
      ],
    );
  }
}

class MyOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyOrderPageState();
  }
}
