import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_order/colorTheme/color.dart';

class BottomShopNav extends StatefulWidget {
  final shopName;
  BottomShopNav({Key? key, this.shopName = ""}) : super(key: key);

  @override
  _BottomShopNavState createState() => _BottomShopNavState();
}

class _BottomShopNavState extends State<BottomShopNav> {
  static int _currentIdx = 0;

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/bottomNav/${iconName}.svg", width: 32.w),
      label: label,
      activeIcon: SvgPicture.asset("assets/bottomNav/${iconName}Selected.svg",
          width: 32.w),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomAppBar(
      child: widget.shopName != ""
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 23.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child: Text(widget.shopName)),
                        Container(
                            width: 90.w,
                            height: 36.h,
                            color: Color(0xff00276b)),
                      ],
                    ),
                  ),
                ),
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: ColorThemes().selectedColor,
                  selectedLabelStyle: TextStyle(
                      color: ColorThemes().selectedColor, fontSize: 12.sp),
                  onTap: (int idx) => setState(() {
                    _currentIdx = idx;
                  }),
                  currentIndex: _currentIdx,
                  items: [
                    _bottomNavigationBarItem("icHome", "홈"),
                    _bottomNavigationBarItem("icFav", "단골 매장"),
                    _bottomNavigationBarItem("icOrder", "주문내역"),
                    _bottomNavigationBarItem("icMyPage", "내 정보"),
                  ],
                  elevation: 4,
                ),
              ],
            )
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorThemes().selectedColor,
              selectedLabelStyle: TextStyle(
                  color: ColorThemes().selectedColor, fontSize: 12.sp),
              onTap: (int idx) => setState(() {
                _currentIdx = idx;
              }),
              backgroundColor: Colors.white,
              currentIndex: _currentIdx,
              items: [
                _bottomNavigationBarItem("icHome", "홈"),
                _bottomNavigationBarItem("icFav", "단골 매장"),
                _bottomNavigationBarItem("icOrder", "주문내역"),
                _bottomNavigationBarItem("icMyPage", "내 정보"),
              ],
              elevation: 4,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bottomNavigationBarWidget();
  }
}
