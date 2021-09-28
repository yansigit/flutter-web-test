import 'package:save_order/model/model.dart';

Shop _11thShopMockup = new Shop(id: 1, name: "11호관 커피", carouselImages: []);
List<Category> categories = [
  new Category(
    id: 1,
    name: "커피",
    menus: <Menu>[
      new Menu(
        id: 1,
        thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EC%95%84%EB%A9%94%EB%A6%AC%EC%B9%B4%EB%85%B8.png",
        name: "아메리카노",
        bgColor: 0xff815135,
        hotPrice: 2200,
        coldPrice: 2200,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
              id: 1,
              name: "커피 원두",
              thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%BB%A4%ED%94%BC%EC%9B%90%EB%91%90.png"),
          new Ingredient(id: 2, name: "물", thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EB%AC%BC.png"),
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
      new Menu(
        id: 2,
        thumbnail:
            "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EC%B9%B4%EB%9D%BC%EB%A9%9C+%EB%A7%88%EB%81%BC%EC%95%84%EB%98%90.png",
        name: "카라멜 마끼아또",
        bgColor: 0xffc77c3f,
        hotPrice: 3000,
        coldPrice: 3000,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
            id: 1,
            name: "커피 원두",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%BB%A4%ED%94%BC%EC%9B%90%EB%91%90.png",
          ),
          new Ingredient(
            id: 2,
            name: "우유",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%9A%B0%EC%9C%A0.png",
          ),
          new Ingredient(
            id: 3,
            name: "카라멜\n소스",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%B9%B4%EB%9D%BC%EB%A9%9C+%EC%86%8C%EC%8A%A4.png",
          ),
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
      new Menu(
        id: 3,
        thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EC%B9%B4%ED%8E%98%EB%AA%A8%EC%B9%B4.png",
        name: "카페모카",
        bgColor: 0xff80563d,
        hotPrice: 3000,
        coldPrice: 3000,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
            id: 1,
            name: "커피 원두",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%BB%A4%ED%94%BC%EC%9B%90%EB%91%90.png",
          ),
          new Ingredient(
            id: 2,
            name: "우유",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%9A%B0%EC%9C%A0.png",
          ),
          new Ingredient(
            id: 3,
            name: "초코 소스",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%B4%88%EC%BD%94%EC%86%8C%EC%8A%A4.png",
          ),
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
  new Category(
    id: 2,
    name: "라떼",
    menus: <Menu>[
      new Menu(
        id: 1,
        thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EA%B7%B8%EB%A6%B0%ED%8B%B0%EB%9D%BC%EB%96%BC.png",
        name: "그린티라떼",
        bgColor: 0xff87b039,
        hotPrice: 3200,
        coldPrice: 3200,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
            id: 1,
            name: "녹차 가루",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EB%85%B9%EC%B0%A8+%EA%B0%80%EB%A3%A8.png",
          ),
          new Ingredient(
            id: 2,
            name: "우유",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%9A%B0%EC%9C%A0.png",
          ),
        ],
        options: <Option>[
          new Option(id: 1, name: "selectHotCold", price: 0, check: 0),
          //new Option(id: 3, name: "iceSize", price: 0, check: 0),
        ],
        priority: 0,
      ),
      new Menu(
        id: 2,
        thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EC%B9%B4%ED%8E%98%EB%AA%A8%EC%B9%B4.png",
        name: "밀크티라떼",
        bgColor: 0xffbe9565,
        hotPrice: 3200,
        coldPrice: 3200,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
            id: 1,
            name: "밀크티\n가루",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EB%B0%80%ED%81%AC%ED%8B%B0+%EA%B0%80%EB%A3%A8.png",
          ),
          new Ingredient(
            id: 2,
            name: "우유",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%9A%B0%EC%9C%A0.png",
          ),
        ],
        options: <Option>[
          new Option(id: 1, name: "selectHotCold", price: 0, check: 0),
          //new Option(id: 3, name: "iceSize", price: 0, check: 0),
        ],
        priority: 0,
      ),
      new Menu(
        id: 3,
        thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/menus/%EC%B9%B4%ED%8E%98%EB%AA%A8%EC%B9%B4.png",
        name: "초코라떼",
        bgColor: 0xff98642a,
        hotPrice: 3200,
        coldPrice: 3200,
        isHot: true,
        isCold: true,
        ingredients: <Ingredient>[
          new Ingredient(
            id: 1,
            name: "초코 가루",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%B4%88%EC%BD%94+%EA%B0%80%EB%A3%A8.png",
          ),
          new Ingredient(
            id: 2,
            name: "우유",
            thumbnail: "https://arumdream.s3.ap-northeast-2.amazonaws.com/uploads/1/ingredients/%EC%9A%B0%EC%9C%A0.png",
          ),
        ],
        options: <Option>[
          new Option(id: 1, name: "selectHotCold", price: 0, check: 0),
          //new Option(id: 3, name: "iceSize", price: 0, check: 0),
        ],
        priority: 0,
      ),
    ],
  ),
];
