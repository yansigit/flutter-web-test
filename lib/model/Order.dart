import 'dart:convert';

import 'package:save_order/util/sqlite_local_database/UserMenuDatabase.dart';

class SavedMenu {
  String thumbnail = "";
  String storeName = "";
  String options = "";
  String menuName = "";

  SavedMenu(this.thumbnail, this.storeName, this.options, this.menuName);

  Map<String, dynamic> toMap() {
    return {
      UserMenuDatabase.storeName: this.storeName,
      UserMenuDatabase.menuThumbnailPath: this.thumbnail,
      UserMenuDatabase.options: this.options,
      UserMenuDatabase.menuName: this.menuName
    };
  }

  factory SavedMenu.fromMap(Map<String, dynamic> map) {
    return SavedMenu(
        map[UserMenuDatabase.menuThumbnailPath],
        map[UserMenuDatabase.storeName],
        map[UserMenuDatabase.options],
        map[UserMenuDatabase.menuName]);
  }
}

class OrderedMenu {
  String menuThumnail = "";
  List<String> options = [];
  String menuName = "";
  String storeName = "";

  OrderedMenu(this.menuThumnail, this.options, this.menuName);
}

class MyOrder {
  String storeThumbnail;
  String storeName;
  String firstMenuName;
  List<OrderedMenu> orders = [];
  int totalPrice = 0;
  int shopId;

  MyOrder(this.storeThumbnail, this.storeName, this.firstMenuName, this.orders,
      this.totalPrice, this.shopId);

  factory MyOrder.fromJson(Map<String, dynamic> json) {
    List<OrderedMenu> orders = [];

    for (int i = 0; i < json["menuList"].length; i++) {
      
      Map<String, dynamic> menu =
          Map<String, dynamic>.from(json["menuList"][i]);
      List<String> options = [];
     
      for (var option in menu["optionList"]) {
        options.add(option["name"]);
      }
      orders.add(new OrderedMenu(
          //menu["menuThumbnail"]
          menu["imagePath"],
          options,
          menu["name"]));
    }
    return MyOrder("", "", json["menuList"][0]["name"], orders,
        json["totalPrice"], json["shopId"]);
  }
  static List<MyOrder> parseMyMenu(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
 
    return parsed.map<MyOrder>((json) => MyOrder.fromJson(json)).toList();
  }
}

class Order {
  String storeThumbnail;
  String storeName;
  String orderDetail;
  String menuThumbnail;

  Order(
      [this.storeThumbnail = "assets/icons/위치icon.svg",
      this.storeName = "킬티",
      this.orderDetail = "아메리카노 2잔",
      this.menuThumbnail = "images/store/위치icon.svg"]);
}
