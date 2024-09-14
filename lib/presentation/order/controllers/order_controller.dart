import 'package:get/get.dart';

class OrderController extends GetxController {
  RxInt activeButtonIndex = 0.obs;

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }
}
