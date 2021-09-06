import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_order/colorTheme/color.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorThemes().selectedColor,
      selectedLabelStyle:
          TextStyle(color: ColorThemes().selectedColor, fontSize: 12.sp),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bottomNavigationBarWidget();
  }
}
