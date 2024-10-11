import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/home/datarepository/home_repository.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/customer/get_deposit_customer_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/customer_trash_repository.dart';

class CustomerDepositTrashController extends GetxController {
  final CustomerTrashRepository trashRepository = locator();
  final HomeRepository repository = locator();

  RxList<GetCustomerDeposit> listDepositTrash = <GetCustomerDeposit>[].obs;
  RxList<GetCustomerDeposit> searchDepositTrashs = <GetCustomerDeposit>[].obs;

  RxBool isloadingDepositTrash = false.obs;
  RxString searchQuery = "".obs;
  RxString id = ''.obs;
  RxBool isLoadingCustomer = false.obs;

  final TextEditingController searchDepositTrash = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDepositTrash();
  }

  Future<void> getDepositTrash() async {
    isloadingDepositTrash.value = true;
    try {
      final response = await trashRepository.getCustomerDeposit();

      response.fold(
        (failure) {
          inspect(failure.code);
        },
        (response) async {
          listDepositTrash.addAll(response.data);
        },
      );
      isloadingDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingDepositTrash.value = false;
    }
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      searchDepositTrashs.assignAll(listDepositTrash);
    } else {
      searchDepositTrashs.assignAll(
        listDepositTrash.where((data) {
          return data.sampah.nama
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }


}
