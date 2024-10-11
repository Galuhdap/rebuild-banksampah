import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/price_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/trash_respository.dart';

class TrashController extends GetxController {
  final TrashRepository trashRepository = locator();

  RxList<GroupTrash> listTrash = <GroupTrash>[].obs;
  RxList<GroupTrash> searchListTrash = <GroupTrash>[].obs;

  RxString searchQuery = "".obs;
  RxBool isloadingTrash = false.obs;
  RxBool isloadingAddTrash = false.obs;
  RxBool isloadingDeletePriceTrash = false.obs;

  final TextEditingController searchTrash = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getTrash();
  }

  Future<void> getTrash() async {
    isloadingTrash.value = true;
    try {
      final response = await trashRepository.getTrashSuper();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listTrash.addAll(response.data);
        },
      );
      isloadingTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingTrash.value = false;
    }
  }

  Future<void> postDepositTrash(BuildContext context) async {
    isloadingAddTrash.value = true;
    try {
      double? numericValue = double.parse(weightController.text);
      final data = PriceTrashRequest(
        name: nameController.text,
        price: int.parse(priceController.text),
        weight: numericValue,
      );

      final response = await trashRepository.postTrashSuper(data);

      response.fold(
        (failure) {
          inspect(failure.code);
          Get.back();
          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Price Trash added successfully',
            isError: false,
          );
          showDepositTrashSucces(
              context: context,
              icon: Assets.icons.succes.path,
              label: 'Berhasil Disimpan',
              firstButton: AppConstants.LABEL_SEE_HISTORY,
              fistOnPressed: () async {
                listTrash.clear();
                await getTrash();
                Get.back();
                Get.back();
              },
              showButton: false);

          update();
        },
      );

      isloadingAddTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingAddTrash.value = false;
    }
  }

  Future<void> deletePriceTrash(String id, BuildContext context) async {
    isloadingDeletePriceTrash.value = true;
    try {
      final response = await trashRepository.deleteTrashSuper(id);

      response.fold(
        (failure) {
          inspect(failure.message);
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Hapus Sampah Succes',
            isError: false,
          );
          showDepositTrashSucces(
              context: context,
              icon: Assets.icons.succes.path,
              label: AppConstants.LABEL_DELETE_DEPOSIT_TRASH_SUCCES,
              firstButton: AppConstants.LABEL_BACK,
              fistOnPressed: () async {
                listTrash.clear();
                await getTrash();
                Get.back();
                Get.back();
              },
              // secondButton: AppConstants.LABEL_BERANDA,
              // seccondOnPressed: () async {
              //   listTrash.clear();
              //   await getTrash();
              //   Get.offAllNamed(AppRoutes.home);
              // },
              showButton: false);

          update();
        },
      );

      isloadingDeletePriceTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingDeletePriceTrash.value = false;
    }
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      searchListTrash.assignAll(listTrash);
    } else {
      searchListTrash.assignAll(
        listTrash.where((data) {
          return data.nama
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
