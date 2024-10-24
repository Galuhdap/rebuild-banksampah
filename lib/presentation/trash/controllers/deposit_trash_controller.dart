import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_message_dialog.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/loading_trash_screen.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/post_deposit_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_customer_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/deposit_trash_respository.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/trash_respository.dart';

class DepositTrashController extends GetxController {
  final TrashRepository trashRepository = locator();
  final DepositTrashDataRespository depositTrashDataRespository = locator();
  final TextEditingController kode_nasabah = TextEditingController();
  final TextEditingController type_trash = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController price = TextEditingController();

  final TextEditingController searchDepositTrash = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  final TextEditingController dropdownTrashController = TextEditingController();

  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  RxList<GroupTrash> listTrash = <GroupTrash>[].obs;
  RxList<DepositTrash> listDepositTrash = <DepositTrash>[].obs;
  RxList<Customer> listCustomer = <Customer>[].obs;
  RxList<GroupTrash> selectedTrashList = <GroupTrash>[].obs;
  RxList<GroupTrash> selectedTrashListPut = <GroupTrash>[].obs;
  RxBool isloadingCommodity = false.obs;
  RxBool isloadingDepositTrash = false.obs;
  RxBool isloadingAddDepositTrash = false.obs;
  RxBool isloadingPutDepositTrash = false.obs;
  RxBool isloadingCustomerDepositTrash = false.obs;
  RxBool isloadingDeleteDepositTrash = false.obs;
  RxString selectedTrashId = ''.obs;
  RxDouble priceTrash = 0.0.obs;
  RxDouble totalPriceTrash = 0.0.obs;
  RxString searchQuery = "".obs;
  RxList<DepositTrash> searchDepositTrashs = <DepositTrash>[].obs;
  RxString selectedCustomerId = ''.obs;
  RxInt activeButtonIndex = 0.obs;
  RxList<GroupTrash> trashList = <GroupTrash>[].obs;


  List<Customer> getSuggestions(String query) {
    return listCustomer
        .where((customer) =>
            customer.username.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<GroupTrash> getTrashSuggestions(String query) {
    return listTrash
        .where(
            (trash) => trash.nama.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }


  @override
  void onInit() {
    super.onInit();
    getTrash();
    getDepositTrash();
    getCustomerDepositTrash();
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  void setDropdownValue(String value) {
    selectedTrashId.value = value;
  }

  void setPriceTrashValue(String value) {
    var selectedTrash = listTrash.firstWhere(
      (trash) => trash.id == value,
    );

    priceTrash.value = selectedTrash.harga.toDouble();
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

  Future<void> getDepositTrash() async {
    isloadingDepositTrash.value = true;
    try {
      final response = await depositTrashDataRespository.getDepositTrash();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
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

  Future<void> getCustomerDepositTrash() async {
    isloadingCustomerDepositTrash.value = true;
    try {
      final response =
          await depositTrashDataRespository.getCustomerDepositTrash();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listCustomer.addAll(response.data);
        },
      );
      isloadingCustomerDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingCustomerDepositTrash.value = false;
    }
  }

  void calculateTotal(double weight) {
    if (priceTrash.value != 0) {
      double price = priceTrash.value;
      totalPriceTrash.value =
          weight * price; // Hitung total berdasarkan berat dan harga
    } else {
      totalPriceTrash.value = 0; // Jika harga kosong, total juga kosong
    }
  }

  Future<void> postDepositTrash(BuildContext context) async {
    isloadingAddDepositTrash.value = true;
    try {
      List<ItemTrsah> itemTrashList = selectedTrashList.map((trash) {
        return ItemTrsah(
          trashId: trash.id,
          weight: trash.berat, // Menggunakan berat dari model GroupTrash
        );
      }).toList();

      final data = PostDepositTrashRequest(
        userId: selectedCustomerId.value.toString(),
        ItemTrsahs: itemTrashList,
      );

      final response = await depositTrashDataRespository.postDepositTrash(data);

      response.fold(
        (failure) {
          inspect(failure.code);
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
            message: 'Product added successfully',
            isError: false,
          );
          Get.to(LoadingTrashScreen());
          weight.text = '';
          totalPriceTrash.value = 0;
          dropdownSearchFieldController.clear();
          selectedCustomerId.value = '';
          dropdownTrashController.clear();
          selectedTrashId.value = '';
          listTrash.clear();
          listCustomer.clear();
          listDepositTrash.clear();
          await getCustomerDepositTrash();
          await getDepositTrash();
          await getTrash();

          update();
        },
      );

      isloadingAddDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingAddDepositTrash.value = false;
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

      final response =
          await depositTrashDataRespository.putDepositTrash(data, idSummary);

      response.fold(
        (failure) {
          inspect(failure.code);
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
            message: 'Product added successfully',
            isError: false,
          );
          weight.text = '';
          totalPriceTrash.value = 0;
          dropdownSearchFieldController.clear();
          selectedCustomerId.value = '';
          dropdownTrashController.clear();
          selectedTrashId.value = '';
          listTrash.clear();
          listCustomer.clear();
          listDepositTrash.clear();

          await getCustomerDepositTrash();
          await getDepositTrash();
          await getTrash();

          update();
        },
      );

      isloadingPutDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingPutDepositTrash.value = false;
    }
  }

  Future<void> deleteDepositTrash(String id, BuildContext context) async {
    isloadingDeleteDepositTrash.value = true;
    try {
      final response = await depositTrashDataRespository.deleteDepositTrash(id);

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
          // MessageComponent.snackbarTop(
          //   title: 'Success',
          //   message: 'Hapus Sampah Succes',
          //   isError: false,
          // );

          showDepositTrashSucces(
              context: context,
              icon: Assets.icons.succes.path,
              label: AppConstants.LABEL_DELETE_DEPOSIT_TRASH_SUCCES,
              firstButton: AppConstants.LABEL_SEE_HISTORY,
              fistOnPressed: () async {
                listDepositTrash.clear();
                await getDepositTrash();
                Get.back();
                Get.back();
              },
              // secondButton: AppConstants.LABEL_BERANDA,
              // seccondOnPressed: () async {
              //   listDepositTrash.clear();
              //   await getDepositTrash();
              //   Get.offAllNamed(AppRoutes.home);
              // },
              showButton: false);

          update();
        },
      );

      isloadingDeleteDepositTrash.value = false;
    } catch (e) {
      print('e:$e');
      isloadingDeleteDepositTrash.value = false;
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

  void addSelectedTrash(String trashId) {
    bool isTrashAlreadySelected =
        selectedTrashList.any((trash) => trash.id == trashId);

    if (!isTrashAlreadySelected) {
      var selectedTrash = listTrash.firstWhere((trash) => trash.id == trashId);
      selectedTrashList.add(
        GroupTrash(
          id: selectedTrash.id,
          nama: selectedTrash.nama,
          harga: selectedTrash.harga,
          berat: 0, // Default weight
        ),
      );
    } else {
      // Anda dapat menambahkan logika lain di sini, seperti memberi tahu pengguna bahwa sampah sudah dipilih
      print('Sampah dengan ID $trashId sudah dipilih.');
    }
  }

  // Menghapus sampah dari list yang dipilih
  void removeSelectedTrash(String trashId) {
    selectedTrashList.removeWhere((trash) => trash.id == trashId);
  }

  void updateTrashWeight(String trashId, String weight) {
    var trash = selectedTrashList.firstWhere((trash) => trash.id == trashId);
    trash.berat = int.tryParse(weight) ?? 1;
    selectedTrashList.refresh();
  }
}


// showDepositTrashSucces(
//     context: context,
//     icon: Assets.icons.succes.path,
//     label: AppConstants.LABEL_DEPOSIT_TRASH_SUCCES,
//     firstButton: AppConstants.LABEL_SEE_HISTORY,
//     fistOnPressed: () async {

//       // Get.back();
//       // Get.back();
//     },
//     // secondButton: AppConstants.LABEL_BERANDA,
//     // seccondOnPressed: () async {
//     //   listDepositTrash.clear();
//     //   await getDepositTrash();
//     //   Get.offAllNamed(AppRoutes.home);
//     // },
//     showButton: false);
