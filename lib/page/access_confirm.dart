import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/state/controllers.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
// import 'package:save_order/view/pages/login/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

//TODO this is for Web. Need to change for App.
// import 'package:permission_handler/permission_handler.dart'
//     if (dart.library.io) 'package:permission_handler/permission_handler.dart';

class AccessPage extends StatefulWidget {
  AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  // 0번은 위치권한, 1번은 카메라권한.
  //TODO this is for Web. Need to change [statusPermissions] for App.
  //List<bool> statusPermissions = [true, true];
  List<bool> statusPermissions = [false, false];
  String token = "";
  // UserController userController = Get.put(UserController());

  //TODO this is for Web. Need to change [statusPermissions] for App.

  // Future getStatusPermissonList() async {
  //   var _statusLocation = await Permission.location.status.isGranted;
  //   var _statusCamera = await Permission.camera.status.isGranted;
  //   setState(() {
  //     statusPermissions[0] = _statusLocation;
  //     statusPermissions[1] = _statusCamera;
  //   });
  // }

  // requestCameraPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     Permission.camera,
  //   ].request();
  //   if (statuses[Permission.camera]!.isGranted) {
  //     setState(() {
  //       statusPermissions[1] = true;
  //     });
  //   }
  //   if (statuses[Permission.location]!.isGranted) {
  //     setState(() {
  //       statusPermissions[0] = true;
  //     });
  //   }
  //   if (!statuses[Permission.camera]!.isGranted ||
  //       !statuses[Permission.location]!.isGranted) {
  //     // 허용이 안된 경우
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             content: Text("권한 설정을 확인해주세요."),
  //             actions: [
  //               ElevatedButton(
  //                   onPressed: () {
  //                     openAppSettings(); // 앱 설정으로 이동
  //                   },
  //                   child: Text('설정하기')),
  //               ElevatedButton(
  //                   onPressed: () async {
  //                     SharedPreferences sharedPreferences =
  //                         await SharedPreferences.getInstance();
  //                     String? token = sharedPreferences.getString("token");

  //                     if (token == null || token.length == 0) {
  //                       Get.off(() => LoginPage(),
  //                           transition: Transition.rightToLeft);
  //                     } else {
  //                       Get.put(UserController());
  //                       UserController userController = Get.find();
  //                       userController.updateUserInfo(
  //                           sharedPreferences.getString("email")!, token);
  //                       Get.off(() => NearStoresPage(),
  //                           transition: Transition.rightToLeft);
  //                     }
  //                   },
  //                   child: Text('계속하기')),
  //             ],
  //           );
  //         });
  //   }
  // }

  // void getTokenFromPrefeences() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString("token");

  //   if (token != null && token.length != 0) {
  //     Get.put(UserController());
  //     UserController userController = Get.find();
  //     userController.updateUserInfo(sharedPreferences.getString("email")!, token);
  //     this.token = token;
  //     print(token);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   //TODO this is for Web. Need to change [statusPermissions] for App.

  //   // if (!GetPlatform.isWeb) {
  //   //   getStatusPermissonList();
  //   // } else {
  //   //   statusPermissions[0] = true;
  //   //   statusPermissions[1] = true;
  //   // }

  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     getTokenFromPrefeences();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //return LoginPage();
    //TODO this is for Web. Need to change [statusPermissions] for App.
    //for Web
    return statusPermissions[0] == false && statusPermissions[1] == false
        ? NearStoresPage()
        : Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 45.0.w,
                    vertical: 200.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe6e6e6), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.w),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 250.h,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: 59.h,
                                            child: Image.asset("assets/access/ic_gps.png", color: Colors.black54, fit: BoxFit.scaleDown),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: 60.h,
                                            child: Text(
                                              "아름드림이 근처 매장을 조회하기 위해 사용자의 위치 정보를 요청합니다.(선택)",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: 30.h,
                                            child: Image.asset(
                                              "assets/access/ic_camera.png",
                                              color: Colors.black54,
                                              height: 30.h,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: 54.h,
                                            child: Text(
                                              "아름드림이 카드 스캔을 위해\n카메라 사용 권한을 요청합니다.(선택)",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff00276b),
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () {
                                  //requestCameraPermission();
                                  //Get.off(() => LoginPage());
                                },
                                child: Text("권한 요청"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
