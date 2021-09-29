import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isEditable = false.obs;
  
  changeEditable() {
    if (isEditable == false.obs) {
      isEditable = true.obs;
    } else {
      isEditable = false.obs;
    }
  }
}
