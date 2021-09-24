import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CafeNameWidget extends StatelessWidget {
  String name;

  CafeNameWidget(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  this.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
              height: 49.h),
          GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: new BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(90), right: Radius.circular(90)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 19.h,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            "즐겨찾기",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      //TODO 즐겨찾기 이미지 체크
                      Container(
                        margin: EdgeInsets.only(left: 7.w),
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/favIcon.svg",
                            ),
                            onPressed: null,
                          ),
                        ),
                        height: 100.h,
                        width: 18.w,
                      ),
                    ],
                  ),
                ),
                width: 110.w,
                height: 40.h,
              ),
              onTap: () => print("즐겨찾기"))
        ],
      ),
    );
  }
}
