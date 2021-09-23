import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderStatusPage extends StatefulWidget {
  OrderStatusPage({Key? key}) : super(key: key);

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  int orderStatusPointer = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 뷰에 그릴 때 받아오기.
    this.orderStatusPointer = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight * 0.95,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.h), topRight: Radius.circular(30.h)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 11.w,
              top: 11.h,
            ),
            width: 32.w,
            height: 32.h,
            child: IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: (() => Get.back()),
            ),
          ),
          OrderNumAppBar(),
          CafeNameContainer(),
          StatusContainer(statusPointer: orderStatusPointer),
          ExpandableList(),
          PriceContainer(),
        ],
      ),
    );
  }
}

class PriceContainer extends StatelessWidget {
  const PriceContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 20.w,
          right: 20.w,
          bottom: 33.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 22.h,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "최종 결제 금액",
                  style: TextStyle(color: Color(0xff707070)),
                ),
              ),
            ),
            Container(
              height: 27.h,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  "4,000원",
                  style: TextStyle(
                    color: Color(0xff00276b),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CafeNameContainer extends StatelessWidget {
  const CafeNameContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      height: 31.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(color: Colors.blue, width: 29.w, height: 22.h),
          Container(
            margin: EdgeInsets.only(left: 6.w),
            height: 31.h,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                "달보드레 잠실점",
                style: TextStyle(
                  color: Color(0xff00276b),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderNumAppBar extends StatelessWidget {
  const OrderNumAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18.h, left: 20.w, right: 20.w),
      height: 33.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 33.h,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "주문 번호  ",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: 33.h,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "01",
                    style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xffed6363)),
                  ),
                ),
              ),
            ],
          ),
          InkWell(
              child: Container(
                width: 92.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(color: Color(0xffe8e8e8)),
                  borderRadius: BorderRadius.all(Radius.circular(90.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.blue,
                      width: 24.w,
                      height: 24.h,
                      margin: EdgeInsets.only(right: 2.w),
                    ),
                    Container(
                      height: 20.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "새로고침",
                          style: TextStyle(color: Color(0xff666666)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (() => print("refresh"))),
        ],
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  final statusPointer;
  StatusContainer({
    Key? key,
    required this.statusPointer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> statusFlag = [false, false, false, false];

    for (int i = 0; i < statusPointer; i++) {
      statusFlag[i] = true;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.h),
            height: 1,
            color: Color(0xffe8e8e8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statusIcon("ic_payment", statusFlag[0], "결제 완료"),
              statusIcon("ic_requestOrder", statusFlag[1], "주문 요청"),
              statusIcon("ic_requestApprove", statusFlag[2], "주문 승인"),
              statusIcon("ic_produce", statusFlag[3], "제조 완료"),
            ],
          ),
        ],
      ),
    );
  }

  Widget statusIcon(String name, bool flag, String text) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: flag ? Color(0xff00276b) : Color(0xfff8f8f8),
            borderRadius: BorderRadius.all(Radius.circular(90.h)),
          ),
          child: SvgPicture.asset(
            "assets/icons/${name}.svg",
            fit: BoxFit.scaleDown,
            color: flag ? Color(0xffffffff) : Color(0xffd1d1d1),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.h),
          height: 19.h,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              text,
              style: TextStyle(color: flag ? Color(0xff00276b) : Color(0xff999999), fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool expandFlag = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Color(0x05000000),
        child: Column(
          children: [
            InkWell(
              onTap: (() {
                setState(() {
                  expandFlag = !expandFlag;
                });
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 24.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "주문 내역 (6)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 24.h,
                      width: 24.w,
                      child: Icon(
                        !expandFlag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        color: Color(0xff777777),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffe8e8e8),
            ),
            Container(
              child: ExpandableContainer(
                expanded: expandFlag,
                expandedHeight: 360.h,
              ),
            ),
          ],
        ));
  }
}

class ExpandableContainer extends StatelessWidget {
  final expanded;
  final collaspedHeight;
  final expandedHeight;
  ExpandableContainer({
    Key? key,
    required this.expanded,
    this.collaspedHeight = 0.0,
    this.expandedHeight = 420.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: expanded ? expandedHeight : collaspedHeight,
      color: Color(0x05000000),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return cartItemWidget();
        }),
        itemCount: 6,
      ),
    );
  }

  Widget cartItemWidget() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90.h)),
              color: Color(0xff815135),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("커피이미지"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.w),
            child: Column(
              children: [
                Container(
                  height: 21.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "아메리카노 2잔",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 4.h),
                    height: 19.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "시원한 / 중간 사이즈",
                        style: TextStyle(
                          color: Color(0xff707070),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
