import 'package:get/get.dart';

class ShoppingController extends GetxController {
  RxInt activeIndex = (-1).obs;
  RxInt quantity = 0.obs;
  RxInt total = 0.obs;

  void changeStatus(int index) {
    activeIndex.value = index;
    quantity.value = 0;
  }

  void changeQuantityAdd() {
   
    quantity.value++;
    total.value = 15000 * quantity.value;
  }


  void changeQuantityMin() {
    if (quantity.value > 0) {
      quantity.value--;
      total.value = 15000 * quantity.value;
    }
  }
}
