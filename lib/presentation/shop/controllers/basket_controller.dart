import 'package:get/get.dart';

class BasketController extends GetxController {
  RxBool isActiveCheck = false.obs;
  RxInt activeIndex = (-1).obs;

  void toggleActiveCheck() {
    isActiveCheck.value = !isActiveCheck.value;
  }

  void changeStatus(int index) {
    activeIndex.value = index;
  }

  // Ubah activeIndex menjadi List<int> untuk menyimpan lebih dari satu index yang dipilih
  var activeIndices = <int>[].obs;

  // Ubah metode ini agar bisa menambahkan atau menghapus index dari daftar

  void changeStatuss(int index) {
    if (activeIndices.contains(index)) {
      activeIndices.remove(index); // Uncheck jika sudah ada
    } else {
      activeIndices.add(index); // Tambahkan ke list jika belum ada
    }
    update();
  }
}
