import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/order/controllers/order_admin_koprasi_controller.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/detail_order_admin_koprasi_screen.dart';
import 'package:rebuild_bank_sampah/presentation/order/widgets/card_order_admin_item.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_response.dart';

class OrderSeeAdminKoprasiScreen extends StatelessWidget {
  const OrderSeeAdminKoprasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderAdminKoprasiController>(
      init: OrderAdminKoprasiController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppConstants.ACTION_ORDER,
              style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
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
                  // Filter listOrder berdasarkan status sesuai activeButtonIndex
                  List<OrderAdmin> filteredOrders =
                      controller.listOrder.where((order) {
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
                          child: CircularProgressIndicator(),
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
                                      style: Get.textTheme.titleLarge!.copyWith(
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
                                    ? controller.searchListOrder.length
                                    : filteredOrders.length,
                                itemBuilder: (BuildContext context, index) {
                                  OrderAdmin order =
                                      controller.searchQuery.isNotEmpty
                                          ? controller.searchListOrder[index]
                                          : filteredOrders[index];
                                  return CardOrderItemAdminWidget(
                                    username: order.user.profile.name,
                                    date: order.createdAt
                                        .toFormattedDateDayTimeString(), // Sesuaikan dengan atribut yang tepat
                                    price: order.totalPrice
                                        .currencyFormatRp, // Sesuaikan dengan format harga
                                    invoice: order
                                        .orderCode, // Sesuaikan dengan atribut invoice
                                    statusColor:
                                        controller.activeButtonIndex.value == 0
                                            ? AppColors.colorWarning300
                                            : controller.activeButtonIndex
                                                        .value ==
                                                    1
                                                ? AppColors.colorPrimary800
                                                : AppColors.colorBaseError,
                                    onTap: () {
                                      Get.to(DetailOrderAdminKoprasiScreen(
                                        data: order,
                                      ));
                                    },
                                  );
                                },
                              ),
                            );
                },
              ),

              // Obx(
              //   () {
              //     return controller.activeButtonIndex.value == 0
              //         ? Expanded(
              //             child: ListView.builder(
              //               padding: AppSizes.onlyPadding(top: AppSizes.s15),
              //               itemCount: 10,
              //               itemBuilder: (BuildContext context, index) {
              //                 return CardOrderItem(
              //                   date: '26 Juli 2024, 16:08',
              //                   price: 'Rp. 15.0000',
              //                   invoice: 'P-7I539743',
              //                   statusColor: AppColors.colorWarning300,
              //                   onTap: () {
              //                     Get.toNamed(AppRoutes.detailOrder);
              //                   },
              //                 );
              //               },
              //             ),
              //           )
              //         : controller.activeButtonIndex.value == 1
              //             ? Expanded(
              //                 child: ListView.builder(
              //                   padding:
              //                       AppSizes.onlyPadding(top: AppSizes.s15),
              //                   itemCount: 10,
              //                   itemBuilder: (BuildContext context, index) {
              //                     return CardOrderItem(
              //                       date: '26 Juli 2024, 16:08',
              //                       price: 'Rp. 15.000',
              //                       invoice: 'P-7I88888',
              //                       statusColor: AppColors.colorPrimary800,
              //                       onTap: () {
              //                         Get.toNamed(AppRoutes.detailOrder);
              //                       },
              //                     );
              //                   },
              //                 ),
              //               )
              //             : Expanded(
              //                 child: ListView.builder(
              //                   padding:
              //                       AppSizes.onlyPadding(top: AppSizes.s15),
              //                   itemCount: 10,
              //                   itemBuilder: (BuildContext context, index) {
              //                     return CardOrderItem(
              //                       date: '26 Juli 2024, 16:08',
              //                       price: 'Rp. 15.000',
              //                       invoice: 'P-7I66666',
              //                       statusColor: AppColors.colorBaseError,
              //                       onTap: () {
              //                         Get.toNamed(AppRoutes.detailOrder);
              //                       },
              //                     );
              //                   },
              //                 ),
              //               );
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
