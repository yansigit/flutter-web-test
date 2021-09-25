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
  }

  updateSizeOption(int num) {
    selectSizeOption.value = num;
  }

  updateIceQuantity(int num) {
    selectIceQuantity.value = num;
    print(num.toString());
  }

  @override
  void onClose() {
    super.onClose();
    selectHotColdOption.value = 1;
    selectIceQuantity.value = 2;
    selectSizeOption.value = 0;
  }
}

class ShoppingCartController extends GetxController {
  final shoppingCart = RxList<CartItem>([]);
  final totalPrice = 0.obs;

  updateTotalPrice(int price) {
    totalPrice.value += price;
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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

  @override
  void onClose() {
    super.onClose();
    this.menuQuantity.value = 1;
    this.hasMinus.value = false;
  }
}

class ShopController extends GetxController {
  final shopId = 0.obs;

  updateShopId(int id) {
    this.shopId.value = id;
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

  @override
  void onClose() {
    super.onClose();
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
}

class PriceController extends GetxController {
  final price = 0.obs;

  updateTempPrice(int price) {
    this.price.value = price;
  }

  increaseShotPrice() {
    this.price.value += 500;
  }

  decreaseShotPrice() {
    this.price.value -= 500;
  }

  increaseSyrupPrice() {
    this.price.value += 500;
  }

  decreaseSyrupPrice() {
    this.price.value -= 500;
  }

  increaseWhippingPrice() {
    this.price.value += 500;
  }

  decreaseWhippingPrice() {
    this.price.value -= 500;
  }

  updatePrice(Map<String, CartOption> cartOptions, Menu menu) {
    // //temp
    // print("isCalled");
    // print(cartOptions["temp"]!.name);
    // print(cartOptions["addShot"]!.quantity);
    // print(cartOptions["syrup"]!.quantity);
    // print(cartOptions["whipping"]!.quantity);

    // //addShot
    // if (cartOptions["addShot"]!.quantity > 0) {
    //   this.price.value += cartOptions["addShot"]!.quantity * cartOptions["addShot"]!.price;
    //   // AddShotController _c = Get.find();
    //   // this.price.value += _c.shotCount.value * cartOptions["addShot"]!.price;
    // }

    // //syrup
    // if (cartOptions["syrup"]!.quantity > 0) {
    //   this.price.value += cartOptions["syrup"]!.quantity * cartOptions["syrup"]!.price;
    // }

    // if (cartOptions["whipping"]!.quantity > 0) {
    //   this.price.value += cartOptions["whipping"]!.quantity * cartOptions["whipping"]!.price;
    // }

    QuantityController _c = Get.find();
    this.price.value *= _c.menuQuantity.value;
  }
}
