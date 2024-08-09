import 'package:get/get.dart';

class WithdrawFundsController extends GetxController {
  RxBool isActive = true.obs;

  void setActive(bool value) {
    isActive.value = value;
  }
}