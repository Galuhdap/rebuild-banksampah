import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/customer_deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/customer/detail_deposit_trash_customer_screen.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/widget/menu_button_widget.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_deposit_trash_response.dart';

class DepositTrashCustomerScreen extends StatelessWidget {
  const DepositTrashCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerDepositTrashController>(
        init: CustomerDepositTrashController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppConstants.LABEL_DEPOSIT_TRASH,
                style:
                    Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.offAndToNamed(AppRoutes.home);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.colorBaseBlack,
                ),
              ),
            ),
            body: Column(
              children: [
                SearchComponent(
                  controller: controller.searchDepositTrash,
                  onTap: () {},
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                    controller.filterSearchTrash();
                  },
                ),
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
                                // controller.searchOrderSeeAdmin.clear();
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
                                // controller.searchOrderSeeAdmin.clear();
                                controller.searchQuery.value = '';
                                controller.setActiveButton(1);
                              },
                              isActive: controller.activeButtonIndex.value == 1,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: AppSizes.s44);
                    })
                  ],
                ),
                AppSizes.s10.height,
                Obx(
                  () {
                    List<DepositTrash> filteredTrash =
                        controller.listDepositTrash.where((order) {
                      if (controller.activeButtonIndex.value == 0) {
                        return order.status == 'PENDING';
                      } else {
                        return order.status == 'DONE';
                      }
                    }).toList();

                    return controller.isloadingDepositTrash.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : filteredTrash.isEmpty
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
                                        'Tidak ada data yang bisa ditampilkan sekarang.',
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
                                  itemCount: controller.searchQuery.isNotEmpty
                                      ? controller.searchDepositTrashs.length
                                      : filteredTrash.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = controller.searchQuery.isNotEmpty
                                        ? controller.searchDepositTrashs[index]
                                        : filteredTrash[index];
                                    String totalWeight = data.deposits
                                        .map((deposit) => deposit.weight)
                                        .reduce((a, b) => a + b)
                                        .toString();
                                    return TransactionCardComponent(
                                        kode: data.user.profile.kdUser,
                                        label: data.status,
                                        date: data.createdAt
                                            .toDateddmmmyyyyFormattedString(),
                                        amount: '${totalWeight} Kg',
                                        isStatus: false,
                                        onTap: () {
                                          Get.to(
                                            DetailDepositTrashCustomerScreen(
                                              data: data,
                                            ),
                                          );
                                        });
                                  },
                                ),
                              );
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: AppSizes.s20),
          );
        });
  }
}
