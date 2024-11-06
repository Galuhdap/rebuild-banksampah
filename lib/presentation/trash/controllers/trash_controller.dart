import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/price_trash/loading_delete_price_trash.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/price_trash/loading_price_trash_screen.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/price_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/trash_respository.dart';

class TrashController extends GetxController {
  final TrashRepository trashRepository = locator();

  RxList<GroupTrash> listTrash = <GroupTrash>[].obs;
  RxList<GroupTrash> listTrashCustomer = <GroupTrash>[].obs;
  RxList<GroupTrash> searchListTrash = <GroupTrash>[].obs;

  RxString searchQuery = "".obs;
  RxBool isloadingTrash = false.obs;
  RxBool isloadingTrashCustomer = false.obs;
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
    getTrashCustomer();
  }

  Future<void> getTrash() async {
    isloadingTrash.value = true;
    try {
      final response = await trashRepository.getTrashSuper();

      response.fold(
        (failure) {
          inspect(failure.code);
          // MessageComponent.snackbar(
          //     title: '${failure.code}',
          //     message: failure.message,
          //     isError: true);
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

  Future<void> getTrashCustomer() async {
    isloadingTrashCustomer.value = true;
    try {
      final response = await trashRepository.getTrashCustomer();

      response.fold(
        (failure) {
          inspect(failure.code);
          // MessageComponent.snackbar(
          //     title: '${failure.code}',
          //     message: failure.message,
          //     isError: true);
        },
        (response) async {
          listTrashCustomer.addAll(response.data);
        },
      );
      isloadingTrashCustomer.value = false;
    } catch (e) {
      print('e:$e');
      isloadingTrash.value = false;
    }
  }

  Future<void> postDepositTrash(BuildContext context) async {
    isloadingAddTrash.value = true;
    try {
      // double? numericValue = double.parse(weightController.text);
      String inputText = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final data = PriceTrashRequest(
        name: nameController.text,
        price: int.parse(inputText),
        weight: 1,
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
          Get.to(LoadingPriceTrashScreen());
          listTrash.clear();
          await getTrash();

          update();
        },
      );

      isloadingAddTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingAddTrash.value = false;
    }
  }

  Future<void> editDepositTrash(
      {required BuildContext context,
      required PriceTrashRequest data,
      required String id}) async {
    isloadingAddTrash.value = true;
    try {
      final response = await trashRepository.editTrashSuper(data, id);

      response.fold(
        (failure) {
          inspect(failure.code);
          update();
        },
        (response) async {
          MessageComponent.snackbarTop(
            title: 'Success',
            message: 'Price Trash Edit successfully',
            isError: false,
          );
          Get.to(LoadingPriceTrashScreen());
          listTrash.clear();
          await getTrash();

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
          Get.to(LoadingDeletePriceTrashScreen());
          listTrash.clear();
          await getTrash();
          // showDepositTrashSucces(
          //     context: context,
          //     icon: Assets.icons.succes.path,
          //     label: AppConstants.LABEL_DELETE_DEPOSIT_TRASH_SUCCES,
          //     firstButton: AppConstants.LABEL_BACK,
          //     fistOnPressed: () async {
          //       listTrash.clear();
          //       await getTrash();
          //       Get.back();
          //       Get.back();
          //       //Get.toNamed(AppRoutes.priceTrash);
          //     },
          //     // secondButton: AppConstants.LABEL_BERANDA,
          //     // seccondOnPressed: () async {
          //     //   listTrash.clear();
          //     //   await getTrash();
          //     //   Get.offAllNamed(AppRoutes.home);
          //     // },
          //     showButton: false);

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
