import 'package:get/get.dart';

class WithdrawFundsController extends GetxController {
  RxInt activeButtonIndex = 0.obs;

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }
}
