import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/view/pages/UserPage.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FavoriteStoresPageState.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/FindNearStore.dart';
import 'package:save_order/view/pages/bottomNavConnectPages/MyOrderPage.dart';
import 'package:save_order/view/pages/login/login_result.dart';
import '/consts/cafe.dart';
import '/consts/color.dart';
import '/consts/login.dart';
import '/consts/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginPageState extends State<LoginPage> {
  @override
  var token;

  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    KakaoContext.clientId = "00805ee18d68cdbdd4eac842f5e6e391";
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isKakaoTalkInstalled = true;

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      this.token = token;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              //MyOrderPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")
              //NearStoresPage()
              //MyOrderPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")
              //FavoriteStoresPage(token: "5857D43CE90E3B412D0A69D564764F0F4388B76A")
              UserPage("5857D43CE90E3B412D0A69D564764F0F4388B76A")));
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

  @override
  Widget build(BuildContext context) {
    // 	KakaoContext.clientId = "${put your native app key here}"
    // // KaKao javascript key
    //  KakaoContext.javascriptClientId = "${put your javascript key here}"
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: new Container(
            decoration: new BoxDecoration(color: WHITE),
            child: Container(
              margin: EdgeInsets.only(top: 87.h, left: 30.w, right: 30.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 55.h,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(CAFFE_NAME,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
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
                              fontFamily: "NotoSans",
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/arumDreamLogo.svg",
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24.5.h, bottom: 15.h),
                          child: ElevatedButton(
                              child: Container(
                                height: 54.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 18.h,
                                      child: SvgPicture.asset(
                                          "assets/icons/kakaoIcon.svg",
                                          fit: BoxFit.fitHeight),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.4.w),
                                      height: 24.h,
                                      child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Text(KAKAO_LOGIN,
                                            style: TextStyle(
                                                color: kAKAO_TEXT_COLOR,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onPressed: () =>
                                  _loginWithTalk(), // 카카오톡 로그인 api 불러오기
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(KAKAO_COLOR),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            loginRaiusSize))),
                              )),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                                margin:
                                    EdgeInsets.only(left: 15.w, right: 16.5.w),
                                child: Divider(
                                  color: Color(0xffd1d1d1),
                                  height: 20,
                                )),
                          ),
                          Container(
                            height: 22.h,
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
                                margin:
                                    EdgeInsets.only(left: 16.5.w, right: 15.w),
                                child: Divider(
                                  color: Color(0xffd1d1d1),
                                  height: 20.h,
                                )),
                          ),
                        ]),
                        // 애플 로그인 버튼
                        Container(
                          margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
                          height: 54.h,
                          child: ElevatedButton(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 20.h,
                                    child: SvgPicture.asset(
                                        "assets/icons/appleIcon.svg",
                                        fit: BoxFit.fitHeight),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8.7.w),
                                    height: 24.h,
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Text(APPLE_LOGIN,
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontFamily: "NotoSans",
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  )
                                ]),
                            onPressed: () => {}, // 애플 로그인 api 불러오기

                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(DARK_BLUE),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          loginRaiusSize))),
                            ),
                          ),
                        ),
                        //이메일로 로그인
                        Container(
                          height: 54.h,
                          child: ElevatedButton(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 14.4.h,
                                      child: SvgPicture.asset(
                                        "assets/icons/emailIcon.svg",
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.w),
                                      height: 24.h,
                                      child: Text(EMAIL_LOGIN,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "NotoSans",
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff00276b))),
                                    )
                                  ]),
                              onPressed: () => {}, // 이메일 로그인 api 불러오기

                              style: ButtonStyle(
                                side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(
                                        color: const Color(0xff00276b),
                                        width: 1.w)),
                                backgroundColor:
                                    MaterialStateProperty.all(EMAIL_COLOR),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            loginRaiusSize))),
                              )),
                        ),

                        TextButton(
                            onPressed: () => {},
                            child:
                                Text(SIGN_UP, style: TextStyle(fontSize: 16.0)))
                      ],
                    ),
                    // 회원가입하는 버튼
                    // TextButton(onPressed: () => {},
                    //            child: Text(SIGN_UP, style: TextStyle( fontWeight: FontWeight.w400,
                    //                                                   color: darkBlue,
                    //                                                 fontFamily: "NotoSans",
                    //                                                 fontStyle:  FontStyle.normal,
                    //                                                 fontSize: 16.0)))

                    // TextButton(
                    //   child: Text(

                    //   )
                    // )
                  ]),
            )));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}
