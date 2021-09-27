import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:save_order/colorTheme/color.dart';
import 'package:save_order/model/User.dart';
import 'package:save_order/page/order_takeout.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';

class BottomNav extends StatefulWidget {


  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() =>
      _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIdx = 0;


  _BottomNavState();

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
  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    NearStoresPage(),
    FavoriteStoresPage(),
    MyOrderPage()
    // SnackBar(content: Row(children: [
    //   Text("주문 내역을 볼 수 있는 기능이 아직 구현되지 않았습니다. ")
    // ]), duration: Duration(seconds: 3))
    ,
    UserPage(),
    // SnackBar(content: Row(children: [
    //   Text("내 정보를 볼 수 있는 기능이 아직 구현되지 않았습니다. ")
    // ]), duration: Duration(seconds: 3))
  ];

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorThemes().selectedColor,
      selectedLabelStyle:
          TextStyle(color: ColorThemes().selectedColor, fontSize: 12.sp),
      onTap: (int idx) => setState(() {
        currentIdx = idx;
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
    // Scaffold(
    //   backgroundColor: Colors.white,

    //   body: this.initialValue != 4
    //       ? Container(
    //           color: Colors.white,
    //           child: Column(children: [_widgetOptions[currentIdx]]))
    //       : Card(
    //           color: Colors.white,
    //           elevation: 0,
    //         ),
    //   bottomNavigationBar: _bottomNavigationBarWidget(),
    // );
  }
}

// Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 2,
//           leading: IconButton(
//               onPressed: () => Get.back(),
//               icon: SvgPicture.asset(
//                 "assets/icons/ic_qrcode.svg",
//                 color: Color.fromRGBO(34, 34, 34, 1),
//               )),
//           centerTitle: true,
//           title: Text(appBarTitles[currentIdx],
//               style:
//                   TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
//           actions: [
//             IconButton(
//               onPressed: () => print("검색하기"),
//               icon: SvgPicture.asset(
//                 "assets/icons/searchIcon.svg",
//                 color: Color.fromRGBO(34, 34, 34, 1),
//               ),
//             ),
//           ]),
//       body: this.initialValue != 4
//           ? Container(
//               color: Colors.white,
//               child: Column(children: [_widgetOptions[currentIdx]]))
//           : Card(
//               color: Colors.white,
//               elevation: 0,
//             ),
//       bottomNavigationBar: _bottomNavigationBarWidget(),
//     );