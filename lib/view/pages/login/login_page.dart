import 'package:flutter/material.dart';
import '/consts/cafe.dart';
import '/consts/color.dart';
import '/consts/login.dart';
import '/consts/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
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
      Navigator.pushNamed(context, '/login_result');
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
      return new Container(
          decoration: new BoxDecoration(color: WHITE),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 30)),
              Text(CAFFE_NAME,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black))
            ]),
            Row(children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 30)),
              Text(CAFFE_PHRASES,
                  style: const TextStyle(
                    fontSize: 20,
                    color: SKY_BLUE,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                  )),
            ]),
            SvgPicture.asset("images/ArumDreamLogo.svg"),
            ElevatedButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("images/icon/login/kakaoIcon.svg"),
                    SizedBox(width: 5, height: 5),
                    Text(KAKAO_LOGIN,
                        style: TextStyle(fontSize: 18, color: kAKAO_TEXT_COLOR))
                  ]),
              onPressed: () => _isKakaoTalkInstalled
                  ? _loginWithTalk
                  : null, // 카카오톡 로그인 api 불러오기
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(KAKAO_COLOR),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(loginRaiusSize))),
                  fixedSize: MaterialStateProperty.all<Size>(Size(316, 30))),
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                    )),
              ),
              Text("OR",
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xff222222),
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                  )),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(
                      color: Colors.black,
                      height: 20,
                    )),
              ),
            ]),
            // 애플 로그인 버튼
            ElevatedButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("images/icon/login/appleIcon.svg"),
                    SizedBox(width: 5, height: 5),
                    Text(APPLE_LOGIN,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal))
                  ]),
              onPressed: () => {}, // 애플 로그인 api 불러오기

              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(DARK_BLUE),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(loginRaiusSize))),
                  fixedSize: MaterialStateProperty.all<Size>(Size(315, 20))),
            ),
            //이메일로 로그인
            ElevatedButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset("images/icon/login/emailIcon.svg"),
                    SizedBox(width: 5, height: 5),
                    Text(EMAIL_LOGIN,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            color: const Color(0xff00276b)))
                  ]),
              onPressed: () => {}, // 이메일 로그인 api 불러오기

              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: const Color(0xff00276b), width: 1)),
                  backgroundColor: MaterialStateProperty.all(EMAIL_COLOR),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(loginRaiusSize))),
                  fixedSize: MaterialStateProperty.all<Size>(Size(315, 20))),
            ),
            TextButton(
                onPressed: () => {},
                child: Text(SIGN_UP, style: TextStyle(fontSize: 16.0)))
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
          ]));
    }
  }


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}
