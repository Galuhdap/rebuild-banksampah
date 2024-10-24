import 'dart:developer';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/home/datarepository/home_repository.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_admin_koprasi_balanse_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_customer_balance_response.dart';
import 'package:rebuild_bank_sampah/services/home/model/response/get_weigher_summary_response.dart';

class HomeController extends GetxController {
  final HomeRepository repository = locator();

  RxList<BalanceCustomer> listBalanceCustomer = <BalanceCustomer>[].obs;
  Rx<BalanceCustomer?> balanceCustomer = Rx<BalanceCustomer?>(null);
  Rx<SummaryWeigher?> summaryWeigher = Rx<SummaryWeigher?>(null);
  Rx<SummaryAdminKoprasi?> summaryAdminKoprasi = Rx<SummaryAdminKoprasi?>(null);
  RxString role = ''.obs;
  RxString name = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCustomer = false.obs;
  RxBool isLoadingAdminKoprasi = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserData();
    getBalanceCustomer();
    getSummaryWeigher();
    getSummaryAdminKoprasi();
  }

  void checkUserData() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferencesUtils.getAuthToken();
      var userData = JwtDecoder.decode(prefs!);
      role.value = userData['role'];
      name.value = userData['name'];
      isLoading.value = false;
    } catch (e) {
      print('e:$e');
      isLoading.value = false;
    }
  }

  Future<void> getBalanceCustomer() async {
    isLoadingCustomer.value = true;
    try {
      final response = await repository.getBalanceCustomer();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          balanceCustomer.value = response.data;
        },
      );
      isLoadingCustomer.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingCustomer.value = false;
    }
  }

  Future<void> getSummaryWeigher() async {
    isLoadingCustomer.value = true;
    try {
      final response = await repository.getSummaryWeigher();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          summaryWeigher.value = response.data;
        },
      );
      isLoadingCustomer.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingCustomer.value = false;
    }
  }

  Future<void> getSummaryAdminKoprasi() async {
    isLoadingAdminKoprasi.value = true;
    try {
      final response = await repository.getSummaryAdminKoprasi();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          summaryAdminKoprasi.value = response.data;
        },
      );
      isLoadingAdminKoprasi.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingAdminKoprasi.value = false;
    }
  }
}
