import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/lib/sql_lite_db_services.dart';
import 'package:rebuild_bank_sampah/services/product/model/request/post_product_buy_request.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_customer_data_repository.dart';
import 'package:sqflite/sqflite.dart';

class CheckoutController extends GetxController {
  final ProductCustomerDataRepository source = locator();


  RxMap<int, int> quantities = <int, int>{}.obs;
  RxMap<String, String> productId = <String, String>{}.obs;
  RxInt total = 0.obs;
  RxBool isLoadingTransactions = false.obs;
  RxList<ListProductDatum> listProduct = <ListProductDatum>[].obs;
  RxList<String> productIds = <String>[].obs;
  RxInt userBalance = 0.obs; // Tambahkan saldo pengguna
  RxBool isBalanceSufficient =
      false.obs; // Flag untuk cek saldo cukup atau tidak

  @override
  void onInit() {
    super.onInit();
    // Menerima quantities dari BasketScreen melalui Get.arguments
    if (Get.arguments != null) {
      total.value = Get.arguments['total'];
      // productIds.value = Get.arguments['productIds'];
      quantities.value = Map<int, int>.from(Get.arguments['quantities']);
      final List<String>? argsProductIds = Get.arguments['productIds'];
      if (argsProductIds != null) {
        productIds.value =
            argsProductIds.toList(); // Tidak perlu melakukan konversi tambahan
      }
    }
    //getUserBalance();
  }



  Future<void> postBuyProduct(BuildContext context) async {
    isLoadingTransactions.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);

      List<String> stringProductIds =
          productIds.map((id) => id.toString()).toList();
      List<int> valuesArray = quantities.values.toList();

      List<ListProductDatum> listProductData = [];

      for (int i = 0; i < valuesArray.length; i++) {
        listProductData.add(
          ListProductDatum(
            productId: stringProductIds[i],
            quantity: valuesArray[i],
          ),
        );
      }

      final data = PostProductBuyRequest(
        userId: userData['id'],
        listProductData: listProductData,
      );

      // print(data);

      final response = await source.postBuyProductCustomer(data);

      response.fold(
        (failure) {
          MessageComponent.snackbar(
            title: '${failure.code}',
            message: failure.message,
            isError: true,
          );
          Get.back();
          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Transaction successfully',
            isError: false,
          );
          // showDepositTrashSucces(
          //   context: context,
          //   icon: Assets.icons.mark.path,
          //   label: AppConstants.LABEL_PROCESS_ORDER,
          //   firstButton: AppConstants.LABEL_SEE_ORDER,
          //   fistOnPressed: () {
          //     Get.offAndToNamed(AppRoutes.orderSee);
          //   },
          //   showButton: false,
          // );
          update();
        },
      );

      isLoadingTransactions.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingTransactions.value = false;
    }
  }

  Future<void> removeItem() async {
    final Database database = await DatabaseService().database();

    await database.delete(
      'fava',
    );

    update();
  }
}
