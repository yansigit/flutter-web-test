import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_order/model/model.dart';
import 'package:save_order/util/sqlite_local_database/UserMenuDatabase.dart';
import 'package:save_order/view/pages/Controller/ProfileController.dart';
import '/consts/color.dart';
import '/model/Order.dart';
import '/model/ProfilePair.dart';
import '/model/User.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPageState extends State<UserPage> {
  List<String> isSelected = ["0", "0", "0", "0"];
  int menuNumber = 3;
  var dbHelper = UserMenuDatabase.instance;
  String userAccessToken = "";
  List<SavedMenu> savedMenus = [];
  var isInserted = false;
  List<StoreAndCoupon> couponsOfStores = [];
  User user = new User(
    "서윤",
    "리나",
    "010-3028-3745",
    "1999년3월12일",
  );
  static final storage = new FlutterSecureStorage();
  List<ProfilePair> profilePairs = List.empty();

  Future<List<SavedMenu>> loadUserMenus() async {
    // mock 코드
    SavedMenu savedMenu =
        new SavedMenu("", "컬티", "물 한잔/ 1샷추가/ 물 적게 넣어주세요", "아메리카노");

    savedMenu.thumbnail =
        "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/2/menus/" +
            savedMenu.menuName +
            ".png";

    Map<String, dynamic> mapMenu = savedMenu.toMap();
    print("map");
    print(mapMenu);
    // no problem
    mapMenu[UserMenuDatabase.userAccessToken] = this.userAccessToken;

    //await dbHelper.insert(mapMenu);

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

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    String? userInfo = await storage.read(key: "login");

    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      var token = userInfo.split(" ")[5];
      this.userAccessToken = token;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  UserPageState() {
    // StoreAndCoupon storeAndCoupon1 = new StoreAndCoupon(10, new Shop());
    // StoreAndCoupon storeAndCoupon2 = new StoreAndCoupon(5, new Shop());
    // user.couponsOfStores.add(storeAndCoupon1);
    // user.couponsOfStores.add(storeAndCoupon2);
    user.visitedStoreNumber = user.couponsOfStores.length;
    // StoreAndCoupon storeAndCoupon1 = new StoreAndCoupon(10, new MockShop());
    // StoreAndCoupon storeAndCoupon2 = new StoreAndCoupon(5, new MockShop());
    // couponsOfStores.add(storeAndCoupon1);
    // couponsOfStores.add(storeAndCoupon2);
    // print(user.visitedStoreNumber);
    print("lllllldafdfsa");
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

    print("bb");
    print(couponsOfStores.length);
    print("aa");
    return Container(
        height: 20.h,
        child: Text("내 정보를 볼 수 있는 기능이 아직 구현되지 않았습니다. ")
    );

    SingleChildScrollView(
        child: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight * 0.78,
            decoration: BoxDecoration(color: DARK_BLUE),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: 60.h, left: 20.w, bottom: 50.h, right: 15.w),
                    height: 62.h,
                    width: 62.w,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Image.network(
                            "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EB%B0%80%ED%81%AC%ED%8B%B0%EB%9D%BC%EB%96%BC.png")),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 60.h, left: 15.w, bottom: 10.h),
                        height: 35.h,
                        width: 124.w,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text('''$name 님,''',
                              maxLines: 2,
                              style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "NotoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.w, bottom: 50.h),
                        height: 35.h,
                        width: 124.w,
                        child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Text('''안녕하세요!''',
                                maxLines: 2,
                                style: TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "NotoSans",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 28.0))),
                      ),
                    ],
                  )
                ]),
                Row(
                  children: [
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
                                    builder:
                                        (context, AsyncSnapshot projectSnap) {
                                      if (projectSnap.hasData &&
                                          projectSnap.data != null &&
                                          projectSnap.data.length > 0) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return buildMenusView(context,
                                                  projectSnap.data[index]);
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            itemCount: projectSnap.data.length);
                                      } else if (projectSnap.hasError ||
                                          projectSnap.data == null ||
                                          projectSnap.data.length == 0) {
                                        return Column(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/emptyMenu.svg"),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15.h,
                                                  bottom: 15.h,
                                                  left: 105.w,
                                                  right: 105.w),
                                              height: 24.h,
                                              width: 164.w,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text("등록된 메뉴가 없습니다.",
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
                                              ),
                                            ),
                                            Container(
                                              width: 226.w,
                                              height: 19.h,
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text(
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
                                              ),
                                            ),
                                            Container(
                                              height: 19.h,
                                              width: 226.w,
                                              child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                      '''보다 간편하게 주문하실 수 있습니다.''',
                                                      style: const TextStyle(
                                                          color: const Color(
                                                              0xff999999),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              "NotoSans",
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14.0),
                                                      textAlign:
                                                          TextAlign.center)),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
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
                      child: Container(
                        margin: EdgeInsets.only(left: 20.w, right: 25.w),
                        height: 30.h,
                        width: 72.w,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
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
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          this.isSelected[2] = "1";
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (context) {
                                return this.couponsOfStores.length == 0
                                    ? Column(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.h),
                                            height: 60.h,
                                            width: 60.w,
                                            child: FittedBox(
                                              fit: BoxFit.fitHeight,
                                              child: SvgPicture.asset(
                                                  "assets/icons/Ic_EmptyCoupon.svg"),
                                            ),
                                          ),
                                          Container(
                                            height: 24.h,
                                            width: 146.w,
                                            child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Text("등록된 쿠폰이 없습니다.")),
                                          )
                                        ],
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return buildCouponView(
                                              context, couponsOfStores[index]);
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                        itemCount: couponsOfStores.length);
                              }).whenComplete(() => {
                                setState(() {
                                  this.isSelected[2] = "0";
                                })
                              });
                        });

                        // 쿠폰  모아두는 view
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 25.w, right: 25.w),
                        height: 30.h,
                        width: 72.w,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
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
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected[3] = "1";
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (context) {
                                final ProfileController profileController =
                                    Get.put(ProfileController());
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Column(
                                    children: [
                                      buildProfileView(context, "프로필 수정", () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Text(
                                                      "프로필 작성 기능은 아직 구현되지 않았습니다."));
                                              // return AlertDialog(
                                              //   content:
                                              //       SingleChildScrollView(
                                              //     child: Container(
                                              //       child: Column(
                                              //         //mainAxisSize: MainAxisSize.min,
                                              //         children: [
                                              //           Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .center,
                                              //             children: [
                                              //               Align(
                                              //                 child: SvgPicture
                                              //                     .asset(user
                                              //                         .thumbnail),
                                              //                 alignment:
                                              //                     Alignment
                                              //                         .topCenter,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //           Column(
                                              //             children: [
                                              //               // mainAxisAlignment:
                                              //               //     MainAxisAlignment.center,

                                              //               Align(
                                              //                 child: Text(
                                              //                     profilePairs[0]
                                              //                         .key,
                                              //                     style: const TextStyle(
                                              //                         color: const Color(
                                              //                             0xff222222),
                                              //                         fontWeight: FontWeight
                                              //                             .w700,
                                              //                         fontFamily:
                                              //                             "NotoSansCJKKR",
                                              //                         fontStyle: FontStyle
                                              //                             .normal,
                                              //                         fontSize:
                                              //                             18.0),
                                              //                     textAlign:
                                              //                         TextAlign
                                              //                             .left),
                                              //                 alignment:
                                              //                     Alignment
                                              //                         .topLeft,
                                              //               ),
                                              //               Align(
                                              //                   alignment:
                                              //                       Alignment
                                              //                           .topLeft,
                                              //                   child: Container(
                                              //                       width: 100
                                              //                           .w,
                                              //                       height: 100
                                              //                           .h,
                                              //                       child: TextField(
                                              //                           readOnly:
                                              //                               !profileController.isEditable.value,
                                              //                           decoration: InputDecoration(hintText: profilePairs[0].value),
                                              //                           style: const TextStyle(color: const Color(0xff666666), fontWeight: FontWeight.w400, fontFamily: "Roboto", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                           textAlign: TextAlign.left))),

                                              //               // mainAxisAlignment:
                                              //               //     MainAxisAlignment.center,

                                              //               Align(
                                              //                 child: Text(
                                              //                     profilePairs[1]
                                              //                         .key,
                                              //                     style: const TextStyle(
                                              //                         color: const Color(
                                              //                             0xff222222),
                                              //                         fontWeight: FontWeight
                                              //                             .w700,
                                              //                         fontFamily:
                                              //                             "NotoSansCJKKR",
                                              //                         fontStyle: FontStyle
                                              //                             .normal,
                                              //                         fontSize:
                                              //                             18.0),
                                              //                     textAlign:
                                              //                         TextAlign
                                              //                             .left),
                                              //                 alignment:
                                              //                     Alignment
                                              //                         .topLeft,
                                              //               ),
                                              //               Align(
                                              //                   alignment:
                                              //                       Alignment
                                              //                           .topLeft,
                                              //                   child: Container(
                                              //                       width: 100
                                              //                           .w,
                                              //                       height: 100
                                              //                           .h,
                                              //                       child: TextField(
                                              //                           readOnly:
                                              //                               !profileController.isEditable.value,
                                              //                           decoration: InputDecoration(hintText: profilePairs[1].value),
                                              //                           style: const TextStyle(color: const Color(0xff666666), fontWeight: FontWeight.w400, fontFamily: "Roboto", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                           textAlign: TextAlign.left))),
                                              //               Align(
                                              //                 child: Text(
                                              //                     profilePairs[2]
                                              //                         .key,
                                              //                     style: const TextStyle(
                                              //                         color: const Color(
                                              //                             0xff222222),
                                              //                         fontWeight: FontWeight
                                              //                             .w700,
                                              //                         fontFamily:
                                              //                             "NotoSansCJKKR",
                                              //                         fontStyle: FontStyle
                                              //                             .normal,
                                              //                         fontSize:
                                              //                             18.0),
                                              //                     textAlign:
                                              //                         TextAlign
                                              //                             .left),
                                              //                 alignment:
                                              //                     Alignment
                                              //                         .topLeft,
                                              //               ),
                                              //               Align(
                                              //                   alignment:
                                              //                       Alignment
                                              //                           .topLeft,
                                              //                   child: Container(
                                              //                       width: 100
                                              //                           .w,
                                              //                       height: 100
                                              //                           .h,
                                              //                       child: TextField(
                                              //                           readOnly:
                                              //                               !profileController.isEditable.value,
                                              //                           decoration: InputDecoration(hintText: profilePairs[2].value),
                                              //                           style: const TextStyle(color: const Color(0xff666666), fontWeight: FontWeight.w400, fontFamily: "Roboto", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                           textAlign: TextAlign.left))),
                                              //               Align(
                                              //                 child: Text(
                                              //                     profilePairs[3]
                                              //                         .key,
                                              //                     style: const TextStyle(
                                              //                         color: const Color(
                                              //                             0xff222222),
                                              //                         fontWeight: FontWeight
                                              //                             .w700,
                                              //                         fontFamily:
                                              //                             "NotoSansCJKKR",
                                              //                         fontStyle: FontStyle
                                              //                             .normal,
                                              //                         fontSize:
                                              //                             18.0),
                                              //                     textAlign:
                                              //                         TextAlign
                                              //                             .left),
                                              //                 alignment:
                                              //                     Alignment
                                              //                         .topLeft,
                                              //               ),
                                              //               Align(
                                              //                   alignment:
                                              //                       Alignment
                                              //                           .topLeft,
                                              //                   child: Container(
                                              //                       width: 100
                                              //                           .w,
                                              //                       height: 100
                                              //                           .h,
                                              //                       alignment:
                                              //                           Alignment
                                              //                               .topLeft,
                                              //                       child: TextField(
                                              //                           readOnly:
                                              //                               !profileController.isEditable.value,
                                              //                           decoration: InputDecoration(hintText: profilePairs[3].value),
                                              //                           style: const TextStyle(color: const Color(0xff666666), fontWeight: FontWeight.w400, fontFamily: "Roboto", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                           textAlign: TextAlign.left))),
                                              //               Container(
                                              //                 child: Row(
                                              //                     children: [
                                              //                       GestureDetector(
                                              //                         onTap:
                                              //                             () {
                                              //                        
                                              //                             profileController.changeEditable();
                                              //                          
                                              //                         },
                                              //                         child: Text(
                                              //                             "변경하기",
                                              //                             style: const TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontFamily: "NotoSans", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                             textAlign: TextAlign.center),
                                              //                       ),
                                              //                       GestureDetector(
                                              //                         onTap:
                                              //                             () {
                                              //                          
                                              //                             profileController.changeEditable();
                                              //                           
                                              //                         },
                                              //                         child: Text(
                                              //                             "수정완료",
                                              //                             style: const TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontFamily: "NotoSans", fontStyle: FontStyle.normal, fontSize: 20.0),
                                              //                             textAlign: TextAlign.center),
                                              //                       )
                                              //                     ]),
                                              //                 width: MediaQuery.of(
                                              //                             context)
                                              //                         .size
                                              //                         .width *
                                              //                     0.8,
                                              //                 height: MediaQuery.of(
                                              //                             context)
                                              //                         .size
                                              //                         .width *
                                              //                     0.1,
                                              //                 decoration: BoxDecoration(
                                              //                     borderRadius:
                                              //                         BorderRadius.all(Radius.circular(27
                                              //                             .h)),
                                              //                     color: const Color(
                                              //                         0xff00276b)),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // );
                                            });
                                      }, "assets/icons/profile.svg"),
                                      buildProfileView(context, "알림 설정", () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Text(
                                                      "알림 설정 기능은 아직 구현되지 않았습니다."));
                                            });
                                        /*알림 설정하는 함수*/
                                      }, "assets/icons/bell.svg"),
                                      buildProfileView(context, "로그아웃", () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Text(
                                                      "로그아웃 기능은 아직 구현되지 않았습니다."));
                                            });
                                      },
                                          "assets/icons/logout.svg"),
                                      buildProfileView(context, "회원 탈퇴", () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  content: Text(
                                                      "회원 탈퇴 기능은 아직 구현되지 않았습니다."));
                                            });
                                        /* 회원 탈퇴하는 함수 */
                                      }, "assets/icons/withdrawal.svg")
                                    ],
                                  );
                                });
                              }).whenComplete(() => {
                                setState(() {
                                  this.isSelected[3] = "0";
                                })
                              });
                          // 설정 view
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 25.w, right: 25.w),
                        height: 30.h,
                        width: 72.w,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
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
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  Widget buildCouponView(BuildContext context, StoreAndCoupon storeAndCoupon) {
    int couponNum = storeAndCoupon.couponNumber;
    int MAX_SEEN_COUPON_NUM = 5;

    final childrenOfColumn = <Widget>[];
    childrenOfColumn.add(Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(left: 7.w, bottom: 8.h, right: 82.w, top: 18.h),
        height: 23.h,
        width: 170.w,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(storeAndCoupon.shop.name,
              style: const TextStyle(
                  color: const Color(0xff222222),
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSans",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.left),
        ),
      ),
    ));

    final childrenOfRowCoupon = <Widget>[];

    for (var i = 0; i < storeAndCoupon.couponNumber; i++) {
      if (i == MAX_SEEN_COUPON_NUM) {
        childrenOfRowCoupon.add(
          Container(
            margin:
                EdgeInsets.only(left: 6.w, bottom: 15.h, right: 3.w, top: 10.h),
            height: 25.h,
            width: 36.w,
            child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                    "+" +
                        (storeAndCoupon.couponNumber - MAX_SEEN_COUPON_NUM)
                            .toString(),
                    style: const TextStyle(
                        color: const Color(0xff00276b),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSans",
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0),
                    textAlign: TextAlign.left)),
          ),
        );
        break;
      }
      childrenOfRowCoupon.add(Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: SvgPicture.asset("assets/icons/stamp.svg")));
    }

    final Widget row = Row(children: childrenOfRowCoupon);
    childrenOfColumn.add(row);

    return Row(
      children: [
        SvgPicture.asset(storeAndCoupon.shop.thumbnail),
        Column(
          children: childrenOfColumn,
        )
      ],
    );
  }

  Widget buildProfileEditView(BuildContext context, ProfilePair profilePair) {
    return Container(
      height: 68,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.w, bottom: 7.h, top: 192.h),
            height: 27.h,
            width: 49.w,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(profilePair.key,
                  style: const TextStyle(
                      color: const Color(0xff222222),
                      fontWeight: FontWeight.w700,
                      fontFamily: "NotoSansCJKKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0),
                  textAlign: TextAlign.left),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 19.w, bottom: 10.h, top: 7.h),
            height: 24.h,
            width: 187.w,
            child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(profilePair.value,
                    style: const TextStyle(
                        color: const Color(0xff666666),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0),
                    textAlign: TextAlign.left)),
          ),
        ],
      ),
    );
  }

  Widget buildProfileView(BuildContext context, String viewName,
      VoidCallback callBack, String imagePath) {
    print(viewName);
    return Container(
        width: 375.w,
        height: 68.h,
        child: Row(
          children: [
            SvgPicture.asset(imagePath),
            Text(viewName,
                style: const TextStyle(
                    color: const Color(0xff222222),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSans",
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0),
                textAlign: TextAlign.left),
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
          Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Image.network(
                myMenu.thumbnail,
                fit: BoxFit.contain,
              )),
          Column(
            children: [
              Row(children: [
                Container(
                    width: 93.w,
                    height: 35.h,
                    child: Text(myMenu.menuName,
                        style: const TextStyle(
                            color: const Color(0xff222222),
                            fontWeight: FontWeight.w700,
                            fontFamily: "NotoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 22.0))),
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
                  SvgPicture.asset("assets/icons/위치icon.svg"),
                  Container(
                      margin: EdgeInsets.only(left: 2.w, top: 7.h),
                      width: 108.w,
                      height: 22.h,
                      child: Text(myMenu.storeName,
                          style: const TextStyle(
                              color: const Color(0xff00276b),
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left))
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 2.w, top: 2.h, bottom: 17.h),
                width: 187.w,
                height: 88.h,
                child: Text(
                  myMenu.options,
                  style: const TextStyle(
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSans",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                ),
              ),
              Row(
                children: [
                  // GestureDetector(
                  //     onTap: () {
                  //       // 메뉴  담는 버튼
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.only(right: 2.w, ),
                  //       width: 94.w,
                  //       height: 40.h,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(27)),
                  //           border: Border.all(
                  //               color: const Color(0xff00276b), width: 1)),
                  //       child: Text("담기",
                  //           style: const TextStyle(
                  //               color: const Color(0xff00276b),
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: "NotoSans",
                  //               fontStyle: FontStyle.normal,
                  //               fontSize: 16.0),
                  //           textAlign: TextAlign.center),
                  //     )),
                  GestureDetector(
                      onTap: () {
                        // 메뉴  주문 버튼
                      },
                      child: Container(
                        width: 129.99998474121094,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(27.h)),
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
  @override
  State<StatefulWidget> createState() {
    return UserPageState();
  }
}
