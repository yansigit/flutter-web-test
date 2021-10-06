import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:save_order/amplifyconfiguration.dart';
import 'package:save_order/home.dart';
import 'package:save_order/page/access_confirm.dart';
import 'package:save_order/page/now_payment.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/login/SignUpPage.dart';
import 'package:save_order/view/pages/login/email_login_page.dart';

import 'package:save_order/view/pages/login/login_page.dart';
import 'package:save_order/view/pages/login/password_chage_page.dart';
import 'package:save_order/view/pages/login/password_find_page.dart';
import 'package:save_order/view/pages/login/personal_info_agree_page.dart';

import 'model/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Shop> shopList = [];

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light) //Or Brightness.dark
    //     );
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ScreenUtilInit(designSize: Size(375, 812), builder: () => GetMaterialApp(home: Splash()));
        } else {
          // shopList = snapshot.data;
          // print("Data" + shopList.toString());
          // Loading is done, return the app:
          return ScreenUtilInit(
              designSize: Size(375, 812),
              builder: () => GetMaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.white, fontFamily: 'Noto Sans'),
                  home:
                      //MyOrderPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")
                      //NearStoresPage()
                      // UserPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")
                      //FavoriteStoresPage(token: "5857D43CE90E3B412D0A69D564764F0F4388B76A")
                      // LoginPage()
                      AccessPage()

                  //SignUp()
                  //PasswordChangePage()
                  //PasswordFindPage()
                  //SignUp()
                  //PersonalInfoAgreePage()
                  //Home(shopList: shopList),
                  ));
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF).withOpacity(1.0),
      body: Center(child: Image.asset('assets/splash/Img_Splash.png')),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialsize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!

    await Future.delayed(Duration(seconds: 1));
    //return await Shop.fetchShops(http.Client());
  }
}
