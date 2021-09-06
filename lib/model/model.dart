import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

bool isDevMode = true;
String devMode() {
  if (isDevMode) {
    return "api-dev";
  } else {
    return "api";
  }
}

class Shop {
  int id;
  String name;
  List<String> carouselImages;

  Shop({this.id = 0, this.name = "", this.carouselImages = const []});

  static Future<List<Shop>> fetchShops(http.Client client) async {
    final response = await client
        .get(Uri.parse("http://${devMode()}.dalbodre.me/api/Shop/"));
    final decodedData = utf8.decode(response.bodyBytes);
    final parsedShop = parseShop(decodedData);

    print(parsedShop);
    return parsedShop;
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
        id: json['id'] as int,
        name: json['name'] as String,
        carouselImages:
            json['carouselImages'] != null ? json['carouselImages'] : []);
  }

  static List<Shop> parseShop(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Shop>((json) => Shop.fromJson(json)).toList();
  }
}

class Category {
  final int id;
  final String name;
  final List<Menu> menus;

  Category({this.id = -1, this.name = "", this.menus = const []});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      // menus: json['menuList'] != null ? json['menuList'] : [],
      //menus: (Menu.getList(1, json['id'] as int)) as List<Menu>,
    );
  }
  static List<Category> parseCategory(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }

  static Future<List<Category>> fetchCategories(int shopId) async {
    var url = Uri.parse(
        'http://${devMode()}.dalbodre.me/api/Shop/${shopId}/Category');
    var response = await http.get(url);
    final decodedData = utf8.decode(response.bodyBytes);
    return parseCategory(decodedData);
  }
}

class Menu {
  int id;
  String name;
  String thumbnail;
  int bgColor;
  int price;
  bool isHot;
  bool isCold;
  List<Ingredient> ingredients;
  List<Option> options;
  String createdDateTime;
  String updatedDateTime;
  int priority;

  Menu(
      {this.id = 0,
      this.name = "",
      this.thumbnail = "",
      this.bgColor = 0xFFFFFFFF,
      this.price = 0,
      this.isHot = false,
      this.isCold = false,
      this.ingredients = const [],
      this.options = const [],
      this.createdDateTime = "",
      this.updatedDateTime = "",
      this.priority = 0});

  // factory Menu.fromJson(Map<String, dynamic> json) {
  //   return Menu(
  //     id: json['id'] as int,
  //     name: json['name'] as String,
  //     thumbnail: (json['imagePath'] as String).isEmpty
  //         ? ""
  //         : json['imagePath'] as String,
  //     bgColor: (json['backgroundColor'] as int).isNaN
  //         ? 0xffff0000
  //         : json['backgroundColor'] as int,
  //     price: json['price'] as int,
  //     isHot: json['isHot'] as bool,
  //     isCold: json['isCold'] as bool,
  //     ingredients: Ingredient.getList(1, 1, 1) as List<Ingredient>,
  //     options: Option.getList(1, 1, 1) as List<Option>,
  //     createdDateTime: json['createdDateTime'] as String,
  //     updatedDateTime: json['updatedDateTime'] as String,
  //     priority: json['priority'] as int,
  //   );
  // }
  // static List<Menu> parseMenu(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
  // }

  // static Future<List<Menu>> getList(int shopId, int categoryId) async {
  //   var url = Uri.parse(
  //       'http://${devMode()}.dalbodre.me/api/Shop/${shopId}/Category/${categoryId}/Menu');
  //   var response = await http.get(url);
  //   final decodedData = utf8.decode(response.bodyBytes);
  //   return parseMenu(decodedData);
  // }

  static Future<List<Menu>> getList(int shopId, int categoryId) async {
    var url = Uri.parse(
        "http://${devMode()}.dalbodre.me/api/Shop/$shopId/Category/$categoryId/Menu/");
    var response = await http.get(url);
    final decodedData = utf8.decode(response.bodyBytes);
    print(decodedData);
    final Map<String, dynamic> data = json.decode(decodedData);

    List<Menu> list = [];

    for (var menu in data.values.first) {
      final _menu = menu as Map;
      list.add(new Menu(
          id: _menu["id"] as int,
          name: _menu["name"] as String,
          thumbnail: _menu["image_path"] as String,
          bgColor: (_menu["bgColor"] as int).isNaN
              ? _menu["bgColor"] as int
              : 0XFFFF0000,
          price: _menu["price"] as int,
          isHot: _menu["isHot"] as bool,
          isCold: _menu["isCold"] as bool,
          ingredients:
              await Ingredient.getList(shopId, categoryId, _menu["id"]),
          options: await Option.getList(shopId, categoryId, _menu["id"]),
          priority: _menu["priority"] as int));
    }

    return list;
  }
}

class Ingredient {
  int id;
  String name;
  String thumbnail;

  Ingredient({this.id = -1, this.name = "", this.thumbnail = ""});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['imagePath'] as String,
      // menus: json['menuList'] != null ? json['menuList'] : [],
    );
  }
  static List<Ingredient> parseIngredient(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
  }

  static Future<List<Ingredient>> getList(
      int shopId, int categoryId, int menuId) async {
    var url = Uri.parse(
        'http://${devMode()}.dalbodre.me/api/Shop/${shopId}/Category/${categoryId}/Menu/${menuId}/Ingredient');
    var response = await http.get(url);
    final decodedData = utf8.decode(response.bodyBytes);
    return parseIngredient(decodedData);
  }
  // static Future<List<Ingredient>> getList(
  //     int shopId, int categoryId, int menuId) async {
  //   var url = Uri.parse(
  //       "http://${devMode()}.dalbodre.me/api/Shop/${shopId}/Category/${categoryId}/Menu/${menuId}/Ingredient");
  //   var response = await http.get(url);
  //   final decodedData = utf8.decode(response.bodyBytes);
  //   print(decodedData);
  //   final Map<String, dynamic> data = json.decode(decodedData);

  //   List<Ingredient> list = [];

  //   for (var ingredient in data.values.first) {
  //     final _ingredient = ingredient as Map;
  //     list.add(new Ingredient(
  //         _ingredient["id"] as int, _ingredient["name"] as String,
  //         thumbnail: _ingredient["image_path"] as String));
  //   }

  //   return list;
  // }
}

class Option {
  int id;
  String name;
  int price;
  int check;

  Option({
    this.id = -1,
    this.name = "",
    this.price = 0,
    this.check = 0,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      // menus: json['menuList'] != null ? json['menuList'] : [],
    );
  }
  static List<Option> parseOption(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Option>((json) => Option.fromJson(json)).toList();
  }

  static Future<List<Option>> getList(
      int shopId, int categoryId, int menuId) async {
    var url = Uri.parse(
        'http://${devMode()}.dalbodre.me/api/Shop/${shopId}/Category/${categoryId}/Menu/${menuId}/Option');
    var response = await http.get(url);
    final decodedData = utf8.decode(response.bodyBytes);
    return parseOption(decodedData);
  }
  // static Future<List<Option>> getList(
  //     int shopId, int categoryId, int menuId) async {
  //   var url = Uri.parse(
  //       "http://${devMode()}.dalbodre.me/api/Shop/$shopId/Category/$categoryId/Menu/$menuId/Option");
  //   var response = await http.get(url);
  //   final decodedData = utf8.decode(response.bodyBytes);
  //   print(decodedData);
  //   final Map<String, dynamic> data = json.decode(decodedData);

  //   List<Option> list = [];
  //   for (var option in data.values.first) {
  //     final _option = option as Map;
  //     list.add(new Option(
  //       _option["id"] as int,
  //       _option["name"] as String,
  //       _option["price"] as int,
  //     ));
  //   }

  //   return list;
  // }
}

class CartItem {
  String name;
  int price;
  String thumbnail;
  int bgColor;
  int quantity;
  Map<String, CartOption> cartOptions;

  CartItem(
      {this.name = "",
      this.price = 0,
      this.thumbnail = "",
      this.bgColor = 0xffffffff,
      this.quantity = 1,
      this.cartOptions = const {}});
}

class CartOption {
  String name;
  int price;
  int quantity;

  CartOption({this.name = "", this.price = 0, this.quantity = 0});

  Map<String, dynamic> toJson() {
    return ({'name': name, 'price': price, 'quantity': quantity});
  }
}
