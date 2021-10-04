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

  bool firstAgreed = false;
  bool secondAgreed = false;
  bool thirdAgreed = false;
  bool fourthAgreed = false;
  bool fifthAgreed = false;

  Color? emailColor;
  final ScrollController _rootController = ScrollController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final ScrollController _scrollController3 = ScrollController();
  final ScrollController _scrollController4 = ScrollController();
  final ScrollController _scrollController5 = ScrollController();
  List<String> agreedContents = [
    '''  1. 서문
<달보드레>는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 '정보통신망법'이라함) 등 관련법령(이하 '관련법령'이라 함)에 근거하여 수집 · 보유 및 처리되고 있습니다.회사는 관련법령에 따라 정보 주체의 개인정보를 보호하고, 이를 원할히 활용할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 • 공개합니다. 본 방침은 2021년 10월 04일부터 시행됩니다.

  2. 수집하는 개인정보의 항목
  <달보드레>는 회원에게 원활한 “아름드림” 서비스 제공을 위해 다음과 같은 개인정보를 수집하고 있습니다.

  ① 필수입력사항 : 이름, 이메일, 비밀번호, 휴대전화번호
  ② 서비스 이용 또는 사업처리 과정에서 생성 수집되는 각종 거래 및 개인 성향 정보 : 서비스 이용기록(이용기간, 이용매장, 포인트, 상품 또는 서비스 구매내역), 접속 로그, 쿠키, 접속IP정보, 결제기록 등
  ③모바일 서비스 이용 시 단말기에 관한 정보 : 단말기 모델명, 이동통신사 정보, 하드웨어 ID
  ※ 상기 단말기에 관한 정보는 개인을 식별할 수 없는 형태이며 수집된 정보를 바탕으로 개인을 식별하는 일체의 활동을 하지 않습니다.
  ④ 선택 사항 : 회원의 위치 정보 : 회원은 개인정보의 수집에 동의를 거부할 수 있습니다. (단, 거부할 시 근처 카페 찾기 서비스가 이용이 제한되거나 불가능할 수 있습니다.)
  ⑤ 개인정보의 수집 동의 거부 : 회원은 개인정보의 수집에 동의를 거부할 수 있습니다. (단, 필수수집항목의 개인정보 수집을 거부할 경우 회원가입이 불가합니다.)

  3. 개인정보의 처리 목적
  제1조(개인정보의 처리목적)
  <달보드레>는 다음의 목적을 위해 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 “개인정보 보호법 제18조”에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

  ① 아름드림 서비스 회원 가입 및 관리
  회원 가입의사 확인, 아름드림 서비스 제공에 필요한 본인 식별•인증, 서비스 부정이용 방지, 각종 고지•통지의 목적으로 개인정보를 처리합니다. (만 14세 미만의 아동의 경우 가입이 제한됩니다.)

  ② 재화 또는 서비스 제공
  음료 주문, 주문 내역 확인, 결제•정산, 쿠폰 적용, 근처 카페 찾기를 위해 개인정보 및 위치 정보를 처리합니다.

  ③ 베타 테스트의 개선
  본 서비스는 “베타 테스트”를 진행중이므로, 향후 서비스를 개선하기 위해, 회원의 단말정보, 서비스 이용기록을 이용합니다.

  4. 개인정보 수집방법
  회사는 다음과 같은 방법으로 개인정보를 수집합니다.
  ① 회원가입
  ② 제휴사로부터의 제공
  ③ Application에 의한 정보 수집
  ④'쿠키(cookie)'에 의한 정보 수집

  6. 정보주체와 법정대리인의 권리•의무 및 행사방법
  ① 회원은 <달보드레>에 대해 언제든지 개인정보 열람•정정•삭제•처리정지 요구 등의 권리를 행사할 수 있습니다.
  ② 제1항에 따른 권리 행사는 <달보드레>에 대해 개인정보보호법 시행령 제41조제1항에 따라 서면, 전자우편 등을 통하여 하실 수 있으며, <달보드레>는 이에 대해 지체없이 조치하겠습니다.
  ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 “개인정보 처리 방법에 관한 고시(제2020호-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야합니다.
  ④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
  ⑤ 개인정보의 열람, 정정, 삭제, 처리, 정지 요구가 다른 법령상의 의무를 준수하기 위하여 불가피한 경우, 다른 사람의 생명, 신체를 해할 우려가 있거나 다른 사람의 재산과 그 밖의 이익을 부당하게 침해할 우려가 있는 경우, 개인정보를 처리하지 아니하면 정보주체와 약정한 서비스를 제공하지 못하는 등 계약이행이 곤란한 경우는 요구를 거절할 수 있습니다.
  ⑥ <달보드레>는 정보주체의 권리에 따른 열람의 요구, 정정
  •삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.

  7. 개인정보 파기 절차 및 방법
  ① <달보드레>는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 경우에는 지체없이 해당 개인정보를 파기합니다.
  ② <달보드레>는 수집한 개인정보를 2021년 10월 15일에 지체없이 파기합니다.
  ③ 파기절차
  가. 2021년 10월 15일이 되었을 때 회사의 DB(데이터베이스)의 개인정보 관련 DB(데이터베이스)를 모두 초기화 합니다.
  ④ 파기방법
  가. 종이 서식은 존재하지 않으며, 전자적 문서로 저장된 개인정보는 기록을 재생할 수 없는 방법을 사용해 삭제합니다.

  8. 개인정보의 안정성 확보 조치
  ① 관리적 조치 : 내부관리계획 수립•시행, 정기적 직원 교육 등
  ② 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, DB 접속 기록
  ③ 물리적 조치 : 원격지 서버 설치

  9. 개인정보 보호책임자
  ① 개인정보 보호책임자
  - 성명 : 김민우
  - 직책 : <달보드레> 대표
  - 연락처 : 010-2366-6951, contact@dalbodre.me, dalbdore052@dalbodre.me
  ② 정보주체는 <달보드레>의 아름드림 서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. <달보드레>는 정부주체의 문의에 대해 지체없이 답변 및 처리해드릴 것입니다.

  10. 고지의 의무
  이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 가능한 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.

  - 개인정보취급방침 버전번호 : v1.0
  - 개인정보처리방침 공고일자 : 2021년 09월 28일
  - 개인정보처리방침 시행일자 : 2021년 10월 04일

  11. 권익침해 구제방법
  정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.
  1. 개인정보분쟁조정위원회 : (국번없이) 118(내선2번)
  2. 정보보호마크인증위원회 : 02-580-0533~4 (http://eprivacy.or.kr)
  3. 대검찰청 첨단범죄수사과 : 02-3480-2000 (http://www.spo.go.kr/)
  4. 경찰청 사이버테러대응센터 : 1566-0112 (http://www.netan.go.kr/)
    ''',
    '''
    5. 개인정보의 취급위탁
회사는 원칙적으로 이용자의 동의 없이 개인정보의 처리를 외부업체에게 위탁하지 않습니다. 회사는 아래와 같이 개인정보의 처리를 위탁하고 있으며, 관련 법령에 따라 위탁계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다.

① (주)ITNJ(업무제휴사)
- 개인정보를 위탁받는 자 : (주)ITNJ
- 제공하는 개인정보 항목 : 카드결제 계좌정보, 신용도정보, 주문내역
- 제공받는 자의 개인정보 이용목적 : 주문내역의 결제, 카드유효성 검사
- 제공받는 자의 보유•이용기간 : 업무 제휴 계약에 따른 거래기간동안
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
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff00276b)),
              borderRadius: BorderRadius.all(Radius.circular(15.w))),
          child: Scrollbar(
            isAlwaysShown: true,
            controller: this._rootController,
            child: SingleChildScrollView(
              controller: this._rootController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      width: 270.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
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
                              children: [Container(
                                width: 250.w,
                              
                                  child: Text(agreedContents[0]),
                              )],
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
                              value: this.firstAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.firstAgreed = value!;
                                });
                              },
                            )),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          margin: EdgeInsets.only(left: 10.w),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text("개인 정보 처리 방침 동의 (필수)",
                                style: TextStyle(
                                    fontFamily: "NotoSans", fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      width: 270.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
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
                              children: [Container(
                                width: 250.w,
                                child: Text(agreedContents[1]))],
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
                              value: this.secondAgreed,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.secondAgreed = value!;
                                });
                              },
                            )),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          margin: EdgeInsets.only(left: 10.w),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text("개인 정보 처리 위탁 동의 (필수)",
                                style: TextStyle(
                                    fontFamily: "NotoSans", fontSize: 16)),
                          ),
                        ),
                      ],
                    )),
                  Container(
                    height: 25.h,
                    width: 280.w,
                    margin: EdgeInsets.only(left: 8.w, top: 15.h, bottom: 7.h),
                    child: Row(
                      children: [
                        Transform.scale(
                            scale: 1.4,
                            child: Checkbox(
                              value: this.firstAgreed &&
                                  this.secondAgreed ,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.firstAgreed = value!;
                                  this.secondAgreed = value;
              
                                });
                              },
                            )),
                        Container(
                          alignment: Alignment.center,
                          height: 20.h,
                          margin: EdgeInsets.only(left: 10.w),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text("모두 동의",
                                style: TextStyle(
                                    fontFamily: "NotoSans", fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (firstAgreed &&
                            secondAgreed) {
                          // this.setState(() {
                          //   this.emailColor = Colors.white;
                          // });
                          Get.to(() => SignUp());
                        } else {
                          setState(() {
                            this.emailColor = Colors.grey;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(milliseconds: 1500),
                              content: Text(" 위 약관에 대해 모두 동의해주세요.")));
                        }
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                            color: const Color(0xff00276b), width: 1.w)),
                        backgroundColor: MaterialStateProperty.all(
                            firstAgreed &&
                                    secondAgreed 
                                ? Colors.grey
                                : Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                      fontWeight: FontWeight.w400,
                                      color: Colors.orange,
                                      fontFamily: "NotoSans",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0))))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
