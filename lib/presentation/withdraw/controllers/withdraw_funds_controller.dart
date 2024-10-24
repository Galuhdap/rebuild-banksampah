import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/screen/loading_update_status_withdraw_screen.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datarepository/withdrawa_super_admin_repository.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/request/status_withdraw_super_admin.dart';
import 'package:rebuild_bank_sampah/services/withdraw/models/response/get_withdraw_admin_koprasi_response.dart';

class WithdrawFundsController extends GetxController {
  final WithdrawaSuperAdminRepository repository = locator();
  RxInt activeButtonIndex = 0.obs;
  RxBool isLoadingGetData = false.obs;

  final TextEditingController searchWithdraw = TextEditingController();

  RxList<DataWithdrawAdminKoprasi> listWithdrawSuperKoprasi =
      <DataWithdrawAdminKoprasi>[].obs;
  RxList<DataWithdrawAdminKoprasi> searchListWithdrawSuperKoprasi =
      <DataWithdrawAdminKoprasi>[].obs;
  RxString searchQuery = "".obs;
  RxBool isLoadingUpdateStatus = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWithdarawSuperadmini();
  }

  Future<void> getWithdarawSuperadmini() async {
    isLoadingGetData.value = true;
    try {
      final response = await repository.getWithdarawSuperadmin();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listWithdrawSuperKoprasi.addAll(response.data);
          update();
        },
      );
      isLoadingGetData.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingGetData.value = false;
    }
  }

  Future<void> postUpdateStatusWithdraw(
      BuildContext context, PostUpdateStatusWithdrawRequest datas) async {
    isLoadingUpdateStatus.value = true;
    try {
      final data = PostUpdateStatusWithdrawRequest(
        id: datas.id,
        status: datas.status,
      );

      final response = await repository.postWithdrawStatusAdmin(data);

      response.fold(
        (failure) {
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
            message: 'Pengajuan successfully',
            isError: false,
          );
          Get.to(LoadingUpdateStatusWithdrawScreen(
            label: 'Penagajuan Penarikan Dana Disetujui',
          ));
          listWithdrawSuperKoprasi.clear();
          searchListWithdrawSuperKoprasi.clear();

          await getWithdarawSuperadmini();
          update();
        },
      );

      isLoadingUpdateStatus.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingUpdateStatus.value = false;
    }
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

    void filterSearch() {
    if (searchQuery.value.isEmpty) {
      List<DataWithdrawAdminKoprasi> filteredOrders =
          listWithdrawSuperKoprasi.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListWithdrawSuperKoprasi.assignAll(filteredOrders);
    } else {
      List<DataWithdrawAdminKoprasi> filteredOrders =
          listWithdrawSuperKoprasi.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListWithdrawSuperKoprasi.assignAll(
        filteredOrders.where((data) {
          return data.nameCoop
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
