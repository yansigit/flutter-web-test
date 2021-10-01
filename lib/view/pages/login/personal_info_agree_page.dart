import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/consts/color.dart';
import 'package:save_order/view/pages/login/SignUpPage.dart';

class PersonalInfoAgreePage extends StatefulWidget {
  @override
  PersonalInfoAgree createState() => PersonalInfoAgree();
}

class PersonalInfoAgree extends State<PersonalInfoAgreePage> {
  @override
  void initState() {
    super.initState();
    this.emailColor = DEFAULT_COLOR;
  }

  Color DEFAULT_COLOR = Colors.white;

  bool isAgreedForPersonalInfo = false;
  bool isAgreedForTermsOfUse = false;
  Color? emailColor;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  List<String> agreedContents = [
    '''
    달보드레 서비스 회원가입을 하시면, 카페의 메뉴를 앱으로 편하게 결제 할 수 있습니다.
    ''',
    '''개인정보보호법에 따라 달보드레에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
1. 수집하는 개인정보
 이용자가 베타 테스트 기간동안 달보드레를 이용하기 위해 회원가입을 할 경우, 달보드레는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 달보드레가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 휴대전화번호’를 필수항목으로 수집합니다.  그
서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
아름드림 내의 카페에서 메뉴 선택 결제를 했을 때의 정보가 들어가야 합니다. 
서비스 이용 과정에서 위치정보, 카메라 정보가 생성되어 수집될 수 있습니다. 

2. 수집한 개인정보의 이용
달보드레의 회원관리, 서비스 개발・제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.

- 회원 가입 의사의 확인, , 이용자의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.

- 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
3. 개인정보의 보관기간
달보드레 베타테스트 기간인 10.4 ~ 10.8 일 까지 보관합니다.

4. 개인정보 수집 및 이용 동의를 거부할 권리
이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입 시 수집하는 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입이 어려울 수 있습니다.
                          '''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 325.w,
          height: 700.h,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 25.h,
                width: 280.w,
                margin: EdgeInsets.only(left: 8.w),
                child: Row(
                  children: [
                    Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          value: this.isAgreedForTermsOfUse,
                          onChanged: (bool? value) {
                            setState(() {
                              this.isAgreedForTermsOfUse = value!;
                            });
                          },
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      margin: EdgeInsets.only(left: 10.w),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("이용 약관 동의 (필수)",
                            style: TextStyle(
                                fontFamily: "NotoSans", fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  width: 250.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: const Color.fromRGBO(226, 226, 226, 10)),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: this._scrollController,
                    child: new SingleChildScrollView(
                       controller: this._scrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text(agreedContents[0])],
                        )),
                  )),
              Container(
                height: 25.h,
                width: 280.w,
                margin: EdgeInsets.only(left: 8.w),
                child: Row(
                  children: [
                    Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          value: this.isAgreedForPersonalInfo,
                          onChanged: (bool? value) {
                            setState(() {
                              this.isAgreedForPersonalInfo = value!;
                            });
                          },
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      margin: EdgeInsets.only(left: 10.w),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text("개인 정보 수집 및 이용 동의 (필수)",
                            style: TextStyle(
                                fontFamily: "NotoSans", fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  width: 250.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: const Color.fromRGBO(226, 226, 226, 10)),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: this._scrollController2,
                    child: new SingleChildScrollView(
                        controller: this._scrollController2,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text(agreedContents[1])],
                        )),
                  )),
              ElevatedButton(
                  onPressed: () {
                    if (isAgreedForPersonalInfo && isAgreedForTermsOfUse) {
                      print(isAgreedForPersonalInfo);
                      this.setState(() {
                        this.emailColor = Colors.white;
                      });
                      Get.to(() => SignUp());
                    } else {
                      setState(() {
                        this.emailColor = Colors.grey;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 1500),
                          content:
                              Text(" 개인 정보 수집 및 이용과 이용 약관에 대해 모두 동의해주세요.")));
                    }
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: const Color(0xff00276b), width: 1.w)),
                    backgroundColor: MaterialStateProperty.all(this.emailColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.w))),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(
                          right: 10.w, bottom: 8.h, top: 10.h, left: 10.w),
                      width: 250.w,
                      height: 25.h,
                      child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("다음",
                              style: TextStyle(
                                  backgroundColor: this.emailColor,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.orange,
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.0))))),
            ],
          ),
        ),
      ),
    );
  }
}
