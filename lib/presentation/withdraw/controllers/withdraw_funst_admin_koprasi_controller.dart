import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datarepository/withdraw_admin_koprasi_respository.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/withdraw_admin_koprasi_request.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class WithdrawFunstAdminKoprasiController extends GetxController {
  final WithdrawAdminKoprasiRespository repository = locator();

  TextEditingController nemeKoprasiController = TextEditingController();
  TextEditingController nemeController = TextEditingController();
  TextEditingController fundsController = TextEditingController();

  final TextEditingController searchWithdraw = TextEditingController();

  RxList<DataWithdrawAdminKoprasi> listWithdrawAdminKoprasi =
      <DataWithdrawAdminKoprasi>[].obs;
  RxList<DataWithdrawAdminKoprasi> searchListWithdrawAdminKoprasi =
      <DataWithdrawAdminKoprasi>[].obs;
  RxBool isLoadingGetWithdrawAdminKopraso = false.obs;
  RxBool isLoadingAddtWithdrawAdminKopraso = false.obs;

  RxInt activeButtonIndex = 0.obs;
  RxString searchQuery = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWithdarawAdminKoprasi();
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  Future<void> getWithdarawAdminKoprasi() async {
    isLoadingGetWithdrawAdminKopraso.value = true;
    try {
      final response = await repository.getWithdarawAdminKoprasi();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listWithdrawAdminKoprasi.addAll(response.data);
          update();
        },
      );
      isLoadingGetWithdrawAdminKopraso.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingGetWithdrawAdminKopraso.value = false;
    }
  }

  Future<void> postWithdrawAdminKoprasi(String name) async {
    isLoadingAddtWithdrawAdminKopraso.value = true;
    try {
      // double? numericValue = double.parse(weightController.text);
      String inputText = fundsController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final data = WithdrawAdminKoprasiRequest(
        nameAdmin: name,
        nameCoop: nemeController.text,
        nominal: int.parse(inputText),
      );

      final response = await repository.postWithdrawAdminKoprasi(data);

      response.fold(
        (failure) {
          inspect(failure.code);
          MessageComponent.snackbarTop(
            title: 'Gagal',
            message: 'Gagal Melakukan Pengajuan successfully',
            isError: false,
          );
          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Pengajuan successfully',
            isError: false,
          );
          listWithdrawAdminKoprasi.clear();
          await getWithdarawAdminKoprasi();

          update();
        },
      );

      isLoadingAddtWithdrawAdminKopraso.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingAddtWithdrawAdminKopraso.value = false;
    }
  }

  void filterSearch() {
    if (searchQuery.value.isEmpty) {
      List<DataWithdrawAdminKoprasi> filteredOrders =
          listWithdrawAdminKoprasi.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListWithdrawAdminKoprasi.assignAll(filteredOrders);
    } else {
      List<DataWithdrawAdminKoprasi> filteredOrders =
          listWithdrawAdminKoprasi.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListWithdrawAdminKoprasi.assignAll(
        filteredOrders.where((data) {
          return data.nameAdmin
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
