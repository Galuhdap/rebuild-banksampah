import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/component/update_delete_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class SetorSampahScreen extends StatefulWidget {
  const SetorSampahScreen({super.key});

  @override
  State<SetorSampahScreen> createState() => _SetorSampahScreenState();
}

class _SetorSampahScreenState extends State<SetorSampahScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositTrashController>(
        init: DepositTrashController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.selectedCustomerId.value = '';
                controller.selectedTrashId.value = '';
                controller.weight.text = '';
                controller.totalPriceTrash.value = 0;
                Get.toNamed(AppRoutes.addTrashDeposit);
              },
              backgroundColor: AppColors.colorBasePrimary,
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: AppSizes.s35,
              ),
            ),
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
                Obx(
                  () {
                    return controller.isloadingDepositTrash.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.listDepositTrash.isEmpty
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
                                      : controller.listDepositTrash.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var data = controller.searchQuery.isNotEmpty
                                        ? controller.searchDepositTrashs[index]
                                        : controller.listDepositTrash[index];
                                    return TransactionCardComponent(
                                      kode: data.user.profile.kdUser,
                                      label: data.user.profile.name,
                                      date: data.createdAt
                                          .toDateddmmmyyyyFormattedString(),
                                      amount: '${data.weight} Kg',
                                      isStatus: false,
                                      onTap: () {
                                        showModalBottom(
                                          context,
                                          Column(
                                            children: [
                                              AppSizes.s8.height,
                                              Center(
                                                child: Container(
                                                  width: AppSizes.s56,
                                                  height: AppSizes.s4,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppSizes.s8),
                                                      color: AppColors
                                                          .colorNeutrals800),
                                                ),
                                              ),
                                              // AppSizes.s30.height,
                                              // UDWidget(
                                              //   onTap: () async {
                                              //     // await controller
                                              //     //     .deleteDepositTrash(
                                              //     //         data.id,
                                              //     //         context);
                                              //     //     showDepositTrashDialog(
                                              //     //         context,
                                              //     //         AppConstants
                                              //     //             .LABEL_EDIT_DEPOSIT_TRASH);
                                              //   },
                                              //   name: AppConstants
                                              //       .LABEL_EDIT_PROFILE,
                                              //   icon: Icons.create_rounded,
                                              // ),
                                              AppSizes.s30.height,
                                              Obx(
                                                () {
                                                  return controller
                                                          .isloadingDeleteDepositTrash
                                                          .value
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : UDWidget(
                                                          onTap: () async {
                                                            await controller
                                                                .deleteDepositTrash(
                                                                    data.id,
                                                                    context);
                                                          },
                                                          name: AppConstants
                                                              .LABEL_DELETE,
                                                          icon: Icons.delete,
                                                        );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
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
