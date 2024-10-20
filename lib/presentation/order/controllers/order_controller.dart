import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/message_component.dart';
import 'package:rebuild_bank_sampah/di/application_module.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_customer_response.dart';
import 'package:rebuild_bank_sampah/services/order/repository/order_admin_data_repository.dart';

class OrderController extends GetxController {
  final OrderAdminDataRepository repository = locator();
  RxInt activeButtonIndex = 0.obs;
  RxList<OrderCustomer> listOrderCustomer = <OrderCustomer>[].obs;
  RxList<OrderCustomer> searchListOrderCustomer = <OrderCustomer>[].obs;
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
          // if (listOrder.isNotEmpty) {
          //   switch (listOrder.first.status) {
          //     case 'PENDING':
          //       setActiveButton(0);
          //       break;
          //     case 'DONE':
          //       setActiveButton(1);
          //       break;
          //     case 'CANCEL':
          //       setActiveButton(2);
          //       break;
          //     default:
          //       break;
          //   }
          // }
          update();
        },
      );
      isLoadingOrder.value = false;
    } catch (e) {
      print('e:$e');
      isLoadingOrder.value = false;
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
