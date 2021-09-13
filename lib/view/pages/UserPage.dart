import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_order/util/sqlite_local_database/UserMenuDatabase.dart';
import '/consts/color.dart';
import '/model/Order.dart';
import '/model/ProfilePair.dart';
import '/model/Shop.dart';
import '/model/User.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPageState extends State<UserPage> {
  List<String> isSelected = ["0", "0", "0", "0"];
  int menuNumber = 3;
  String userAccessToken = "";
  List<SavedMenu> savedMenus = [];
  User user = new User(
    "서윤",
    "리나",
    "010-3028-3745",
    "1999년3월12일",
  );

  List<ProfilePair> profilePairs = List.empty();

  Future<List<SavedMenu>> loadUserMenus() async {
    final dbHelper = UserMenuDatabase.instance;
    // mock 코드
    SavedMenu savedMenu =
        new SavedMenu("이미지경로", "길티", "물 한잔/ 1샷추가/ 물 적게 넣어주세요", "아메리카노");
    Map<String, dynamic> mapMenu = savedMenu.toMap();
    print("map");
    print(mapMenu);
    // no problem
    mapMenu[UserMenuDatabase.userAccessToken] = this.userAccessToken;
    await dbHelper.insert(mapMenu);
    // mock 코드
    List<Map<String, dynamic>> userMenus =
        await dbHelper.queryRowByUserToken(this.userAccessToken, 3);
    print(userMenus);
    print(";;;;;");
    for (int i = 0; i < userMenus.length; i++) {
      SavedMenu savedMenu = SavedMenu.fromMap(userMenus[i]);
      this.savedMenus.add(savedMenu);
    }
    return this.savedMenus;
  }

  UserPageState(String accessToken) {
    this.userAccessToken = accessToken;
    // user.myMenus.add(new MyOrder());
    // StoreAndCoupon storeAndCoupon1 = new StoreAndCoupon(10, new Shop());
    // StoreAndCoupon storeAndCoupon2 = new StoreAndCoupon(5, new Shop());
    // user.couponsOfStores.add(storeAndCoupon1);
    // user.couponsOfStores.add(storeAndCoupon2);
    //user.visitedStoreNumber = user.couponsOfStores.length;
  }

  Widget build(BuildContext context) {
    profilePairs = <ProfilePair>[
      new ProfilePair("닉네임", user.nickname),
      new ProfilePair("휴대폰 번호", user.phoneNumber),
      new ProfilePair("이메일", user.email),
      new ProfilePair("생년월일", user.birthday),
      new ProfilePair("성별", user.gender)
    ];
    String name = user.name;
    bool editable = false;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
               width: ScreenUtil().screenWidth,
               height: ScreenUtil().screenHeight,
                decoration: BoxDecoration(color: DARK_BLUE),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      SvgPicture.asset(this.user.thumbnail),
                      SizedBox(height: 62.h, width: 3.w),
                      Column(
                        children: [
                          Text('''$name 님,''',
                              maxLines: 2,
                              style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0)),
                          Text('''안녕하세요!''',
                              maxLines: 2,
                              style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0))
                        ],
                      )
                    ]),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 335.w,
                          height: 75.h,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 27.w,
                          height: 20.h,
                        ),
                        new GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected[1] == "0") {
                                isSelected[1] = "1";
                              }
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) {
                                    return FutureBuilder(
                                        future: this.loadUserMenus(),
                                        builder: (context,
                                            AsyncSnapshot projectSnap) {
                                          if (projectSnap.hasData &&
                                              projectSnap.data != null &&
                                              projectSnap.data.length > 0) {
                                            return ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return buildMenusView(context,
                                                      projectSnap.data[index]);
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider();
                                                },
                                                itemCount:
                                                    projectSnap.data.length);
                                          } else if (projectSnap.hasError ||
                                              projectSnap.data == null ||
                                              projectSnap.data.length == 0) {
                                            return Column(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/icons/emptyMenu.svg"),
                                                SizedBox(height: 5),
                                                Text("등록된 메뉴가 없습니다.",
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xff999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "NotoSans",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18.0),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 5.h),
                                                Text(
                                                    '''자주 드시는 음료를 나의 메뉴로 등록하시면''',
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xff999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "NotoSans",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14.0),
                                                    textAlign:
                                                        TextAlign.center),
                                                Text('''보다 간편하게 주문하실 수 있습니다.''',
                                                    style: const TextStyle(
                                                        color: const Color(
                                                            0xff999999),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "NotoSans",
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.center)
                                              ],
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        });
                                  }).whenComplete(() => {
                                    setState(() {
                                      this.isSelected[1] = "0";
                                    })
                                  });
                            });
                            //  나의 메뉴 보여주는 view
                          },
                          child: Text(
                            "나의 메뉴",
                            style: TextStyle(
                                color: this.isSelected[1] == "1"
                                    ? const Color(0xffffffff)
                                    : const Color(0xff6288c9),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 27.w,
                          height: 20.h,
                        ),
                        new GestureDetector(
                          onTap: () {
                            setState(() {
                              this.isSelected[2] = "1";
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) {
                                    return this.user.visitedStoreNumber == 0
                                        ? Text("등록된 쿠폰이 없습니다.")
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return buildCouponView(
                                                  context,
                                                  this
                                                      .user
                                                      .couponsOfStores[index]);
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            itemCount:
                                                this.user.visitedStoreNumber);
                                  }).whenComplete(() => {
                                    setState(() {
                                      this.isSelected[2] = "0";
                                    })
                                  });
                            });

                            // 쿠폰  모아두는 view
                          },
                          child: Text(
                            "쿠폰",
                            style: TextStyle(
                                color: this.isSelected[2] == "1"
                                    ? const Color(0xffffffff)
                                    : const Color(0xff6288c9),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 27.w,
                          height: 20.h,
                        ),
                        new GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected[3] = "1";
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        buildProfileView(context, "프로필 수정", () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Container(
                                                      child: Column(
                                                        //mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Align(
                                                                child: SvgPicture
                                                                    .asset(user
                                                                        .thumbnail),
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              // mainAxisAlignment:
                                                              //     MainAxisAlignment.center,

                                                              Align(
                                                                child: Text(
                                                                    profilePairs[0]
                                                                        .key,
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xff222222),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontFamily:
                                                                            "NotoSansCJKKR",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            18.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      child: TextField(
                                                                          readOnly:
                                                                              !editable,
                                                                          decoration: InputDecoration(
                                                                              hintText: profilePairs[0]
                                                                                  .value),
                                                                          style: const TextStyle(
                                                                              color: const Color(0xff666666),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: "Roboto",
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 20.0),
                                                                          textAlign: TextAlign.left))),

                                                              // mainAxisAlignment:
                                                              //     MainAxisAlignment.center,

                                                              Align(
                                                                child: Text(
                                                                    profilePairs[1]
                                                                        .key,
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xff222222),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontFamily:
                                                                            "NotoSansCJKKR",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            18.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      child: TextField(
                                                                          readOnly:
                                                                              !editable,
                                                                          decoration: InputDecoration(
                                                                              hintText: profilePairs[1]
                                                                                  .value),
                                                                          style: const TextStyle(
                                                                              color: const Color(0xff666666),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: "Roboto",
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 20.0),
                                                                          textAlign: TextAlign.left))),
                                                              Align(
                                                                child: Text(
                                                                    profilePairs[2]
                                                                        .key,
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xff222222),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontFamily:
                                                                            "NotoSansCJKKR",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            18.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      child: TextField(
                                                                          // readOnly:
                                                                          //     !editable,
                                                                          decoration: InputDecoration(
                                                                              hintText: profilePairs[2]
                                                                                  .value),
                                                                          style: const TextStyle(
                                                                              color: const Color(0xff666666),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: "Roboto",
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 20.0),
                                                                          textAlign: TextAlign.left))),
                                                              Align(
                                                                child: Text(
                                                                    profilePairs[3]
                                                                        .key,
                                                                    style: const TextStyle(
                                                                        color: const Color(
                                                                            0xff222222),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontFamily:
                                                                            "NotoSansCJKKR",
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            18.0),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: TextField(
                                                                          readOnly:
                                                                              !editable,
                                                                          decoration: InputDecoration(
                                                                              hintText: profilePairs[3]
                                                                                  .value),
                                                                          style: const TextStyle(
                                                                              color: const Color(0xff666666),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontFamily: "Roboto",
                                                                              fontStyle: FontStyle.normal,
                                                                              fontSize: 20.0),
                                                                          textAlign: TextAlign.left))),
                                                              Container(
                                                                child: Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            editable =
                                                                                true;
                                                                            
                                                                            print(editable);
                                                                            print("edit");
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                            "변경하기",
                                                                            style: const TextStyle(
                                                                                color: const Color(0xffffffff),
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "NotoSans",
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 20.0),
                                                                            textAlign: TextAlign.center),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.03),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            editable =
                                                                                false;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                            "수정완료",
                                                                            style: const TextStyle(
                                                                                color: const Color(0xffffffff),
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "NotoSans",
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 20.0),
                                                                            textAlign: TextAlign.center),
                                                                      )
                                                                    ]),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.1,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            27.h)),
                                                                    color: const Color(
                                                                        0xff00276b)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }, "profile.svg"),
                                        buildProfileView(context, "알림 설정", () {
                                          /*알림 설정하는 함수*/
                                        }, "bell.svg"),
                                        buildProfileView(context, "로그아웃", () {
                                          /* 로그아웃 하는 함수*/
                                        }, "logout.svg"),
                                        buildProfileView(context, "회원 탈퇴", () {
                                          /* 회원 탈퇴하는 함수 */
                                        }, "withdrawal.svg")
                                      ],
                                    );
                                  }).whenComplete(() => {
                                    setState(() {
                                      this.isSelected[3] = "0";
                                    })
                                  });
                              // 설정 view
                            });
                          },
                          child: Text(
                            "설정",
                            style: TextStyle(
                                color: this.isSelected[3] == "1"
                                    ? const Color(0xffffffff)
                                    : const Color(0xff6288c9),
                                fontWeight: FontWeight.w400,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    )
                  ],
                ))));
  }

  Widget buildCouponView(BuildContext context, StoreAndCoupon storeAndCoupon) {
    int couponNum = storeAndCoupon.couponNumber;
    int MAX_SEEN_COUPON_NUM = 5;

    final childrenOfColumn = <Widget>[];
    childrenOfColumn.add(Align(
      alignment: Alignment.topLeft,
      child: Text(storeAndCoupon.shop.name,
          style: const TextStyle(
              color: const Color(0xff222222),
              fontWeight: FontWeight.w700,
              fontFamily: "NotoSans",
              fontStyle: FontStyle.normal,
              fontSize: 20.0),
          textAlign: TextAlign.left),
    ));
    childrenOfColumn.add(
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
    );

    final childrenOfRowCoupon = <Widget>[];

    for (var i = 0; i < storeAndCoupon.couponNumber; i++) {
      if (i == MAX_SEEN_COUPON_NUM) {
        childrenOfRowCoupon.add(Text(
            "+" +
                (storeAndCoupon.couponNumber - MAX_SEEN_COUPON_NUM).toString(),
            style: const TextStyle(
                color: const Color(0xff00276b),
                fontWeight: FontWeight.w700,
                fontFamily: "NotoSans",
                fontStyle: FontStyle.normal,
                fontSize: 22.0),
            textAlign: TextAlign.left));
        break;
      }
      childrenOfRowCoupon.add(SvgPicture.asset("assets/icons/stamp.svg"));
      childrenOfRowCoupon.add(SizedBox(
        width: MediaQuery.of(context).size.width * 0.03,
      ));
    }

    final Widget row = Row(children: childrenOfRowCoupon);
    childrenOfColumn.add(row);
    return Row(
      children: [
        SvgPicture.asset(storeAndCoupon.shop.carouselImages[0]),
        Column(
          children: childrenOfColumn,
        )
      ],
    );
  }

  Widget buildProfileEditView(BuildContext context, ProfilePair profilePair) {
    return SizedBox(
      height: 68,
      child: Column(
        children: [
          Text(profilePair.key,
              style: const TextStyle(
                  color: const Color(0xff222222),
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSansCJKKR",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0),
              textAlign: TextAlign.left),
          Text(profilePair.value,
              style: const TextStyle(
                  color: const Color(0xff666666),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.left)
        ],
      ),
    );
  }

  Widget buildProfileView(BuildContext context, String viewName,
      VoidCallback callBack, String imagePath) {
    return SizedBox(
        height: 68,
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/config/" + imagePath),
            SizedBox(width: 4.w),
            Text(viewName,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0),
                textAlign: TextAlign.left),
            SizedBox(width: 250.w),
            new GestureDetector(
                onTap: () {
                  setState(() {
                    // 프로필 보여주는 modal 구현
                    callBack();
                  });
                },
                child: SvgPicture.asset("assets/icons/arrowRight.svg")),
          ],
        ));
  }

  Widget buildMenusView(BuildContext context, SavedMenu myMenu) {
    return Container(
        child: Column(
      children: [
        Row(children: [
          SvgPicture.asset(myMenu.thumbnail),
          Column(
            children: [
              Row(children: [
                Text(myMenu.menuName,
                    style: const TextStyle(
                        color: const Color(0xff222222),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0)),
                SizedBox(
                  width: 35,
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        this.savedMenus.remove(myMenu);
                      });
                    },
                    child: SvgPicture.asset("assets/icons/deleteIcon.svg")),
              ]),
              Row(
                children: [
                  SvgPicture.asset("images/store/location.svg"),
                  SizedBox(width: 2),
                  Text(myMenu.storeName,
                      style: const TextStyle(
                          color: const Color(0xff00276b),
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left)
                ],
              ),
              Text(
                myMenu.options,
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // 메뉴  담는 버튼
                      },
                      child: Container(
                        width: 94.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(27)),
                            border: Border.all(
                                color: const Color(0xff00276b), width: 1)),
                        child: Text("담기",
                            style: const TextStyle(
                                color: const Color(0xff00276b),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.center),
                      )),
                  SizedBox(height: 40.h, width: 3.w),
                  GestureDetector(
                      onTap: () {
                        // 메뉴  주문 버튼
                      },
                      child: Container(
                        width: 129.99998474121094,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(27.h)),
                            color: const Color(0xff00276b)),
                        child: Text("바로 주문",
                            style: const TextStyle(
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "NotoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.center),
                      )),
                ],
              )
            ],
          )
        ])
      ],
    ));
  }
}

class UserPage extends StatefulWidget {
  String userAccessToken = "";

  UserPage(String token) {
    this.userAccessToken = token;
  }

  @override
  State<StatefulWidget> createState() {
    return UserPageState(this.userAccessToken);
  }
}
