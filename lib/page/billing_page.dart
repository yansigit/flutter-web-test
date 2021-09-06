import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("결제하기", style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        color: Color(0xffffffff),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              PaymentMethodWidget(),
              ExpandableList(),
              Container(
                color: Color(0xffffffff),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
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
                            style: TextStyle(
                              color: Color(0xff707070),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 27.h,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(
                              "23,000원",
                              style: TextStyle(
                                color: Color(0xff00276b),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x59000000),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
          color: Color(0xffffffff),
        ),
        child: InkWell(
          onTap: (() => print("결제하기")),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 26.h, horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(27.h)),
                color: Color(0xff00276b),
              ),
              height: 48.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 20.w, height: 20.h, color: Colors.red),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    height: 27.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "23,000원",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 27.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "결제하기",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 25.h,
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("결제수단",
                        style: TextStyle(fontWeight: FontWeight.w700)))),
            InkWell(
              onTap: (() => print("카드 결제")),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffededed), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
              ),
            ),
            InkWell(
              onTap: (() => print("현금 결제")),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffededed), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
              ),
            ),
            InkWell(
              onTap: (() => print("모바일 결제")),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffededed), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0d000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableList extends StatefulWidget {
  const ExpandableList({Key? key}) : super(key: key);

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
                        child: Text("주문 내역(6)",
                            style: TextStyle(fontWeight: FontWeight.w700))),
                  ),
                  Container(
                    height: 24.h,
                    width: 24.w,
                    child: Icon(
                      !expandFlag
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
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
            expandedHeight: 400.h,
          )),
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  ExpandableContainer({
    Key? key,
    required this.expanded,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 420.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: expanded ? expandedHeight : collapsedHeight,
      color: Color(0x05000000),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return CartItemWidget();
        }),
        itemCount: 6,
      ),
    );
  }

  Widget CartItemWidget() {
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
            child: FittedBox(fit: BoxFit.scaleDown, child: Text("커피이미지")),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 16.w,
            ),
            child: Column(
              children: [
                Container(
                  height: 21.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "아메리카노",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 4.h),
                    height: 19.h,
                    child: Text(
                      "시원한 / 중간 사이즈",
                      style: TextStyle(
                        color: Color(0xff707070),
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
