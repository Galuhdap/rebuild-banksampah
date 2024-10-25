import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/loading_order_screen.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_response.dart';
import 'package:rebuild_bank_sampah/services/order/repository/order_admin_data_repository.dart';

class OrderAdminKoprasiController extends GetxController {
  final OrderAdminDataRepository repository = locator();
  RxInt activeButtonIndex = 0.obs;
  RxList<OrderAdmin> listOrder = <OrderAdmin>[].obs;
  RxList<OrderAdmin> searchListOrder = <OrderAdmin>[].obs;
  RxBool isLoadingOrder = false.obs;
  RxBool isPostLoadingOrder = false.obs;

  final TextEditingController searchOrderSeeAdmin = TextEditingController();
  RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    getOrderSeeAdmin();
  }

  Future<void> getOrderSeeAdmin() async {
    isLoadingOrder.value = true;
    try {
      final response = await repository.getOrder();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listOrder.addAll(response.data);
          update();
        },
      );
      isLoadingOrder.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingOrder.value = false;
    }
  }

  Future<void> postUpdateStatusOrder(
      BuildContext context, PostUpdateStatusRequest datas) async {
    isPostLoadingOrder.value = true;
    try {
      final data = PostUpdateStatusRequest(
        transactionId: datas.transactionId,
        status: datas.status,
      );

      final response = await repository.postOrderStatusAdmin(data);

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
            message: 'Pesanan successfully',
            isError: false,
          );
          Get.to(LoadingOrderScreen(
            label: 'Pesanan Telah Disetujui',
          ));
          listOrder.clear();
          searchListOrder.clear();
          await getOrderSeeAdmin();
          update();
        },
      );

      isPostLoadingOrder.value = false;
    } catch (e) {
      print('e:$e');
      isPostLoadingOrder.value = false;
    }
  }

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  void filterSearchTrash() {
    if (searchQuery.value.isEmpty) {
      List<OrderAdmin> filteredOrders = listOrder.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListOrder.assignAll(filteredOrders);
    } else {
      List<OrderAdmin> filteredOrders = listOrder.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListOrder.assignAll(
        filteredOrders.where((data) {
          return data.orderCode
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
