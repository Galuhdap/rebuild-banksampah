import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/loading_order_customer_screen.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_customer_response.dart';
import 'package:rebuild_bank_sampah/services/order/repository/order_admin_data_repository.dart';

class OrderController extends GetxController {
  final OrderAdminDataRepository repository = locator();
  RxInt activeButtonIndex = 0.obs;
  RxList<OrderCustomer> listOrderCustomer = <OrderCustomer>[].obs;
  RxList<OrderCustomer> searchListOrderCustomer = <OrderCustomer>[].obs;
  RxBool isLoadingOrder = false.obs;
  RxBool isPostLoadingOrder = false.obs;
  RxBool isStatusLoadingOrder = false.obs;

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
      final response = await repository.getOrderCustomer();

      response.fold(
        (failure) {
          MessageComponent.snackbar(
              title: '${failure.code}',
              message: failure.message,
              isError: true);
        },
        (response) async {
          listOrderCustomer.addAll(response.data);
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

      final response = await repository.postOrderStatusCustomer(data);

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
          Get.to(LoadingOrderCustomerScreen(
            label: 'Pesanan Telah DiBatalkan',
          ));
          listOrderCustomer.clear();
          searchListOrderCustomer.clear();
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
      List<OrderCustomer> filteredOrders = listOrderCustomer.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListOrderCustomer.assignAll(filteredOrders);
    } else {
      List<OrderCustomer> filteredOrders = listOrderCustomer.where((order) {
        if (activeButtonIndex.value == 0) {
          return order.status == 'PENDING';
        } else if (activeButtonIndex.value == 1) {
          return order.status == 'DONE';
        } else {
          return order.status == 'CANCEL';
        }
      }).toList();
      searchListOrderCustomer.assignAll(
        filteredOrders.where((data) {
          return data.orderCode
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }
}
