import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';
import 'package:save_order/view/pages/login/SignUpPage.dart';
import 'package:save_order/view/pages/login/email_login_page.dart';
import 'package:save_order/view/pages/login/login_result.dart';
import 'package:save_order/view/pages/login/personal_info_agree_page.dart';
import 'package:save_order/widget/bottom_nav.dart';
import 'package:save_order/consts/cafe.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/consts/login.dart';
import 'package:save_order/consts/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO this is for Web. Need to change for App.
//import 'package:kakao_flutter_sdk/all.dart';

class LoginPageState extends State<LoginPage> {
  @override
  var token;

  void initState() {
    super.initState();
    //TODO this is for Web. Need to change for App.
    /*_initKakaoTalkInstalled();*/
  }

  //TODO this is for Web. Need to change for App.
  /*_
  initKakaoTalkInstalled() async {
    KakaoContext.clientId = "00805ee18d68cdbdd4eac842f5e6e391";
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }
  */

  @override
  void dispose() {
    super.dispose();
  }
  //TODO this is for Web. Need to change for App.
  /*
  bool _isKakaoTalkInstalled = true;

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      // AccessTokenStore.instance.toStore(token);
      this.token = token;

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearStoresPage()));
      //NearStoresPage()
      //MyOrderPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")
      //FavoriteStoresPage(token: "5857D43CE90E3B412D0A69D564764F0F4388B76A")
      //UserPage()));
      //MyOrderPage();
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }
  

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }
  */

  

  @override
  Widget build(BuildContext context) {
    // 	KakaoContext.clientId = "${put your native app key here}"
    // // KaKao javascript key
    //  KakaoContext.javascriptClientId = "${put your javascript key here}"
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: ScreenUtil().screenHeight,
          margin: EdgeInsets.only(top: 87.h, left: 30.w, right: 30.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 55.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(CAFFE_NAME, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                ),
                Container(
                  height: 27.h,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(CAFFE_PHRASES,
                        style: const TextStyle(
                          color: PHRASE_COLOR,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Noto Sans",
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24.5.h, top: 10.9.h),
                  height: 291.5.h,
                  width: 325.8.w,
                  child: FittedBox(fit: BoxFit.fitHeight, child: SvgPicture.asset("assets/icons/arumDreamLogo.svg")),
                ),
                ElevatedButton(
                    child: Container(
                        height: 54.h,
                        width: 315.w,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                          Container(
                            height: 14.4.h,
                            width: 18.w,
                            child: FittedBox(
                                child: SvgPicture.asset(
                              "assets/icons/emailIcon.svg",
                              fit: BoxFit.fitHeight,
                            )),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 8.w),
                              height: 20.h,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(EMAIL_LOGIN,
                                    style: TextStyle(
                                        // fontSize: 14,
                                        fontFamily: "Noto Sans",
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff00276b))),
                              ))
                        ])),
                    onPressed: () {
                      Get.to(() => EmailLoginPage(), transition: Transition.rightToLeft);
                     
                    }, // 이메일 로그인 api 불러오기
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: const Color(0xff00276b), width: 1.w)),
                      backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(loginRaiusSize))),
                    )),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 15.w, right: 16.5.w, top: 26.h, bottom: 26.h),
                        child: Divider(
                          color: Color(0xffd1d1d1),
                          height: 10.h,
                        )),
                  ),
                  Container(
                    height: 16.h,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text("OR",
                          style: TextStyle(
                            color: const Color(0xff222222),
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                  ),
                  Expanded(
                    child: new Container(
                        margin: EdgeInsets.only(left: 16.5.w, right: 15.w, top: 26.h, bottom: 26.h),
                        child: Divider(
                          color: Color(
                            0xffd1d1d1,
                          ),
                          height: 10.h,
                        )),
                  ),
                ]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  ElevatedButton(
                      child: Container(
                        height: 54.h,
                        width: 315.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 16.h,
                              width: 16.w,
                              child: FittedBox(fit: BoxFit.fitHeight, child: SvgPicture.asset("assets/icons/kakaoIcon.svg")),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.4.w),
                              height: 24.h,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(KAKAO_LOGIN, style: TextStyle(color: kAKAO_TEXT_COLOR, fontWeight: FontWeight.w700)),
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 1000), content: Text("베타테스트 기간 동안에는 카카오 로그인 기능을 지원하지 않습니다. 이메일로 회원 가입을 해주세요.")));
                      }, // 카카오톡 로그인 api 불러오기
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(KAKAO_COLOR),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0.w))),
                      )),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  //   height: 54.h,
                  //   child: ElevatedButton(
                  //     child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: <Widget>[
                  //           Container(
                  //             height: 20.h,
                  //             child: FittedBox(
                  //                 fit: BoxFit.fitHeight,
                  //                 child: SvgPicture.asset(
                  //                     "assets/icons/appleIcon.svg",
                  //                     fit: BoxFit.fitHeight)),
                  //           ),
                  //           Container(
                  //             margin: EdgeInsets.only(left: 8.7.w),
                  //             height: 20.h,
                  //             child: FittedBox(
                  //               fit: BoxFit.fitHeight,
                  //               child: Text(APPLE_LOGIN,
                  //                   style: TextStyle(
                  //                       color: Color(0xffffffff),
                  //                       fontFamily: "NotoSans",
                  //                       fontWeight: FontWeight.w700)),
                  //             ),
                  //           )
                  //         ]),
                  //     onPressed: () => {
                  //       showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return AlertDialog(
                  //                 content: Text(
                  //                     "아직 애플 로그인 기능이 구현되지 않았습니다. 카카오 로그인이나 회원가입을 이용해 주시길 바랍니다."));
                  //           })
                  //     }, // 애플 로그인 api 불러오기

                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(DARK_BLUE),
                  //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //           RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.circular(loginRaiusSize))),
                  //     ),
                  //   ),
                  // ),
                ]),
                GestureDetector(
                  onTap: () => Get.to(PersonalInfoAgreePage()),
                  child: Container(
                      margin: EdgeInsets.only(left: 8.w, top: 27.h),
                      height: 30.h,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text(SIGN_UP,
                                style: TextStyle(
                                    backgroundColor: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff00276b),
                                    fontFamily: "NotoSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0)))
                      ])),
                )
              ],
            ),
          ),
        ));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}
