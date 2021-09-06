import 'package:get/get.dart';

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
  final selectAddShot = 0.obs;
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

  updateAddShot(int num) {
    selectAddShot.value = num;
  }

  updateSyrup(int num) {
    selectSyrup.value = num;
  }

  updateWhip(int num) {
    selectWhip.value = num;
  }
}
