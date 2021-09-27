import 'package:save_order/model/model.dart';

Shop _11thShopMockup = new Shop(id: 1, name: "11호관 커피", carouselImages: []);
List<Category> categories = [
  new Category(
    id: 1,
    name: "커피",
    menus: <Menu>[
      new Menu(
        id: 1,
        thumbnail: "",
        name: "아메리카노",
        bgColor: 0xff8155135,
        hotPrice: 2200,
        coldPrice: 0,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(id: 1, name: "커피 원두", thumbnail: ""),
          new Ingredient(id: 2, name: "물", thumbnail: ""),
        ],
        options: <Option>[
          new Option(id: 1, name: "selectHotCold", price: 0, check: 0),
          new Option(id: 2, name: "addShot", price: 500, check: 0),
          //new Option(id: 3, name: "iceSize", price: 0, check: 0),
          new Option(id: 4, name: "syrup", price: 500, check: 0),
          new Option(id: 6, name: "whipping", price: 500, check: 0),
        ],
        priority: 0,
      ),
    ],
  ),
];
