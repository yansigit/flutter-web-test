import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/access/ic_gps.png", color: Colors.black54, width: 50.w, height: 50.h),
                Container(
                    margin: EdgeInsets.only(left: 7.w),
                    height: 40.h,
                    child: FittedBox(fit: BoxFit.fitHeight, child: Text("아름드림이 내 근처 상점을 찾기 위해\n GPS 권한을 요청합니다."))),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/access/ic_internet.png", color: Colors.black54, width: 50.w, height: 50.h),
                Container(
                    margin: EdgeInsets.only(left: 7.w),
                    height: 35.h,
                    child: FittedBox(fit: BoxFit.fitHeight, child: Text("아름드림이 내 근처 상점을 찾기 위해\n GPS 권한을 요청합니다."))),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/access/ic_gps.png", color: Colors.black54, width: 35.w, height: 35.h),
                Container(
                    margin: EdgeInsets.only(left: 7.w),
                    height: 35.h,
                    child: FittedBox(fit: BoxFit.fitHeight, child: Text("아름드림이 내 근처 상점을 찾기 위해\n GPS 권한을 요청합니다."))),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/access/ic_gps.png", color: Colors.black54, width: 35.w, height: 35.h),
                Container(
                    margin: EdgeInsets.only(left: 7.w),
                    height: 35.h,
                    child: FittedBox(fit: BoxFit.fitHeight, child: Text("아름드림이 내 근처 상점을 찾기 위해\n GPS 권한을 요청합니다."))),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
