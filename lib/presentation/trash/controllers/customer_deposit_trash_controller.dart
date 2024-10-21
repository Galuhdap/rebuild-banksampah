import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/home/datarepository/home_repository.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/customer_trash_repository.dart';

class CustomerDepositTrashController extends GetxController {
  final CustomerTrashRepository trashRepository = locator();
  final HomeRepository repository = locator();

  RxList<DepositTrash> listDepositTrash = <DepositTrash>[].obs;
  RxList<DepositTrash> searchDepositTrashs = <DepositTrash>[].obs;

  RxBool isloadingDepositTrash = false.obs;
  RxBool isPostLoadingDeposit = false.obs;
  RxString searchQuery = "".obs;
  RxString id = ''.obs;
  RxBool isLoadingCustomer = false.obs;
  RxInt activeButtonIndex = 0.obs;

  final TextEditingController searchDepositTrash = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDepositTrash();
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
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

  Future<void> postUpdateStatusDeposit(
      BuildContext context, PostUpdateStatusRequest datas) async {
    isPostLoadingDeposit.value = true;
    try {
      final data = PostUpdateStatusRequest(
        transactionId: datas.transactionId,
        status: datas.status,
      );

      final response = await trashRepository.getDepositStatus(data);

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
            message: 'Pesanan successfully',
            isError: false,
          );
          listDepositTrash.clear();
          searchDepositTrashs.clear();
          await getDepositTrash();
          update();
        },
      );

      isPostLoadingDeposit.value = false;
    } catch (e) {
      print('e:$e');
      isPostLoadingDeposit.value = false;
    }
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      List<DepositTrash> filteredOrders = listDepositTrash.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchDepositTrashs.assignAll(filteredOrders);
    } else {
      List<DepositTrash> filteredOrders = listDepositTrash.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchDepositTrashs.assignAll(
        filteredOrders.where((data) {
          return data.user.profile.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
