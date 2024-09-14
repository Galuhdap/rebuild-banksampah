import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/auth_respository.dart';

class DepositTrashController extends GetxController {
  final TrashRepository trashRepository = locator();
  final TextEditingController kode_nasabah = TextEditingController();
  final TextEditingController type_trash = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController price = TextEditingController();

  final TextEditingController searchDepositTrash = TextEditingController();

  RxList<GroupTrash> listTrash = <GroupTrash>[].obs;
  RxBool isloadingCommodity = false.obs;
  RxString selectedTrashId = ''.obs;
  RxInt priceTrash = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getTrash();
  }

  void setDropdownValue(String value) {
    selectedTrashId.value = value;
  }

  void setPriceTrashValue(String value) {
    var selectedTrash = listTrash.firstWhere(
      (trash) => trash.id == value,
    );

    priceTrash.value = selectedTrash.harga;
  }

  Future<void> getTrash() async {
    isloadingCommodity.value = true;
    try {
      final response = await trashRepository.getTrash();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listTrash.addAll(response.data);
          if (listTrash.isNotEmpty) {
            selectedTrashId.value = listTrash.first.id;
          }
        },
      );
      isloadingCommodity.value = false;
    } catch (e) {
      print('e:$e');
      isloadingCommodity.value = false;
    }
  }
}
