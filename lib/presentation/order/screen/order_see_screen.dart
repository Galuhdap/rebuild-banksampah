import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/order/controllers/order_controller.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/detail_order_screen.dart';
import 'package:rebuild_bank_sampah/presentation/order/widgets/card_order_item.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_customer_response.dart';

class OrderSeeScreen extends StatelessWidget {
  const OrderSeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            // Kondisi yang diinginkan saat tombol back ditekan
            bool shouldNavigate = true; // Sesuaikan kondisinya

            if (shouldNavigate) {
              // Navigasi ke halaman home menggunakan Get.offAndToNamed
              Get.offAllNamed(AppRoutes.home);
              return false; // Mencegah pop langsung, kita kontrol manual navigasinya
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppConstants.ACTION_ORDER,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.home);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.colorBaseBlack,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchComponent(
                  controller: controller.searchOrderSeeAdmin,
                  onTap: () {},
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.filterSearchTrash();
                  },
                ).paddingSymmetric(horizontal: AppSizes.s16),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Divider(
                      color: AppColors.colorNeutrals100,
                      thickness: 1,
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          Flexible(
                            child: MenuButtonWidget(
                              label: AppConstants.ACTION_PENDING,
                              onTap: () {
                                controller.searchOrderSeeAdmin.clear();
                                controller.searchQuery.value = '';
                                controller.setActiveButton(0);
                              },
                              isActive: controller.activeButtonIndex.value == 0,
                            ),
                          ),
                          AppSizes.s30.width,
                          Flexible(
                            child: MenuButtonWidget(
                              label: AppConstants.ACTION_FINISH,
                              onTap: () {
                                controller.searchOrderSeeAdmin.clear();
                                controller.searchQuery.value = '';
                                controller.setActiveButton(1);
                              },
                              isActive: controller.activeButtonIndex.value == 1,
                            ),
                          ),
                          AppSizes.s30.width,
                          Flexible(
                            child: MenuButtonWidget(
                              label: AppConstants.ACTION_CENCEL,
                              onTap: () {
                                controller.searchOrderSeeAdmin.clear();
                                controller.searchQuery.value = '';
                                controller.setActiveButton(2);
                              },
                              isActive: controller.activeButtonIndex.value == 2,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: AppSizes.s44);
                    })
                  ],
                ),
                AppSizes.s5.height,
                Obx(
                  () {
                    List<OrderCustomer> filteredOrders =
                        controller.listOrderCustomer.where((order) {
                      if (controller.activeButtonIndex.value == 0) {
                        return order.status == 'PENDING';
                      } else if (controller.activeButtonIndex.value == 1) {
                        return order.status == 'DONE';
                      } else {
                        return order.status == 'CANCEL';
                      }
                    }).toList();
                    return controller.isLoadingOrder.value
                        ? Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(Assets.lottie.loadingLogin),
                          ),
                        )
                        : filteredOrders.isEmpty
                            ? Container(
                                padding: AppSizes.symmetricPadding(
                                    vertical: AppSizes.s150),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Assets.images.emptyData.image(scale: 4),
                                      Text(
                                        'Data Kosong',
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(fontSize: AppSizes.s18),
                                      ),
                                      Text(
                                        'Tidak ada pesanan untuk status ini.',
                                        style: Get.textTheme.titleLarge!
                                            .copyWith(
                                                fontSize: AppSizes.s12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding:
                                      AppSizes.onlyPadding(top: AppSizes.s15),
                                  itemCount: controller.searchQuery.isNotEmpty
                                      ? controller
                                          .searchListOrderCustomer.length
                                      : filteredOrders.length,
                                  itemBuilder: (BuildContext context, index) {
                                    OrderCustomer order =
                                        controller.searchQuery.isNotEmpty
                                            ? controller
                                                .searchListOrderCustomer[index]
                                            : filteredOrders[index];
                                    return CardOrderItem(
                                      date: order.createdAt
                                          .toFormattedDateDayTimeString(),
                                      price: order.totalPrice.currencyFormatRp,
                                      invoice: order.orderCode,
                                      statusColor:
                                          controller.activeButtonIndex.value ==
                                                  0
                                              ? AppColors.colorWarning300
                                              : controller.activeButtonIndex
                                                          .value ==
                                                      1
                                                  ? AppColors.colorPrimary800
                                                  : AppColors.colorBaseError,
                                      onTap: () {
                                        Get.to(DetailOrderScreen(
                                          data: order,
                                        ));
                                      },
                                    );
                                  },
                                ),
                              );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
