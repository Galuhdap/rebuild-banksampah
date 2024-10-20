import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/lib/sql_lite_db_services.dart';
import 'package:rebuild_bank_sampah/services/product/model/response/get_product.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_customer_data_repository.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingController extends GetxController {
  final ProductCustomerDataRepository source = locator();

  RxList<Product> listProduct = <Product>[].obs;
  List<Product> listProductBasket = [];
  RxBool isLoadingProduct = false.obs;

  // RxInt activeIndex = (-1).obs;
  RxList<int> activeIndices = <int>[].obs;
  RxMap<int, int> quantities = <int, int>{}.obs;
  RxInt quantity = 0.obs;
  RxInt total = 0.obs;
  RxBool favorite = false.obs;
  RxBool isCheckStock = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProductCustomer();
    allDataBasket();
  }

  Future insert({required String idfav, required int stock}) async {
    final Database database = await DatabaseService().database();
    final favorites =
        await database.rawQuery('SELECT * FROM fava WHERE id_fav = ?', [idfav]);
    if (favorites.isEmpty) {
      favorite.toggle();
      await database.insert('fava', {'id_fav': idfav, 'stock': stock});
      await allDataBasket();
    } else {
      Get.snackbar(
        "Already",
        "You Already Liked in Favorit",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
    update();
  }

  Future<void> allDataBasket() async {
    final Database database = await DatabaseService().database();
    final data = await database.query('fava');

    final response = await source.getProductCustomer();

    response.fold(
      (failure) {
        MessageComponent.snackbar(
            title: '${failure.code}', message: failure.message, isError: true);
      },
      (response) async {
        listProductBasket = response.data
            .where((item) => data
                .map((dataItem) => dataItem['id_fav'].toString())
                .contains(item.id
                    .toString())) // Akses 'id' sebagai properti dari Product
            .map((item) {
          // Cari data stock dari SQLite berdasarkan id_fav
          // final sqliteData = data.firstWhere(
          //   (dataItem) => dataItem['id_fav'].toString() == item.id.toString(),
          //   orElse: () => <String, Object?>{},
          // );

          // Dapatkan nilai stock dari SQLite
         // final stock = sqliteData.isNotEmpty ? sqliteData['stock'] : 0;

          // Buat Product dari data API dan tambahkan field stock
          return Product.fromJson({
            ...item.toJson(),
            'favorite': true,
            //'stock': stock, // Tambahkan data stock dari SQLite
          });
        }).toList();

        update();
      },
    );
  }

  Future<void> getProductCustomer() async {
    isLoadingProduct.value = true;
    try {
      final response = await source.getProductCustomer();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listProduct.addAll(response.data);
          
          update();
        },
      );
      isLoadingProduct.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingProduct.value = false;
    }
  }
  
 

  void changeStatus(int index) {
    if (activeIndices.contains(index)) {
      activeIndices.remove(index); // Hapus card dari pilihan
      quantities[index] = 0; // Set quantity menjadi 0 saat dihapus
    } else {
      activeIndices.add(index); // Tambahkan card ke pilihan
      quantities[index] =
          (quantities[index] ?? 0) + 1; // Tambah quantity saat dipilih
    }
  }

  void changeQuantityAdd(int index) {
    if (activeIndices.contains(index)) {
      quantities[index] = (quantities[index] ?? 0) + 1;
    }
  }

  void changeQuantityMin(int index) {
    if (activeIndices.contains(index) && (quantities[index] ?? 0) > 0) {
      quantities[index] = quantities[index]! - 1;
    }
  }

 

  Future deleteKeranjang({required String idfav, required int index}) async {
    final product = listProductBasket[index];
    final Database database = await DatabaseService().database();
    final favorites =
        await database.rawQuery('SELECT * FROM fava WHERE id_fav = ?', [idfav]);
    if (favorites.isEmpty) {
      favorite.toggle();
      await database.delete(
        'fava',
        where: 'id = ?',
        whereArgs: [product.id],
      );
      await allDataBasket();
    } else {
      Get.snackbar(
        "Already",
        "You Already Liked in Favorit",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
    update();
  }

}
