import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/search_component.dart';
import 'package:rebuild_bank_sampah/core/component/transaction_card_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/dialog/show_deposit_trash_dialog.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/trash/controllers/deposit_trash_controller.dart';

class SetorSampahScreen extends StatelessWidget {
  const SetorSampahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositTrashController>(
        init: DepositTrashController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // controller.getTrash();
                showDepositTrashDialog(
                    context, AppConstants.LABEL_DEPOSIT_TRASH);
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
                  Get.back();
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
                    controller: controller.searchDepositTrash, onTap: () {}),
                
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, index) {
                      return TransactionCardComponent(
                        kode: 'KP - 001',
                        label: 'Mutiara Ayu',
                        date: '26 Juli 2024',
                        amount: '2 Kg',
                        isStatus: false,
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: AppSizes.s200,
                                padding: AppSizes.symmetricPadding(
                                    horizontal: AppSizes.s24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppSizes.s16),
                                    topRight: Radius.circular(AppSizes.s16),
                                  ),
                                  color: AppColors.colorBaseWhite,
                                ),
                                child: Column(
                                  children: [
                                    AppSizes.s16.height,
                                    Center(
                                      child: Container(
                                        width: AppSizes.s40,
                                        height: AppSizes.s4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.s2),
                                            color: AppColors.colorNeutrals200),
                                      ),
                                    ),
                                    AppSizes.s26.height,
                                    InkWell(
                                      onTap: () {
                                        showDepositTrashDialog(
                                            context,
                                            AppConstants
                                                .LABEL_EDIT_DEPOSIT_TRASH);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.create_rounded,
                                            color: AppColors.colorPrimary600,
                                          ),
                                          AppSizes.s24.width,
                                          Text(
                                            AppConstants.LABEL_EDIT_PROFILE,
                                            style: Get.textTheme.titleLarge!
                                                .copyWith(
                                                    fontSize: AppSizes.s18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppSizes.s37.height,
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: AppColors.colorBaseError,
                                        ),
                                        AppSizes.s24.width,
                                        Text(
                                          AppConstants.LABEL_DELETE,
                                          style: Get.textTheme.titleLarge!
                                              .copyWith(fontSize: AppSizes.s18),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: AppSizes.s20),
          );
        });
  }
}
