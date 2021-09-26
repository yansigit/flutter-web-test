import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/colorTheme/color.dart';

class TemporaryBottomNav extends StatefulWidget {
  TemporaryBottomNav({Key? key}) : super(key: key);

  @override
  _TemporaryBottomNavState createState() => _TemporaryBottomNavState();
}

class _TemporaryBottomNavState extends State<TemporaryBottomNav> {
  int currentIdx = 0;

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset("assets/bottomNav/${iconName}.svg", width: 32.w),
      label: label,
      activeIcon: SvgPicture.asset("assets/bottomNav/${iconName}Selected.svg",
          width: 32.w),
    );
  }

  static List<String> appBarTitles = <String>[
    "아름 드림",
    "단골 매장",
    "주문 내역",
    "아름 드림"
  ];

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorThemes().selectedColor,
      selectedLabelStyle:
          TextStyle(color: ColorThemes().selectedColor, fontSize: 12.sp),
      onTap: (int idx) => setState(() {
        currentIdx = idx;
        if(idx == 1) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Text(
                        "아직 단골 매장을 볼 수 있는 기능이 구현되지 않았습니다. 기능 구현 예정입니다."));
              });
        }
        if (idx == 2) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Text(
                        "아직 주문 내역을 볼 수 있는기능이 구현되지 않았습니다. 기능 구현 예정입니다."));
              });
        }
        if(idx == 3) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Text(
                        "아직 내 정보를 볼 수 있는 기능이 구현되지 않았습니다. 기능 구현 예정입니다."));
              });
        }
      }),
      currentIndex: currentIdx,
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
