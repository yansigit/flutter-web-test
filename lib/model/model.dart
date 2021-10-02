import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:save_order/util/sqlite_local_database/UserFavoriteStoreDb.dart';

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
  double latitude;
  double longtitude;
  double distanceFromCurPosition;
  bool isOpened;

  Shop(
      {this.id = 0,
      this.name = "",
      this.carouselImages = const [],
      this.latitude = 0,
      this.longtitude = 0,
      this.distanceFromCurPosition = 0,
      this.isOpened = false});

  static Future<List<Shop>> fetchShops(http.Client client) async {
    final response = await client
        .get(Uri.parse("http://${devMode()}.dalbodre.me/api/Shop/"));
    final decodedData = utf8.decode(response.bodyBytes);

    final parsedShop = parseShop(decodedData);

    return parsedShop;
  }

  Map<String, dynamic> toMap() {
    return {
      UserFavoriteStoresDatabase.storeName: this.name,
      UserFavoriteStoresDatabase.thumbnailPath: this.carouselImages[0],
      UserFavoriteStoresDatabase.latitude: this.latitude,
      UserFavoriteStoresDatabase.longitutde: this.longtitude
    };
  }

  static Future<List<Shop>> fetchShopsByLocation(
      http.Client client, int N, Position curPosition) async {
    // ("latitude");
    // (latitude.toString());
    // ("longtitued");
    // (longtitude.toString());
    final response = await client.get(Uri.parse(
        "http://${devMode()}.dalbodre.me/api/Shop/NearBy/$N/${curPosition.latitude}/${curPosition.longitude}"));

    final decodedData = utf8.decode(response.bodyBytes);

    final parsedShop =
        await Shop.parseShopIncludeDistance(decodedData, curPosition);

    return parsedShop;
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
        id: json['id'] as int,
        name: json['name'] as String,
        carouselImages:
            json['carouselImages'] != null ? json['carouselImages'] : [],
        latitude: json['latitude'] as double,
        longtitude: json['longitude'] as double,
        isOpened: json['isOpened']);
  }

  static double calculateDistance(latitude, longitude, curPosition) {
 
    double d = Geolocator.distanceBetween(
        curPosition.latitude, curPosition.longitude, latitude, longitude);

    return d;
  }

  factory Shop.fromJsonIncludeDistance(
      Map<String, dynamic> json, Position curPosition) {
    double distance =
        calculateDistance(json['latitude'], json['longitude'], curPosition);
   
    return Shop(
        id: json['id'] as int,
        name: json['name'] as String,
        carouselImages:
            json['carouselImages'] != null ? json['carouselImages'] : [],
        latitude: json['latitude'] as double,
        longtitude: json['longitude'] as double,
        distanceFromCurPosition: distance,
        isOpened: json['isOpened']);
  }

  static List<Shop> parseShopIncludeDistance(
      String responseBody, Position curPosition) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    var elem = parsed
        .map<Shop>((json) => Shop.fromJsonIncludeDistance(json, curPosition));

    return elem.toList();

    // ("shopssss");
    // return await Future.wait(shops);
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
      menus: Menu.getList(json['menuList']),
      //menus: (Menu.getList(1, json['id'] as int)) as List<Menu>,
    );
  }
  static List<Category> parseCategory(String responseBody) {

    final parsed = json.decode(responseBody);
    final categories = parsed["categories"].cast<Map<String, dynamic>>();
    //final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return categories.map<Category>((json) => Category.fromJson(json)).toList();
  }

  static Future<List<Category>> fetchCategories(int shopId) async {
 
    var url = Uri.parse(
        'http://${devMode()}.dalbodre.me/api/Shop/${shopId}/getAllMenus');
    var response = await http.get(url);
    final decodedData = utf8.decode(response.bodyBytes);
    if (decodedData.isEmpty) {
      return [];
    }
    return parseCategory(decodedData);
  }
}

class Menu {
  int id;
  String name;
  String thumbnail;
  int bgColor;
  int hotPrice;
  int coldPrice;
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
      this.hotPrice = 0,
      this.coldPrice = 0,
      this.isHot = false,
      this.isCold = false,
      this.ingredients = const [],
      this.options = const [],
      this.createdDateTime = "",
      this.updatedDateTime = "",
      this.priority = 0});

  static List<Menu> getList(data) {
    List<Menu> list = [];

    for (var menu in data) {
      final _menu = menu as Map;
      list.add(new Menu(
          id: _menu["id"] as int,
          name: _menu["name"] as String,
          thumbnail: _menu["imagePath"] as String,
          bgColor: _menu["backgroundColor"] == null
              ? _menu["backgroundColor"] as int
              : 0XFFFF0000,
          hotPrice: _menu["hotPrice"] as int,
          coldPrice: _menu["coldPrice"] as int,
          isHot: _menu["hotPrice"] as int == 0 ? false : true,
          isCold: _menu["coldPrice"] as int == 0 ? false : true,
          ingredients: Ingredient.getList(_menu['ingredientList']),
          options: Option.getList(_menu['optionList']),
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

  static List<Ingredient> getList(data) {
    List<Ingredient> list = [];

    for (var ingredient in data) {
      final _ingredient = ingredient as Map;
      list.add(new Ingredient(
        id: _ingredient['id'] as int,
        name: _ingredient['name'] as String,
        thumbnail: _ingredient['imagePath'] as String,
      ));
    }

    return list;
  }
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
  static List<Option> getList(data) {
    List<Option> list = [];

    for (var option in data) {
      final _option = option as Map;
      list.add(new Option(
        id: _option['id'] as int,
        name: _option['name'] as String,
        price: _option['price'] as int,
      ));
    }

    return list;
  }
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

class Card {
  String cardBank;
  int cardNum;
  int cardCRC;
  int cardValidationDate;

  Card(
      {this.cardBank = "",
      required this.cardNum,
      required this.cardCRC,
      required this.cardValidationDate});
}
