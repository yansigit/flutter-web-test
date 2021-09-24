import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/colorTheme/color.dart';
import 'package:save_order/model/User.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';

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

  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    NearStoresPage(),
    FavoriteStoresPage(),
    MyOrderPage(),
    UserPage()
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
         appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              "assets/icons/backIcon.svg",
              color: Color.fromRGBO(34, 34, 34, 1),
            )),
          title: Text("아름 드림", style: TextStyle(fontWeight: FontWeight.w700)),
              actions: [
            IconButton(
              onPressed: () => print("검색하기"),
              icon: SvgPicture.asset(
                "assets/icons/searchIcon.svg",
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ]),
      body: Container(
          color: Colors.white,
        child:
    Column(
      children: [
      _widgetOptions[_currentIdx],
    
    ])
    ),
    bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
