import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/order/controllers/order_controller.dart';
import 'package:rebuild_bank_sampah/presentation/order/widgets/card_order_item.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class OrderSeeScreen extends StatelessWidget {
  const OrderSeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppConstants.ACTION_ORDER,
              style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
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
              AppSizes.s12.height,
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
                  return controller.activeButtonIndex.value == 0
                      ? Expanded(
                          child: ListView.builder(
                            padding: AppSizes.onlyPadding(top: AppSizes.s15),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, index) {
                              return CardOrderItem(
                                date: '26 Juli 2024, 16:08',
                                price: 'Rp. 15.0000',
                                invoice: 'P-7I539743',
                                statusColor: AppColors.colorWarning300,
                                onTap: () {
                                  Get.toNamed(AppRoutes.detailOrder);
                                },
                              );
                            },
                          ),
                        )
                      : controller.activeButtonIndex.value == 1
                          ? Expanded(
                              child: ListView.builder(
                                padding:
                                    AppSizes.onlyPadding(top: AppSizes.s15),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, index) {
                                  return CardOrderItem(
                                    date: '26 Juli 2024, 16:08',
                                    price: 'Rp. 15.000',
                                    invoice: 'P-7I88888',
                                    statusColor: AppColors.colorPrimary800,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.detailOrder);
                                    },
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding:
                                    AppSizes.onlyPadding(top: AppSizes.s15),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, index) {
                                  return CardOrderItem(
                                    date: '26 Juli 2024, 16:08',
                                    price: 'Rp. 15.000',
                                    invoice: 'P-7I66666',
                                    statusColor: AppColors.colorBaseError,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.detailOrder);
                                    },
                                  );
                                },
                              ),
                            );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
