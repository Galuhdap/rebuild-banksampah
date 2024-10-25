import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/super_admin/loading_edit_deposit_super_admin_screen.dart';
import 'package:rebuild_bank_sampah/services/home/datarepository/home_repository.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/customer_trash_repository.dart';

class DepositTrashSuperAdminController extends GetxController {
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
  RxBool isloadingPutDepositTrash = false.obs;

  final TextEditingController searchDepositTrash = TextEditingController();
  final List<TextEditingController> controllers = [];

  //var weights = <double>[].obs; // RxList untuk menyimpan berat

  @override
  void onInit() {
    super.onInit();
    getDepositTrash();
  }

  void initializeControllers(List<Deposit> deposits) {
    if (controllers.isEmpty) {
      for (var trash in deposits) {
        controllers.add(TextEditingController(text: trash.weight.toString()));
      }
    }
  }

  // void initializeWeights(List<Deposit> deposits) {
  //   if (weights.isEmpty) {
  //     weights.assignAll(deposits.map((e) => e.weight.toDouble()));
  //   }
  // }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  Future<void> getDepositTrash() async {
    isloadingDepositTrash.value = true;
    try {
      final response = await trashRepository.getSuperAdminDeposit();

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

  Future<void> putDepositTrash(BuildContext context, String idSummary,
      String id, List<ItemTrsah> datas) async {
    isloadingPutDepositTrash.value = true;
    try {
      final data = PostDepositTrashRequest(
        userId: id,
        ItemTrsahs: datas,
      );

      // print(data);

      final response = await trashRepository.putDepositTrash(data, idSummary);

      response.fold(
        (failure) {
          inspect(failure.code);
          MessageComponent.snackbar(
            title: '${failure.code}',
            message: failure.message,
            isError: true,
          );

          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Product added successfully',
            isError: false,
          );
          Get.to(LoadingUpdateSuperAdminTrashScreen());
          listDepositTrash.clear();
          searchDepositTrashs.clear();
          await getDepositTrash();

          update();
        },
      );

      isloadingPutDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingPutDepositTrash.value = false;
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
