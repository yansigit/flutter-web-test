import 'package:get/get.dart';
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
  final selectSyrup = 0.obs;
  final selectWhip = 0.obs;

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

  updateSyrup(int num) {
    selectSyrup.value = num;
  }

  updateWhip(int num) {
    selectWhip.value = num;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    selectHotColdOption.value = 1;
    selectIceQuantity.value = 2;
    selectSizeOption.value = 0;
    selectSyrup.value = 0;
    selectWhip.value = 0;
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
    // TODO: implement onClose
    super.onClose();
    this.menuQuantity.value = 1;
    this.hasMinus.value = false;
  }
}

class PriceController extends GetxController {
  final price = 0.obs;
}

class ShopController extends GetxController {
  final shopId = 0.obs;

  updateShopId(int id) {
    this.shopId.value = id;
  }
}
