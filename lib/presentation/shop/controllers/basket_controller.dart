import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/home/controllers/home_controller.dart';
import 'package:rebuild_bank_sampah/presentation/shop/controllers/shopping_controller.dart';
import 'package:rebuild_bank_sampah/services/lib/sql_lite_db_services.dart';
import 'package:sqflite/sqflite.dart';

class BasketController extends GetxController {
  ShoppingController controller = Get.put(ShoppingController());
  final controllerHome = Get.put(HomeController());
  RxList<int> activeIndices = <int>[].obs;
  RxMap<int, int> quantities =
      <int, int>{}.obs; // Menyimpan kuantitas tiap produk
  RxInt total = 0.obs;
  RxBool isBalanceSufficient = false.obs;
  RxInt userBalance = 0.obs;
  // RxList<String> productIds = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi centang semua produk dan kuantitasnya 1
    activeIndices.value =
        List.generate(controller.listProductBasket.length, (index) => index);
    for (int i = 0; i < controller.listProductBasket.length; i++) {
      quantities[i] = 1; // Set default kuantitas produk
    }
    //updateProductIds();
    calculateTotal(); // Hitung total awal
    getUserBalance();
  }

  Future<void> getUserBalance() async {
    userBalance.value = controllerHome.balanceCustomer.value!.balance ?? 0;

    // Cek apakah saldo mencukupi
    checkBalance();
  }

  void checkBalance() {
    isBalanceSufficient.value = userBalance.value >= total.value;
  }

  List<String> get productIds {
    var productIds = activeIndices
        .map((index) => controller.listProductBasket[index].id.toString())
        .toList();
    print(productIds.runtimeType); // Untuk mengecek tipe data
    return productIds;
  }

  // Fungsi untuk menghitung total harga dari semua produk yang aktif
  void calculateTotal() {
    total.value = 0; // Reset total
    for (int index in activeIndices) {
      int productPrice =
          controller.listProductBasket[index].price; // Ambil harga produk
      int productQuantity =
          quantities[index] ?? 1; // Ambil kuantitas atau set default ke 1
      total.value += productPrice * productQuantity;
    }
  }

  // Fungsi untuk mengubah status centang pada item
  void changeStatus(int index) {
    if (activeIndices.contains(index)) {
      activeIndices.remove(index);
    } else {
      activeIndices.add(index);
    }
    calculateTotal(); // Hitung ulang total setelah perubahan status
    // updateProductIds();
    update();
  }

  // Fungsi untuk toggle select all
  void toggleSelectAll() {
    if (activeIndices.length == controller.listProductBasket.length) {
      activeIndices.clear();
    } else {
      activeIndices.value =
          List.generate(controller.listProductBasket.length, (index) => index);
    }
    calculateTotal(); // Hitung ulang total setelah toggle select all
    //updateProductIds();
    update();
  }

  bool isAllSelected() {
    return activeIndices.length == controller.listProductBasket.length;
  }

  // Fungsi untuk menambah kuantitas produk
  void changeQuantityAdd(int index) {
    var product = controller.listProductBasket[index];
    // Validasi apakah kuantitas saat ini sudah mencapai stok maksimal
    if (quantities[index] != null && quantities[index]! >= product.stock) {
      Get.snackbar('Stok tidak mencukupi',
          'Jumlah pembelian sudah mencapai batas stok.');
      return; // Jika sudah melebihi stok, tidak perlu dilanjutkan
    }
    if (quantities.containsKey(index)) {
      quantities[index] = (quantities[index]! + 1);
    } else {
      quantities[index] = 1;
    }
    calculateTotal(); // Hitung ulang total setelah kuantitas bertambah
    update();
  }

  // Fungsi untuk mengurangi kuantitas produk
  void changeQuantityMin(int index) {
    if (quantities.containsKey(index) && quantities[index]! > 1) {
      quantities[index] = (quantities[index]! - 1);
      calculateTotal(); // Hitung ulang total setelah kuantitas berkurang
      update();
    }
  }

  Future<void> removeItem(int index) async {
    final product = controller.listProductBasket[index];
    final Database database = await DatabaseService().database();

    await database.delete(
      'fava',
      where: 'id_fav = ?',
      whereArgs: [product.id],
    );

    controller.listProductBasket.removeAt(index);

    // Update activeIndices dan quantities setelah item dihapus
    activeIndices.remove(index); // Menghapus index dari activeIndices
    quantities.remove(index); // Menghapus kuantitas dari quantities

    // Setelah penghapusan, pastikan indeks yang lebih tinggi disesuaikan
    activeIndices.value =
        activeIndices.map((i) => i > index ? i - 1 : i).toList();

    // Hitung ulang total setelah menghapus item
    calculateTotal();

    // Update UI
    update();
  }
}
