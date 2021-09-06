import 'package:flutter_dalbbodre/model/Order.dart';
import 'package:flutter_dalbbodre/model/Shop.dart';

class StoreAndCoupon {
  int couponNumber;
  Shop shop;
  StoreAndCoupon(int couponNumber, Shop shop) {
    this.couponNumber = couponNumber;
    this.shop = shop;
  }
}

class User {
  String name;
  String nickname;
  String phoneNumber;
  String gender;
  String birthday;
  String email;
  String thumbnail;
  int visitedStoreNumber = 0;
  List<StoreAndCoupon> couponsOfStores = <StoreAndCoupon>[];
  List<MyMenu> myMenus = <MyMenu>[];

  User(
      [this.name = "미입력",
      this.nickname = "미입력",
      this.phoneNumber = "미입력",
      this.birthday = "미입력",
      this.gender = "미입력",
      this.thumbnail = "images/store/위치icon.svg",
      this.email = "lyn312@google.com"]);
}
