import 'dart:convert';

class OrderedMenu {
  String menuThumnail = "";
  List<String> options = [];
  String menuName = "";

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
    print("mmmmmmmmmmmmmmmmmmmmmmmmmmm");
    print(json["menuList"][0].runtimeType);
    print(json["menuList"].length);
    for (int i = 0; i < json["menuList"].length; i++) {
      print("for looop");
      Map<String, dynamic> menu =
          Map<String, dynamic>.from(json["menuList"][i]);
      List<String> options = [];
      print(menu["optionList"].runtimeType);
      for (var option in menu["optionList"]) {
        print("option");
        print(option);
        options.add(option["name"]);
      }

      print(options);
      print("op");
      print(menu["imagePath"]);

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
    print("llllllllllllll");
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<MyOrder>((json) => MyOrder.fromJson(json)).toList();
  }
}

class Order {
  String storeThumbnail;
  String storeName;
  String orderDetail;
  String menuThumbnail;

  Order(
      [this.storeThumbnail = "images/store/위치icon.svg",
      this.storeName = "킬티",
      this.orderDetail = "아메리카노 2잔",
      this.menuThumbnail = "images/store/위치icon.svg"]);
}
