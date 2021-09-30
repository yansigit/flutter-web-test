import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:save_order/model/model.dart';

class TakeOutController extends GetxController {
  final isTakeOut = false.obs;
  updateTakeOut(bool isTakeOut) {
    this.isTakeOut.value = isTakeOut;
  }
}

class SelectedCategoryController extends GetxController {
  final selected = RxInt(0);
  final selectedCategoryName = "".obs;

  updateSelected(int index) {
    selected.value = index;
  }

  updateSelectedCategoryName(String name) {
    this.selectedCategoryName.value = name;
  }
}

class OptionDialogController extends GetxController {
  final selectHotColdOption = RxInt(1);
  final selectSizeOption = 0.obs;
  final selectIceQuantity = 2.obs;

  updateHotColdOption(int num) {
    selectHotColdOption.value = num;
    print("상태 바뀜");
    print(selectHotColdOption.value.toString());
  }

  updateSizeOption(int num) {
    selectSizeOption.value = num;
  }

  updateIceQuantity(int num) {
    selectIceQuantity.value = num;
    print(num.toString());
  }

  reset() {
    selectHotColdOption.value = 1;
    selectIceQuantity.value = 2;
    selectSizeOption.value = 0;
  }
}

class ShoppingCartController extends GetxController {
  final shoppingCart = RxList<CartItem>([]);
  final totalPrice = 0.obs;
  final discountPrice = 0.obs;

  int updateTotalPrice(List<CartItem> shoppingCartList) {
    int prices = 0;
    for (CartItem cartItemPrice in shoppingCartList) {
      prices += cartItemPrice.price;
    }
    this.totalPrice.value = prices;
    return this.totalPrice.value;
  }

  discountPricePercent(int precent) {
    this.discountPrice.value = this.totalPrice.value * precent ~/ 100;
    this.totalPrice.value -= this.discountPrice.value;
  }

  discountPriceMoney(int price) {
    this.discountPrice.value = price;
    this.totalPrice.value -= this.discountPrice.value;
  }

  resetPrice() {
    this.totalPrice.value += this.discountPrice.value;
    this.discountPrice.value = 0;
  }

  removeCartItem(int idx) {
    shoppingCart.removeAt(idx);
  }

  decreaseMenuQuantity(int idx) {
    int price = shoppingCart[idx].price ~/ shoppingCart[idx].quantity;
    shoppingCart[idx].quantity -= 1;
    shoppingCart[idx].price = price * shoppingCart[idx].quantity;
  }

  increaseMenuQuantity(int idx) {
    int price = shoppingCart[idx].price ~/ shoppingCart[idx].quantity;
    shoppingCart[idx].quantity += 1;
    shoppingCart[idx].price = price * shoppingCart[idx].quantity;
  }

  update11stDiscount(int idx) {
    shoppingCart[idx].price = (shoppingCart[idx].price * 0.9).toInt();
  }

  reset11stDiscount(int idx) {
    shoppingCart[idx].price = (shoppingCart[idx].price * 10 ~/ 9).toInt();
  }
}

class AddShotController extends GetxController {
  final shotCount = 0.obs;
  final hasMinus = false.obs;
  final hasPlus = true.obs;

  updateCanChange() {
    if (shotCount <= 0) {
      this.hasMinus.value = false;
    } else {
      this.hasMinus.value = true;
    }

    if (shotCount >= 3) {
      this.hasPlus.value = false;
    } else {
      this.hasPlus.value = true;
    }
  }

  decreaseShotCount() {
    if (shotCount > 0) {
      this.shotCount.value -= 1;
    }
    updateCanChange();
  }

  increaseShotCount() {
    if (shotCount < 3) {
      this.shotCount.value += 1;
    }
    updateCanChange();
  }

  reset() {
    this.shotCount.value = 0;
    this.hasMinus.value = false;
    this.hasPlus.value = true;
  }
}

class QuantityController extends GetxController {
  final menuQuantity = 1.obs;
  final hasMinus = false.obs;

  updateMenuQuantityStatus() {
    if (menuQuantity.value <= 1) {
      this.hasMinus.value = false;
    } else {
      this.hasMinus.value = true;
    }
  }

  decreaseMenuQuantity() {
    if (this.menuQuantity.value > 1) {
      this.menuQuantity.value -= 1;
    }
    updateMenuQuantityStatus();
  }

  increaseMenuQuantity() {
    this.menuQuantity.value += 1;
    updateMenuQuantityStatus();
  }

  reset() {
    this.menuQuantity.value = 1;
    this.hasMinus.value = false;
  }
}

class ShopController extends GetxController {
  final shop = new Shop().obs;

  updateShop(Shop shop) {
    this.shop.value = shop;
  }
}

class CardController extends GetxController {
  final cardNum = "".obs;
  final cardValidation = "".obs;

  updateCardInfo(val) {
    cardNum.value = val;
  }

  updateCardValidation(val) {
    cardValidation.value = val;
  }
}

final oCcy = new NumberFormat("#,###", "ko_KR");

String calcStringToWon(int price) {
  return "${oCcy.format(price)}원";
}

class SyrupController extends GetxController {
  final syrupCount = 0.obs;
  final hasMinus = false.obs;
  final hasPlus = true.obs;

  increaseSyrupCount() {
    this.syrupCount.value += 1;
    updateSyrupCountState();
  }

  decreaseSyrupCount() {
    this.syrupCount.value -= 1;
    updateSyrupCountState();
  }

  updateSyrupCountState() {
    if (syrupCount.value < 1) {
      this.hasMinus.value = false;
    } else {
      this.hasMinus.value = true;
    }

    if (syrupCount.value > 4) {
      this.hasPlus.value = false;
    } else {
      this.hasPlus.value = true;
    }
  }

  reset() {
    this.syrupCount.value = 0;
    this.hasMinus.value = false;
    this.hasPlus.value = true;
  }
}

class WhippingController extends GetxController {
  final whippingState = false.obs;

  switchingWhipState() {
    if (whippingState.value == false) {
      this.whippingState.value = true;
    } else {
      this.whippingState.value = false;
    }
  }

  reset() {
    this.whippingState.value = false;
  }
}

class PriceController extends GetxController {
  final price = 0.obs;
  final shotPrice = 0.obs;
  final syrupPrice = 0.obs;
  final whippingPrice = 0.obs;
  final optionPrice = 0.obs;
  final finalPrice = 0.obs;

  OptionDialogController tempController = Get.find();
  AddShotController addShotController = Get.find();
  SyrupController syrupController = Get.find();
  WhippingController whippingController = Get.find();

  updateTempPrice(int price) {
    this.price.value = price;
  }

  updateShotPrice() {
    this.shotPrice.value = addShotController.shotCount.value * 500;
  }

  updateSyrupPrice() {
    this.syrupPrice.value = syrupController.syrupCount.value * 500;
  }

  updateWhippingPrice() {
    this.whippingPrice.value =
        whippingController.whippingState.value == true ? 500 : 0;
  }

  migratePrice() {
    this.optionPrice.value =
        this.shotPrice.value + this.syrupPrice.value + this.whippingPrice.value;
  }

  // increaseShotPrice() {
  //   this.optionPrice.value += 500;
  //   print(this.price.value.toString());
  // }

  // decreaseShotPrice() {
  //   this.optionPrice.value -= 500;
  // }

  // increaseSyrupPrice() {
  //   this.optionPrice.value += 500;
  // }

  // decreaseSyrupPrice() {
  //   this.optionPrice.value -= 500;
  // }

  // increaseWhippingPrice() {
  //   this.optionPrice.value += 500;
  // }

  // decreaseWhippingPrice() {
  //   this.optionPrice.value -= 500;
  // }
  reset() {
    price.value = 0;
    shotPrice.value = 0;
    syrupPrice.value = 0;
    whippingPrice.value = 0;
    optionPrice.value = 0;
    finalPrice.value = 0;
  }

  updatePrice(Map<String, CartOption> cartOptions, Menu menu) {
    //temp
    print("isCalled");

    //addShot
    // if (cartOptions["addShot"]!.quantity > 0) {
    //   this.optionPrice.value = cartOptions["addShot"]!.quantity * cartOptions["addShot"]!.price;
    // }

    // //syrup
    // if (cartOptions["syrup"]!.quantity > 0) {
    //   this.optionPrice.value = cartOptions["syrup"]!.quantity * cartOptions["syrup"]!.price;
    // }

    // if (cartOptions["whipping"]!.quantity > 0) {
    //   this.optionPrice.value = cartOptions["whipping"]!.quantity * cartOptions["whipping"]!.price;
    // }
    migratePrice();
    this.finalPrice.value = this.price.value + this.optionPrice.value;
    QuantityController _c = Get.find();
    this.finalPrice.value *= _c.menuQuantity.value;
  }
}

class UserController extends GetxController {
  final userId = "".obs;
  final userToken = "".obs;


  updateUserInfo(String userId, String userToken) {
    this.userId.value = userId;
    this.userToken.value = userToken;
  }


  
}

class CouponController extends GetxController {
  final userToken = "".obs;
  final couponNo = "".obs;
  final couponType = "".obs;

  updateCoupon(couponNo, couponType) {
    this.couponNo.value = couponNo;
    this.couponType.value = couponType;
  }
}
