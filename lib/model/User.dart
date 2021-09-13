import 'package:save_order/model/model.dart';

import 'Order.dart';

class StoreAndCoupon {
  int couponNumber;
  Shop shop;
  StoreAndCoupon(this.couponNumber, this.shop);
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
  List<MyOrder> myMenus = <MyOrder>[];

  User(
      [this.name = "미입력",
      this.nickname = "미입력",
      this.phoneNumber = "미입력",
      this.birthday = "미입력",
      this.gender = "미입력",
      this.thumbnail = "images/store/위치icon.svg",
      this.email = "lyn312@google.com"]);
}
